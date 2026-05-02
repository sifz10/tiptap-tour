import 'package:drift/drift.dart';

class SyncQueue extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get syncTableName => text()();
  TextColumn get recordId => text()();
  TextColumn get operation => text()();
  TextColumn get payload => text()();
  TextColumn get hlcTimestamp => text()();
  BoolColumn get synced => boolean().withDefault(const Constant(false))();
  IntColumn get createdAt => integer()();
}

class PeerSyncState extends Table {
  TextColumn get peerDeviceId => text()();
  TextColumn get syncTableName => text()();
  TextColumn get lastSyncedHlc => text()();
  IntColumn get lastSyncAt => integer()();

  @override
  Set<Column> get primaryKey => {peerDeviceId, syncTableName};
}
