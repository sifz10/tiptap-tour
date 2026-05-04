import 'package:drift/drift.dart';
import 'package:tiptap_tour/infrastructure/database/app_database.dart';
import 'package:tiptap_tour/infrastructure/database/tables/trips_table.dart';

part 'trip_dao.g.dart';

@DriftAccessor(tables: [Trips, TripMembers])
class TripDao extends DatabaseAccessor<AppDatabase> with _$TripDaoMixin {
  TripDao(super.db);

  Future<List<Trip>> getAllTrips() =>
      (select(trips)..orderBy([(t) => OrderingTerm.desc(t.updatedAt)])).get();

  Future<Trip?> getTripById(String id) =>
      (select(trips)..where((t) => t.id.equals(id))).getSingleOrNull();

  Future<List<Trip>> getActiveTrips() =>
      (select(trips)
            ..where((t) => t.isArchived.equals(false))
            ..orderBy([(t) => OrderingTerm.desc(t.updatedAt)]))
          .get();

  Future<List<Trip>> getArchivedTrips() =>
      (select(trips)
            ..where((t) => t.isArchived.equals(true))
            ..orderBy([(t) => OrderingTerm.desc(t.updatedAt)]))
          .get();

  Stream<List<Trip>> watchAllTrips() =>
      (select(trips)..orderBy([(t) => OrderingTerm.desc(t.updatedAt)])).watch();

  Future<void> insertTrip(TripsCompanion trip) => into(trips).insert(trip);

  Future<void> updateTrip(TripsCompanion trip) =>
      (update(trips)..where((t) => t.id.equals(trip.id.value))).write(trip);

  Future<void> deleteTrip(String id) =>
      (delete(trips)..where((t) => t.id.equals(id))).go();

  Future<void> addMember(TripMembersCompanion member) =>
      into(tripMembers).insertOnConflictUpdate(member);

  Future<void> removeMember(String tripId, String userId) =>
      (delete(tripMembers)
            ..where(
                (m) => m.tripId.equals(tripId) & m.userId.equals(userId)))
          .go();

  Future<List<TripMember>> getMembersByTripId(String tripId) =>
      (select(tripMembers)..where((m) => m.tripId.equals(tripId))).get();
}
