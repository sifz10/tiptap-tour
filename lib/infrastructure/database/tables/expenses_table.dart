import 'package:drift/drift.dart';

class Expenses extends Table {
  TextColumn get id => text()();
  TextColumn get tripId => text()();
  TextColumn get paidBy => text()();
  TextColumn get title => text()();
  RealColumn get amount => real()();
  TextColumn get currency => text().withDefault(const Constant('BDT'))();
  TextColumn get category => text()();
  TextColumn get splitType => text()();
  TextColumn get receiptImagePath => text().nullable()();
  TextColumn get notes => text().nullable()();
  IntColumn get expenseDate => integer()();
  IntColumn get createdAt => integer()();
  IntColumn get updatedAt => integer()();
  BoolColumn get isDeleted => boolean().withDefault(const Constant(false))();
  TextColumn get hlcTimestamp => text()();

  @override
  Set<Column> get primaryKey => {id};
}

class ExpenseSplits extends Table {
  TextColumn get id => text()();
  TextColumn get expenseId => text()();
  TextColumn get userId => text()();
  RealColumn get amount => real()();
  RealColumn get percentage => real().nullable()();
  IntColumn get shares => integer().nullable()();
  BoolColumn get isSettled => boolean().withDefault(const Constant(false))();
  TextColumn get hlcTimestamp => text()();

  @override
  Set<Column> get primaryKey => {id};
}
