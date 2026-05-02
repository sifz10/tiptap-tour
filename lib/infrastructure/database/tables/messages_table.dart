import 'package:drift/drift.dart';

class Messages extends Table {
  TextColumn get id => text()();
  TextColumn get tripId => text()();
  TextColumn get senderId => text()();
  TextColumn get content => text().nullable()();
  TextColumn get messageType => text()();
  TextColumn get imagePath => text().nullable()();
  TextColumn get imageThumbnailPath => text().nullable()();
  TextColumn get replyToId => text().nullable()();
  IntColumn get sentAt => integer()();
  BoolColumn get isDeleted => boolean().withDefault(const Constant(false))();
  TextColumn get hlcTimestamp => text()();

  @override
  Set<Column> get primaryKey => {id};
}
