import 'package:drift/drift.dart';
import 'package:tiptap_tour/infrastructure/database/app_database.dart';
import 'package:tiptap_tour/infrastructure/database/tables/users_table.dart';
import 'package:tiptap_tour/infrastructure/database/tables/trips_table.dart';

part 'user_dao.g.dart';

@DriftAccessor(tables: [Users, TripMembers])
class UserDao extends DatabaseAccessor<AppDatabase> with _$UserDaoMixin {
  UserDao(super.db);

  Future<List<User>> getAllUsers() => select(users).get();

  Future<User?> getUserById(String id) =>
      (select(users)..where((u) => u.id.equals(id))).getSingleOrNull();

  Future<void> insertUser(UsersCompanion user) => into(users).insert(user);

  Future<void> updateUser(UsersCompanion user) =>
      (update(users)..where((u) => u.id.equals(user.id.value)))
          .write(user);

  Future<List<User>> getUsersByTripId(String tripId) {
    final query = select(users).join([
      innerJoin(tripMembers, tripMembers.userId.equalsExp(users.id)),
    ])
      ..where(tripMembers.tripId.equals(tripId));

    return query.map((row) => row.readTable(users)).get();
  }
}
