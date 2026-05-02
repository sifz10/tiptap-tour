import 'package:tiptap_tour/domain/entities/user.dart';

abstract interface class UserRepository {
  Future<AppUser?> getCurrentUser();
  Future<void> createUser(AppUser user);
  Future<void> updateUser(AppUser user);
  Future<List<AppUser>> getUsersByTrip(String tripId);
  Future<AppUser?> getUserById(String id);
}
