import 'package:drift/drift.dart' show Value;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:tiptap_tour/application/providers/database_provider.dart';
import 'package:tiptap_tour/application/providers/p2p_providers.dart';
import 'package:tiptap_tour/core/utils/hlc.dart';
import 'package:tiptap_tour/domain/entities/p2p_peer.dart';
import 'package:tiptap_tour/infrastructure/database/app_database.dart';
import 'package:tiptap_tour/infrastructure/sync/sync_engine.dart';
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
  CreateTripNotifier(this._db, this._syncEngine)
      : super(const AsyncValue.data(null));

  final AppDatabase _db;
  final SyncEngine _syncEngine;

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

      final startMs = startDate?.millisecondsSinceEpoch;
      final endMs = endDate?.millisecondsSinceEpoch;

      await _db.tripDao.insertTrip(
        TripsCompanion(
          id: Value(tripId),
          name: Value(name),
          description: Value(description),
          baseCurrency: Value(baseCurrency),
          createdBy: Value(createdByUserId),
          startDate: Value(startMs),
          endDate: Value(endMs),
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

      await _syncEngine.recordChange(
        tableName: 'trips',
        recordId: tripId,
        operation: 'insert',
        data: {
          'id': tripId,
          'name': name,
          'description': description,
          'baseCurrency': baseCurrency,
          'createdBy': createdByUserId,
          'startDate': startMs,
          'endDate': endMs,
          'createdAt': now,
          'updatedAt': now,
          'hlcTimestamp': hlc,
        },
      );

      await _syncEngine.recordChange(
        tableName: 'trip_members',
        recordId: '${tripId}_$createdByUserId',
        operation: 'insert',
        data: {
          'tripId': tripId,
          'userId': createdByUserId,
          'role': 'admin',
          'joinedAt': now,
        },
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
  final syncEngine = ref.watch(syncEngineProvider);
  return CreateTripNotifier(db, syncEngine);
});

class AddPeerToTripNotifier extends StateNotifier<AsyncValue<void>> {
  AddPeerToTripNotifier(this._db, this._syncEngine)
      : super(const AsyncValue.data(null));

  final AppDatabase _db;
  final SyncEngine _syncEngine;

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

      await _syncEngine.recordChange(
        tableName: 'users',
        recordId: userId,
        operation: 'insert',
        data: {
          'id': userId,
          'displayName': peer.displayName,
          'deviceId': userId,
          'createdAt': now,
          'hlcTimestamp': hlc,
        },
      );

      await _syncEngine.recordChange(
        tableName: 'trip_members',
        recordId: '${tripId}_$userId',
        operation: 'insert',
        data: {
          'tripId': tripId,
          'userId': userId,
          'role': 'member',
          'joinedAt': now,
        },
      );

      // Also queue the trip itself so the peer's device receives it
      final trip = await _db.tripDao.getTripById(tripId);
      if (trip != null) {
        await _syncEngine.recordChange(
          tableName: 'trips',
          recordId: tripId,
          operation: 'insert',
          data: {
            'id': trip.id,
            'name': trip.name,
            'description': trip.description,
            'baseCurrency': trip.baseCurrency,
            'createdBy': trip.createdBy,
            'startDate': trip.startDate,
            'endDate': trip.endDate,
            'createdAt': trip.createdAt,
            'updatedAt': trip.updatedAt,
            'hlcTimestamp': trip.hlcTimestamp,
          },
        );

        // Queue the local user as a member too so the peer sees all members
        await _syncEngine.recordChange(
          tableName: 'users',
          recordId: localUserId,
          operation: 'insert',
          data: {
            'id': localUserId,
            'displayName':
                settingsBox.get('displayName', defaultValue: 'Unknown'),
            'deviceId': localUserId,
            'createdAt': now,
            'hlcTimestamp': hlc,
          },
        );

        await _syncEngine.recordChange(
          tableName: 'trip_members',
          recordId: '${tripId}_$localUserId',
          operation: 'insert',
          data: {
            'tripId': tripId,
            'userId': localUserId,
            'role': 'admin',
            'joinedAt': now,
          },
        );
      }

      // Auto-sync with the peer so data reaches their device
      await _syncEngine.syncWithPeer(peer.deviceId);

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
  final syncEngine = ref.watch(syncEngineProvider);
  return AddPeerToTripNotifier(db, syncEngine);
});
