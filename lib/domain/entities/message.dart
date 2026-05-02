import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:tiptap_tour/domain/enums/message_type.dart';

part 'message.freezed.dart';
part 'message.g.dart';

@freezed
class Message with _$Message {
  const factory Message({
    required String id,
    required String tripId,
    required String senderId,
    String? content,
    required MessageType messageType,
    String? imagePath,
    String? imageThumbnailPath,
    String? replyToId,
    required DateTime sentAt,
    @Default(false) bool isDeleted,
    required String hlcTimestamp,
  }) = _Message;

  factory Message.fromJson(Map<String, dynamic> json) => _$MessageFromJson(json);
}
