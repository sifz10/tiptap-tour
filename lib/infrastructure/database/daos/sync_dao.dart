import 'package:drift/drift.dart';
import 'package:tiptap_tour/infrastructure/database/app_database.dart';
import 'package:tiptap_tour/infrastructure/database/tables/sync_queue_table.dart';

part 'sync_dao.g.dart';

@DriftAccessor(tables: [SyncQueue, PeerSyncState])
class SyncDao extends DatabaseAccessor<AppDatabase> with _$SyncDaoMixin {
  SyncDao(super.db);

  Future<List<SyncQueueData>> getUnsyncedItems() =>
      (select(syncQueue)
            ..where((s) => s.synced.equals(false))
            ..orderBy([(s) => OrderingTerm.asc(s.createdAt)]))
          .get();

  Future<void> addToSyncQueue(SyncQueueCompanion item) =>
      into(syncQueue).insert(item);

  Future<void> markAsSynced(int id) =>
      (update(syncQueue)..where((s) => s.id.equals(id)))
          .write(const SyncQueueCompanion(synced: Value(true)));

  Future<void> markMultipleAsSynced(List<int> ids) {
    return transaction(() async {
      for (final id in ids) {
        await markAsSynced(id);
      }
    });
  }

  Future<void> cleanSyncedItems() =>
      (delete(syncQueue)..where((s) => s.synced.equals(true))).go();

  Future<PeerSyncStateData?> getPeerSyncState(
    String peerDeviceId,
    String tableName,
  ) =>
      (select(peerSyncState)
            ..where((p) =>
                p.peerDeviceId.equals(peerDeviceId) &
                p.syncTableName.equals(tableName)))
          .getSingleOrNull();

  Future<void> updatePeerSyncState(PeerSyncStateCompanion state) =>
      into(peerSyncState).insertOnConflictUpdate(state);

  Future<List<SyncQueueData>> getItemsAfterHlc(String hlcTimestamp) =>
      (select(syncQueue)
            ..where((s) =>
                s.hlcTimestamp.isBiggerThanValue(hlcTimestamp) &
                s.synced.equals(false))
            ..orderBy([(s) => OrderingTerm.asc(s.hlcTimestamp)]))
          .get();
}
