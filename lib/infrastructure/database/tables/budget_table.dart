import 'package:drift/drift.dart';

class BudgetPools extends Table {
  TextColumn get id => text()();
  TextColumn get tripId => text()();
  TextColumn get name => text()();
  RealColumn get targetAmount => real()();
  TextColumn get currency => text().withDefault(const Constant('BDT'))();
  IntColumn get createdAt => integer()();
  TextColumn get hlcTimestamp => text()();

  @override
  Set<Column> get primaryKey => {id};
}

class BudgetContributions extends Table {
  TextColumn get id => text()();
  TextColumn get poolId => text()();
  TextColumn get userId => text()();
  RealColumn get amount => real()();
  IntColumn get contributedAt => integer()();
  TextColumn get hlcTimestamp => text()();

  @override
  Set<Column> get primaryKey => {id};
}
