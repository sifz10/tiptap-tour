import 'package:drift/drift.dart';
import 'package:tiptap_tour/infrastructure/database/app_database.dart';
import 'package:tiptap_tour/infrastructure/database/tables/expenses_table.dart';
import 'package:tiptap_tour/infrastructure/database/tables/settlements_table.dart';

part 'expense_dao.g.dart';

@DriftAccessor(tables: [Expenses, ExpenseSplits, Settlements])
class ExpenseDao extends DatabaseAccessor<AppDatabase> with _$ExpenseDaoMixin {
  ExpenseDao(super.db);

  Future<List<Expense>> getExpensesByTripId(String tripId) =>
      (select(expenses)
            ..where(
                (e) => e.tripId.equals(tripId) & e.isDeleted.equals(false))
            ..orderBy([(e) => OrderingTerm.desc(e.expenseDate)]))
          .get();

  Future<Expense?> getExpenseById(String id) =>
      (select(expenses)..where((e) => e.id.equals(id))).getSingleOrNull();

  Stream<List<Expense>> watchExpensesByTripId(String tripId) =>
      (select(expenses)
            ..where(
                (e) => e.tripId.equals(tripId) & e.isDeleted.equals(false))
            ..orderBy([(e) => OrderingTerm.desc(e.expenseDate)]))
          .watch();

  Future<void> insertExpenseWithSplits(
    ExpensesCompanion expense,
    List<ExpenseSplitsCompanion> splits,
  ) {
    return transaction(() async {
      await into(expenses).insert(expense);
      for (final split in splits) {
        await into(expenseSplits).insert(split);
      }
    });
  }

  Future<void> updateExpenseWithSplits(
    ExpensesCompanion expense,
    List<ExpenseSplitsCompanion> splits,
  ) {
    return transaction(() async {
      await (update(expenses)..where((e) => e.id.equals(expense.id.value)))
          .write(expense);
      await (delete(expenseSplits)
            ..where((s) => s.expenseId.equals(expense.id.value)))
          .go();
      for (final split in splits) {
        await into(expenseSplits).insert(split);
      }
    });
  }

  Future<void> softDeleteExpense(String id, String hlcTimestamp) =>
      (update(expenses)..where((e) => e.id.equals(id))).write(
        ExpensesCompanion(
          isDeleted: const Value(true),
          hlcTimestamp: Value(hlcTimestamp),
        ),
      );

  Future<List<ExpenseSplit>> getSplitsByExpenseId(String expenseId) =>
      (select(expenseSplits)..where((s) => s.expenseId.equals(expenseId)))
          .get();

  Future<Map<String, double>> getBalancesByTripId(String tripId) async {
    final allExpenses = await getExpensesByTripId(tripId);
    final balances = <String, double>{};

    for (final expense in allExpenses) {
      balances[expense.paidBy] =
          (balances[expense.paidBy] ?? 0) + expense.amount;

      final splits = await getSplitsByExpenseId(expense.id);
      for (final split in splits) {
        balances[split.userId] =
            (balances[split.userId] ?? 0) - split.amount;
      }
    }

    final allSettlements = await getSettlementsByTripId(tripId);
    for (final settlement in allSettlements) {
      balances[settlement.payerId] =
          (balances[settlement.payerId] ?? 0) + settlement.amount;
      balances[settlement.payeeId] =
          (balances[settlement.payeeId] ?? 0) - settlement.amount;
    }

    return balances;
  }

  Future<void> insertSettlement(SettlementsCompanion settlement) =>
      into(settlements).insert(settlement);

  Future<List<Settlement>> getSettlementsByTripId(String tripId) =>
      (select(settlements)
            ..where(
                (s) => s.tripId.equals(tripId) & s.isDeleted.equals(false))
            ..orderBy([(s) => OrderingTerm.desc(s.settledAt)]))
          .get();
}
