import 'package:drift/drift.dart';

class Trips extends Table {
  TextColumn get id => text()();
  TextColumn get name => text()();
  TextColumn get description => text().nullable()();
  TextColumn get coverImagePath => text().nullable()();
  TextColumn get baseCurrency => text().withDefault(const Constant('BDT'))();
  TextColumn get createdBy => text()();
  IntColumn get startDate => integer().nullable()();
  IntColumn get endDate => integer().nullable()();
  BoolColumn get isArchived => boolean().withDefault(const Constant(false))();
  IntColumn get createdAt => integer()();
  IntColumn get updatedAt => integer()();
  TextColumn get hlcTimestamp => text()();

  @override
  Set<Column> get primaryKey => {id};
}

class TripMembers extends Table {
  TextColumn get tripId => text()();
  TextColumn get userId => text()();
  TextColumn get role => text().withDefault(const Constant('member'))();
  IntColumn get joinedAt => integer()();

  @override
  Set<Column> get primaryKey => {tripId, userId};
}
