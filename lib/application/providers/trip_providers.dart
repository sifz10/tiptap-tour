import 'package:drift/drift.dart' show Value;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:tiptap_tour/application/providers/database_provider.dart';
import 'package:tiptap_tour/core/utils/hlc.dart';
import 'package:tiptap_tour/domain/entities/p2p_peer.dart';
import 'package:tiptap_tour/infrastructure/database/app_database.dart';
import 'package:uuid/uuid.dart';

/// Watches all trips as a stream, ordered by most recently updated.
final tripsProvider = StreamProvider<List<Trip>>((ref) {
  final db = ref.watch(databaseProvider);
  return db.tripDao.watchAllTrips();
});

/// Gets only active (non-archived) trips.
final activeTripsProvider = FutureProvider<List<Trip>>((ref) {
  final db = ref.watch(databaseProvider);
  return db.tripDao.getActiveTrips();
});

/// Gets a single trip by its ID.
final tripByIdProvider = FutureProvider.family<Trip?, String>((ref, tripId) {
  final db = ref.watch(databaseProvider);
  return db.tripDao.getTripById(tripId);
});

/// Gets members for a given trip.
final tripMembersProvider =
    FutureProvider.family<List<TripMember>, String>((ref, tripId) {
  final db = ref.watch(databaseProvider);
  return db.tripDao.getMembersByTripId(tripId);
});

/// Notifier for creating a new trip with its creator as an admin member.
class CreateTripNotifier extends StateNotifier<AsyncValue<void>> {
  CreateTripNotifier(this._db) : super(const AsyncValue.data(null));

  final AppDatabase _db;

  Future<String> createTrip({
    required String name,
    String? description,
    String baseCurrency = 'BDT',
    required String createdByUserId,
    DateTime? startDate,
    DateTime? endDate,
  }) async {
    state = const AsyncValue.loading();
    try {
      final uuid = const Uuid();
      final tripId = uuid.v4();
      final now = DateTime.now().millisecondsSinceEpoch;
      final hlc = HLC.now(createdByUserId).toString();

      await _db.tripDao.insertTrip(
        TripsCompanion(
          id: Value(tripId),
          name: Value(name),
          description: Value(description),
          baseCurrency: Value(baseCurrency),
          createdBy: Value(createdByUserId),
          startDate: Value(startDate?.millisecondsSinceEpoch),
          endDate: Value(endDate?.millisecondsSinceEpoch),
          createdAt: Value(now),
          updatedAt: Value(now),
          hlcTimestamp: Value(hlc),
        ),
      );

      await _db.tripDao.addMember(
        TripMembersCompanion(
          tripId: Value(tripId),
          userId: Value(createdByUserId),
          role: const Value('admin'),
          joinedAt: Value(now),
        ),
      );

      state = const AsyncValue.data(null);
      return tripId;
    } catch (e, st) {
      state = AsyncValue.error(e, st);
      rethrow;
    }
  }
}

final createTripProvider =
    StateNotifierProvider<CreateTripNotifier, AsyncValue<void>>((ref) {
  final db = ref.watch(databaseProvider);
  return CreateTripNotifier(db);
});

class AddPeerToTripNotifier extends StateNotifier<AsyncValue<void>> {
  AddPeerToTripNotifier(this._db) : super(const AsyncValue.data(null));

  final AppDatabase _db;

  Future<void> addPeerToTrip({
    required P2PPeer peer,
    required String tripId,
  }) async {
    state = const AsyncValue.loading();
    try {
      final now = DateTime.now().millisecondsSinceEpoch;
      final userId = peer.deviceId;
      final settingsBox = Hive.box('settings');
      final localUserId =
          settingsBox.get('userId', defaultValue: 'unknown') as String;
      final hlc = HLC.now(localUserId).toString();

      await _db.userDao.upsertUser(
        UsersCompanion(
          id: Value(userId),
          displayName: Value(peer.displayName),
          deviceId: Value(userId),
          createdAt: Value(now),
          hlcTimestamp: Value(hlc),
        ),
      );

      await _db.tripDao.addMember(
        TripMembersCompanion(
          tripId: Value(tripId),
          userId: Value(userId),
          role: const Value('member'),
          joinedAt: Value(now),
        ),
      );

      state = const AsyncValue.data(null);
    } catch (e, st) {
      state = AsyncValue.error(e, st);
      rethrow;
    }
  }
}

final addPeerToTripProvider =
    StateNotifierProvider<AddPeerToTripNotifier, AsyncValue<void>>((ref) {
  final db = ref.watch(databaseProvider);
  return AddPeerToTripNotifier(db);
});
