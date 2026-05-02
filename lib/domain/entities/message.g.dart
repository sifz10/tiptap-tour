// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'message.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$MessageImpl _$$MessageImplFromJson(Map<String, dynamic> json) =>
    _$MessageImpl(
      id: json['id'] as String,
      tripId: json['tripId'] as String,
      senderId: json['senderId'] as String,
      content: json['content'] as String?,
      messageType: $enumDecode(_$MessageTypeEnumMap, json['messageType']),
      imagePath: json['imagePath'] as String?,
      imageThumbnailPath: json['imageThumbnailPath'] as String?,
      replyToId: json['replyToId'] as String?,
      sentAt: DateTime.parse(json['sentAt'] as String),
      isDeleted: json['isDeleted'] as bool? ?? false,
      hlcTimestamp: json['hlcTimestamp'] as String,
    );

Map<String, dynamic> _$$MessageImplToJson(_$MessageImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'tripId': instance.tripId,
      'senderId': instance.senderId,
      'content': instance.content,
      'messageType': _$MessageTypeEnumMap[instance.messageType]!,
      'imagePath': instance.imagePath,
      'imageThumbnailPath': instance.imageThumbnailPath,
      'replyToId': instance.replyToId,
      'sentAt': instance.sentAt.toIso8601String(),
      'isDeleted': instance.isDeleted,
      'hlcTimestamp': instance.hlcTimestamp,
    };

const _$MessageTypeEnumMap = {
  MessageType.text: 'text',
  MessageType.image: 'image',
  MessageType.expenseUpdate: 'expenseUpdate',
  MessageType.system: 'system',
};
