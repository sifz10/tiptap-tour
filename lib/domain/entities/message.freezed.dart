// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'message.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

Message _$MessageFromJson(Map<String, dynamic> json) {
  return _Message.fromJson(json);
}

/// @nodoc
mixin _$Message {
  String get id => throw _privateConstructorUsedError;
  String get tripId => throw _privateConstructorUsedError;
  String get senderId => throw _privateConstructorUsedError;
  String? get content => throw _privateConstructorUsedError;
  MessageType get messageType => throw _privateConstructorUsedError;
  String? get imagePath => throw _privateConstructorUsedError;
  String? get imageThumbnailPath => throw _privateConstructorUsedError;
  String? get replyToId => throw _privateConstructorUsedError;
  DateTime get sentAt => throw _privateConstructorUsedError;
  bool get isDeleted => throw _privateConstructorUsedError;
  String get hlcTimestamp => throw _privateConstructorUsedError;

  /// Serializes this Message to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of Message
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $MessageCopyWith<Message> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $MessageCopyWith<$Res> {
  factory $MessageCopyWith(Message value, $Res Function(Message) then) =
      _$MessageCopyWithImpl<$Res, Message>;
  @useResult
  $Res call({
    String id,
    String tripId,
    String senderId,
    String? content,
    MessageType messageType,
    String? imagePath,
    String? imageThumbnailPath,
    String? replyToId,
    DateTime sentAt,
    bool isDeleted,
    String hlcTimestamp,
  });
}

/// @nodoc
class _$MessageCopyWithImpl<$Res, $Val extends Message>
    implements $MessageCopyWith<$Res> {
  _$MessageCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Message
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? tripId = null,
    Object? senderId = null,
    Object? content = freezed,
    Object? messageType = null,
    Object? imagePath = freezed,
    Object? imageThumbnailPath = freezed,
    Object? replyToId = freezed,
    Object? sentAt = null,
    Object? isDeleted = null,
    Object? hlcTimestamp = null,
  }) {
    return _then(
      _value.copyWith(
            id: null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as String,
            tripId: null == tripId
                ? _value.tripId
                : tripId // ignore: cast_nullable_to_non_nullable
                      as String,
            senderId: null == senderId
                ? _value.senderId
                : senderId // ignore: cast_nullable_to_non_nullable
                      as String,
            content: freezed == content
                ? _value.content
                : content // ignore: cast_nullable_to_non_nullable
                      as String?,
            messageType: null == messageType
                ? _value.messageType
                : messageType // ignore: cast_nullable_to_non_nullable
                      as MessageType,
            imagePath: freezed == imagePath
                ? _value.imagePath
                : imagePath // ignore: cast_nullable_to_non_nullable
                      as String?,
            imageThumbnailPath: freezed == imageThumbnailPath
                ? _value.imageThumbnailPath
                : imageThumbnailPath // ignore: cast_nullable_to_non_nullable
                      as String?,
            replyToId: freezed == replyToId
                ? _value.replyToId
                : replyToId // ignore: cast_nullable_to_non_nullable
                      as String?,
            sentAt: null == sentAt
                ? _value.sentAt
                : sentAt // ignore: cast_nullable_to_non_nullable
                      as DateTime,
            isDeleted: null == isDeleted
                ? _value.isDeleted
                : isDeleted // ignore: cast_nullable_to_non_nullable
                      as bool,
            hlcTimestamp: null == hlcTimestamp
                ? _value.hlcTimestamp
                : hlcTimestamp // ignore: cast_nullable_to_non_nullable
                      as String,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$MessageImplCopyWith<$Res> implements $MessageCopyWith<$Res> {
  factory _$$MessageImplCopyWith(
    _$MessageImpl value,
    $Res Function(_$MessageImpl) then,
  ) = __$$MessageImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String id,
    String tripId,
    String senderId,
    String? content,
    MessageType messageType,
    String? imagePath,
    String? imageThumbnailPath,
    String? replyToId,
    DateTime sentAt,
    bool isDeleted,
    String hlcTimestamp,
  });
}

/// @nodoc
class __$$MessageImplCopyWithImpl<$Res>
    extends _$MessageCopyWithImpl<$Res, _$MessageImpl>
    implements _$$MessageImplCopyWith<$Res> {
  __$$MessageImplCopyWithImpl(
    _$MessageImpl _value,
    $Res Function(_$MessageImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of Message
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? tripId = null,
    Object? senderId = null,
    Object? content = freezed,
    Object? messageType = null,
    Object? imagePath = freezed,
    Object? imageThumbnailPath = freezed,
    Object? replyToId = freezed,
    Object? sentAt = null,
    Object? isDeleted = null,
    Object? hlcTimestamp = null,
  }) {
    return _then(
      _$MessageImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as String,
        tripId: null == tripId
            ? _value.tripId
            : tripId // ignore: cast_nullable_to_non_nullable
                  as String,
        senderId: null == senderId
            ? _value.senderId
            : senderId // ignore: cast_nullable_to_non_nullable
                  as String,
        content: freezed == content
            ? _value.content
            : content // ignore: cast_nullable_to_non_nullable
                  as String?,
        messageType: null == messageType
            ? _value.messageType
            : messageType // ignore: cast_nullable_to_non_nullable
                  as MessageType,
        imagePath: freezed == imagePath
            ? _value.imagePath
            : imagePath // ignore: cast_nullable_to_non_nullable
                  as String?,
        imageThumbnailPath: freezed == imageThumbnailPath
            ? _value.imageThumbnailPath
            : imageThumbnailPath // ignore: cast_nullable_to_non_nullable
                  as String?,
        replyToId: freezed == replyToId
            ? _value.replyToId
            : replyToId // ignore: cast_nullable_to_non_nullable
                  as String?,
        sentAt: null == sentAt
            ? _value.sentAt
            : sentAt // ignore: cast_nullable_to_non_nullable
                  as DateTime,
        isDeleted: null == isDeleted
            ? _value.isDeleted
            : isDeleted // ignore: cast_nullable_to_non_nullable
                  as bool,
        hlcTimestamp: null == hlcTimestamp
            ? _value.hlcTimestamp
            : hlcTimestamp // ignore: cast_nullable_to_non_nullable
                  as String,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$MessageImpl implements _Message {
  const _$MessageImpl({
    required this.id,
    required this.tripId,
    required this.senderId,
    this.content,
    required this.messageType,
    this.imagePath,
    this.imageThumbnailPath,
    this.replyToId,
    required this.sentAt,
    this.isDeleted = false,
    required this.hlcTimestamp,
  });

  factory _$MessageImpl.fromJson(Map<String, dynamic> json) =>
      _$$MessageImplFromJson(json);

  @override
  final String id;
  @override
  final String tripId;
  @override
  final String senderId;
  @override
  final String? content;
  @override
  final MessageType messageType;
  @override
  final String? imagePath;
  @override
  final String? imageThumbnailPath;
  @override
  final String? replyToId;
  @override
  final DateTime sentAt;
  @override
  @JsonKey()
  final bool isDeleted;
  @override
  final String hlcTimestamp;

  @override
  String toString() {
    return 'Message(id: $id, tripId: $tripId, senderId: $senderId, content: $content, messageType: $messageType, imagePath: $imagePath, imageThumbnailPath: $imageThumbnailPath, replyToId: $replyToId, sentAt: $sentAt, isDeleted: $isDeleted, hlcTimestamp: $hlcTimestamp)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$MessageImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.tripId, tripId) || other.tripId == tripId) &&
            (identical(other.senderId, senderId) ||
                other.senderId == senderId) &&
            (identical(other.content, content) || other.content == content) &&
            (identical(other.messageType, messageType) ||
                other.messageType == messageType) &&
            (identical(other.imagePath, imagePath) ||
                other.imagePath == imagePath) &&
            (identical(other.imageThumbnailPath, imageThumbnailPath) ||
                other.imageThumbnailPath == imageThumbnailPath) &&
            (identical(other.replyToId, replyToId) ||
                other.replyToId == replyToId) &&
            (identical(other.sentAt, sentAt) || other.sentAt == sentAt) &&
            (identical(other.isDeleted, isDeleted) ||
                other.isDeleted == isDeleted) &&
            (identical(other.hlcTimestamp, hlcTimestamp) ||
                other.hlcTimestamp == hlcTimestamp));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    tripId,
    senderId,
    content,
    messageType,
    imagePath,
    imageThumbnailPath,
    replyToId,
    sentAt,
    isDeleted,
    hlcTimestamp,
  );

  /// Create a copy of Message
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$MessageImplCopyWith<_$MessageImpl> get copyWith =>
      __$$MessageImplCopyWithImpl<_$MessageImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$MessageImplToJson(this);
  }
}

abstract class _Message implements Message {
  const factory _Message({
    required final String id,
    required final String tripId,
    required final String senderId,
    final String? content,
    required final MessageType messageType,
    final String? imagePath,
    final String? imageThumbnailPath,
    final String? replyToId,
    required final DateTime sentAt,
    final bool isDeleted,
    required final String hlcTimestamp,
  }) = _$MessageImpl;

  factory _Message.fromJson(Map<String, dynamic> json) = _$MessageImpl.fromJson;

  @override
  String get id;
  @override
  String get tripId;
  @override
  String get senderId;
  @override
  String? get content;
  @override
  MessageType get messageType;
  @override
  String? get imagePath;
  @override
  String? get imageThumbnailPath;
  @override
  String? get replyToId;
  @override
  DateTime get sentAt;
  @override
  bool get isDeleted;
  @override
  String get hlcTimestamp;

  /// Create a copy of Message
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$MessageImplCopyWith<_$MessageImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
