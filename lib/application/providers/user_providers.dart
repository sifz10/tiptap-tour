import 'package:drift/drift.dart' show Value;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:tiptap_tour/application/providers/database_provider.dart';
import 'package:tiptap_tour/core/utils/hlc.dart';
import 'package:tiptap_tour/infrastructure/database/app_database.dart';
import 'package:uuid/uuid.dart';

/// Gets the current user from the Hive settings box (stored userId) + database.
/// Returns null if no user has been created yet (pre-onboarding).
final currentUserProvider = FutureProvider<User?>((ref) async {
  final db = ref.watch(databaseProvider);
  final settingsBox = Hive.box('settings');
  final userId = settingsBox.get('userId') as String?;
  if (userId == null) return null;
  return db.userDao.getUserById(userId);
});

/// Gets all users that are members of a given trip.
final usersByTripProvider =
    FutureProvider.family<List<User>, String>((ref, tripId) {
  final db = ref.watch(databaseProvider);
  return db.userDao.getUsersByTripId(tripId);
});

/// Notifier for creating a user profile during onboarding.
class CreateUserNotifier extends StateNotifier<AsyncValue<void>> {
  CreateUserNotifier(this._db) : super(const AsyncValue.data(null));

  final AppDatabase _db;

  /// Creates a new user, persists to DB, and stores the userId in Hive settings.
  Future<String> createUser({
    required String displayName,
    String? avatarPath,
  }) async {
    state = const AsyncValue.loading();
    try {
      final uuid = const Uuid();
      final userId = uuid.v4();
      final deviceId = uuid.v4();
      final now = DateTime.now().millisecondsSinceEpoch;
      final hlc = HLC.now(userId).toString();

      await _db.userDao.insertUser(
        UsersCompanion(
          id: Value(userId),
          displayName: Value(displayName),
          avatarPath: Value(avatarPath),
          deviceId: Value(deviceId),
          createdAt: Value(now),
          hlcTimestamp: Value(hlc),
        ),
      );

      final settingsBox = Hive.box('settings');
      await settingsBox.put('userId', userId);
      await settingsBox.put('displayName', displayName);

      state = const AsyncValue.data(null);
      return userId;
    } catch (e, st) {
      state = AsyncValue.error(e, st);
      rethrow;
    }
  }
}

final createUserProvider =
    StateNotifierProvider<CreateUserNotifier, AsyncValue<void>>((ref) {
  final db = ref.watch(databaseProvider);
  return CreateUserNotifier(db);
});
