import 'package:drift/drift.dart';
import 'package:tiptap_tour/infrastructure/database/app_database.dart';
import 'package:tiptap_tour/infrastructure/database/tables/messages_table.dart';

part 'chat_dao.g.dart';

@DriftAccessor(tables: [Messages])
class ChatDao extends DatabaseAccessor<AppDatabase> with _$ChatDaoMixin {
  ChatDao(super.db);

  Future<List<Message>> getMessagesByTripId(
    String tripId, {
    int limit = 50,
    int offset = 0,
  }) =>
      (select(messages)
            ..where(
                (m) => m.tripId.equals(tripId) & m.isDeleted.equals(false))
            ..orderBy([(m) => OrderingTerm.desc(m.sentAt)])
            ..limit(limit, offset: offset))
          .get();

  Stream<List<Message>> watchMessagesByTripId(String tripId) =>
      (select(messages)
            ..where(
                (m) => m.tripId.equals(tripId) & m.isDeleted.equals(false))
            ..orderBy([(m) => OrderingTerm.desc(m.sentAt)]))
          .watch();

  Future<void> insertMessage(MessagesCompanion message) =>
      into(messages).insert(message);

  Future<void> softDeleteMessage(String id, String hlcTimestamp) =>
      (update(messages)..where((m) => m.id.equals(id))).write(
        MessagesCompanion(
          isDeleted: const Value(true),
          hlcTimestamp: Value(hlcTimestamp),
        ),
      );

  Future<Message?> getMessageById(String id) =>
      (select(messages)..where((m) => m.id.equals(id))).getSingleOrNull();
}
