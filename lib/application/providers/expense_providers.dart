import 'package:drift/drift.dart' show Value;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tiptap_tour/application/providers/chat_providers.dart';
import 'package:tiptap_tour/application/providers/database_provider.dart';
import 'package:tiptap_tour/application/providers/p2p_providers.dart';
import 'package:tiptap_tour/core/utils/currency_formatter.dart';
import 'package:tiptap_tour/core/utils/hlc.dart';
import 'package:tiptap_tour/domain/enums/split_type.dart';
import 'package:tiptap_tour/infrastructure/database/app_database.dart';
import 'package:uuid/uuid.dart';

/// Watches expenses for a trip as a stream, ordered by most recent.
final expensesByTripProvider =
    StreamProvider.family<List<Expense>, String>((ref, tripId) {
  final db = ref.watch(databaseProvider);
  return db.expenseDao.watchExpensesByTripId(tripId);
});

/// Gets a single expense by its ID.
final expenseByIdProvider =
    FutureProvider.family<Expense?, String>((ref, id) {
  final db = ref.watch(databaseProvider);
  return db.expenseDao.getExpenseById(id);
});

/// Gets net balances for each user in a trip.
/// Positive = owed money, negative = owes money.
final balancesByTripProvider =
    FutureProvider.family<Map<String, double>, String>((ref, tripId) {
  final db = ref.watch(databaseProvider);
  return db.expenseDao.getBalancesByTripId(tripId);
});

/// Gets all settlements for a trip.
final settlementsByTripProvider =
    FutureProvider.family<List<Settlement>, String>((ref, tripId) {
  final db = ref.watch(databaseProvider);
  return db.expenseDao.getSettlementsByTripId(tripId);
});

/// Notifier for adding an expense with splits.
class AddExpenseNotifier extends StateNotifier<AsyncValue<void>> {
  AddExpenseNotifier(this._db, this._ref) : super(const AsyncValue.data(null));

  final AppDatabase _db;
  final Ref _ref;

  Future<String> addExpense({
    required String tripId,
    required String paidBy,
    required String title,
    required double amount,
    required String category,
    required SplitType splitType,
    required Map<String, double> splits,
    String? notes,
    String currency = 'BDT',
  }) async {
    state = const AsyncValue.loading();
    try {
      final uuid = const Uuid();
      final expenseId = uuid.v4();
      final now = DateTime.now().millisecondsSinceEpoch;
      final hlc = HLC.now(paidBy).toString();

      final expenseCompanion = ExpensesCompanion(
        id: Value(expenseId),
        tripId: Value(tripId),
        paidBy: Value(paidBy),
        title: Value(title),
        amount: Value(amount),
        currency: Value(currency),
        category: Value(category),
        splitType: Value(splitType.name),
        notes: Value(notes),
        expenseDate: Value(now),
        createdAt: Value(now),
        updatedAt: Value(now),
        hlcTimestamp: Value(hlc),
      );

      final splitCompanions = splits.entries.map((entry) {
        return ExpenseSplitsCompanion(
          id: Value(uuid.v4()),
          expenseId: Value(expenseId),
          userId: Value(entry.key),
          amount: Value(entry.value),
          hlcTimestamp: Value(hlc),
        );
      }).toList();

      await _db.expenseDao.insertExpenseWithSplits(
        expenseCompanion,
        splitCompanions,
      );

      final syncEngine = _ref.read(syncEngineProvider);
      await syncEngine.recordChange(
        tableName: 'expenses',
        recordId: expenseId,
        operation: 'insert',
        data: {
          'id': expenseId,
          'tripId': tripId,
          'paidBy': paidBy,
          'title': title,
          'amount': amount,
          'currency': currency,
          'category': category,
          'splitType': splitType.name,
          'notes': notes,
          'expenseDate': now,
          'createdAt': now,
          'updatedAt': now,
          'hlcTimestamp': hlc,
        },
      );

      for (final split in splitCompanions) {
        await syncEngine.recordChange(
          tableName: 'expense_splits',
          recordId: split.id.value,
          operation: 'insert',
          data: {
            'id': split.id.value,
            'expenseId': expenseId,
            'userId': split.userId.value,
            'amount': split.amount.value,
            'hlcTimestamp': hlc,
          },
        );
      }

      final formatted = CurrencyFormatter.format(amount, currency: currency);
      _ref.read(sendMessageProvider.notifier).sendSystemMessage(
            tripId: tripId,
            content: 'added "$title" for $formatted',
            messageType: 'expenseUpdate',
          );

      state = const AsyncValue.data(null);
      return expenseId;
    } catch (e, st) {
      state = AsyncValue.error(e, st);
      rethrow;
    }
  }
}

final addExpenseProvider =
    StateNotifierProvider<AddExpenseNotifier, AsyncValue<void>>((ref) {
  final db = ref.watch(databaseProvider);
  return AddExpenseNotifier(db, ref);
});

/// Notifier for settling a debt between two users.
class SettleUpNotifier extends StateNotifier<AsyncValue<void>> {
  SettleUpNotifier(this._db, this._ref) : super(const AsyncValue.data(null));

  final AppDatabase _db;
  final Ref _ref;

  Future<String> settle({
    required String tripId,
    required String payerId,
    required String payeeId,
    required double amount,
    String? notes,
    String currency = 'BDT',
  }) async {
    state = const AsyncValue.loading();
    try {
      final uuid = const Uuid();
      final settlementId = uuid.v4();
      final now = DateTime.now().millisecondsSinceEpoch;
      final hlc = HLC.now(payerId).toString();

      await _db.expenseDao.insertSettlement(
        SettlementsCompanion(
          id: Value(settlementId),
          tripId: Value(tripId),
          payerId: Value(payerId),
          payeeId: Value(payeeId),
          amount: Value(amount),
          currency: Value(currency),
          settledAt: Value(now),
          notes: Value(notes),
          hlcTimestamp: Value(hlc),
        ),
      );

      final syncEngine = _ref.read(syncEngineProvider);
      await syncEngine.recordChange(
        tableName: 'settlements',
        recordId: settlementId,
        operation: 'insert',
        data: {
          'id': settlementId,
          'tripId': tripId,
          'payerId': payerId,
          'payeeId': payeeId,
          'amount': amount,
          'currency': currency,
          'settledAt': now,
          'notes': notes,
          'hlcTimestamp': hlc,
        },
      );

      final formatted = CurrencyFormatter.format(amount, currency: currency);
      _ref.read(sendMessageProvider.notifier).sendSystemMessage(
            tripId: tripId,
            content: 'settled $formatted',
            messageType: 'expenseUpdate',
          );

      state = const AsyncValue.data(null);
      return settlementId;
    } catch (e, st) {
      state = AsyncValue.error(e, st);
      rethrow;
    }
  }
}

final settleUpProvider =
    StateNotifierProvider<SettleUpNotifier, AsyncValue<void>>((ref) {
  final db = ref.watch(databaseProvider);
  return SettleUpNotifier(db, ref);
});
