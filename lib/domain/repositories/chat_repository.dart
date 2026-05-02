import 'package:tiptap_tour/domain/entities/message.dart';

abstract interface class ChatRepository {
  Future<List<Message>> getMessagesByTrip(String tripId, {int limit = 50, int offset = 0});
  Future<void> sendMessage(Message message);
  Future<void> deleteMessage(String id);
  Stream<List<Message>> watchMessagesByTrip(String tripId);
}
