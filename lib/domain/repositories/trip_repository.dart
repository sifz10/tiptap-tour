import 'package:tiptap_tour/domain/entities/trip.dart';

abstract interface class TripRepository {
  Future<List<Trip>> getAllTrips();
  Future<Trip?> getTripById(String id);
  Future<void> createTrip(Trip trip);
  Future<void> updateTrip(Trip trip);
  Future<void> deleteTrip(String id);
  Future<List<Trip>> getActiveTrips();
  Future<List<Trip>> getArchivedTrips();
  Stream<List<Trip>> watchAllTrips();
}
