import 'package:drift/drift.dart';

class Settlements extends Table {
  TextColumn get id => text()();
  TextColumn get tripId => text()();
  TextColumn get payerId => text()();
  TextColumn get payeeId => text()();
  RealColumn get amount => real()();
  TextColumn get currency => text().withDefault(const Constant('BDT'))();
  IntColumn get settledAt => integer()();
  TextColumn get notes => text().nullable()();
  BoolColumn get isDeleted => boolean().withDefault(const Constant(false))();
  TextColumn get hlcTimestamp => text()();

  @override
  Set<Column> get primaryKey => {id};
}
