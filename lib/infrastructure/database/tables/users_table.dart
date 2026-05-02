import 'package:drift/drift.dart';

class Users extends Table {
  TextColumn get id => text()();
  TextColumn get displayName => text()();
  TextColumn get avatarPath => text().nullable()();
  TextColumn get deviceId => text()();
  TextColumn get phoneNumber => text().nullable()();
  IntColumn get createdAt => integer()();
  TextColumn get hlcTimestamp => text()();

  @override
  Set<Column> get primaryKey => {id};
}
