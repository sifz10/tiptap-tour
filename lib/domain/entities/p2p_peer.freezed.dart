// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'p2p_peer.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

P2PPeer _$P2PPeerFromJson(Map<String, dynamic> json) {
  return _P2PPeer.fromJson(json);
}

/// @nodoc
mixin _$P2PPeer {
  String get deviceId => throw _privateConstructorUsedError;
  String get displayName => throw _privateConstructorUsedError;
  String? get platform => throw _privateConstructorUsedError;
  DateTime get lastSeen => throw _privateConstructorUsedError;
  bool get isConnected => throw _privateConstructorUsedError;

  /// Serializes this P2PPeer to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of P2PPeer
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $P2PPeerCopyWith<P2PPeer> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $P2PPeerCopyWith<$Res> {
  factory $P2PPeerCopyWith(P2PPeer value, $Res Function(P2PPeer) then) =
      _$P2PPeerCopyWithImpl<$Res, P2PPeer>;
  @useResult
  $Res call({
    String deviceId,
    String displayName,
    String? platform,
    DateTime lastSeen,
    bool isConnected,
  });
}

/// @nodoc
class _$P2PPeerCopyWithImpl<$Res, $Val extends P2PPeer>
    implements $P2PPeerCopyWith<$Res> {
  _$P2PPeerCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of P2PPeer
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? deviceId = null,
    Object? displayName = null,
    Object? platform = freezed,
    Object? lastSeen = null,
    Object? isConnected = null,
  }) {
    return _then(
      _value.copyWith(
            deviceId: null == deviceId
                ? _value.deviceId
                : deviceId // ignore: cast_nullable_to_non_nullable
                      as String,
            displayName: null == displayName
                ? _value.displayName
                : displayName // ignore: cast_nullable_to_non_nullable
                      as String,
            platform: freezed == platform
                ? _value.platform
                : platform // ignore: cast_nullable_to_non_nullable
                      as String?,
            lastSeen: null == lastSeen
                ? _value.lastSeen
                : lastSeen // ignore: cast_nullable_to_non_nullable
                      as DateTime,
            isConnected: null == isConnected
                ? _value.isConnected
                : isConnected // ignore: cast_nullable_to_non_nullable
                      as bool,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$P2PPeerImplCopyWith<$Res> implements $P2PPeerCopyWith<$Res> {
  factory _$$P2PPeerImplCopyWith(
    _$P2PPeerImpl value,
    $Res Function(_$P2PPeerImpl) then,
  ) = __$$P2PPeerImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String deviceId,
    String displayName,
    String? platform,
    DateTime lastSeen,
    bool isConnected,
  });
}

/// @nodoc
class __$$P2PPeerImplCopyWithImpl<$Res>
    extends _$P2PPeerCopyWithImpl<$Res, _$P2PPeerImpl>
    implements _$$P2PPeerImplCopyWith<$Res> {
  __$$P2PPeerImplCopyWithImpl(
    _$P2PPeerImpl _value,
    $Res Function(_$P2PPeerImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of P2PPeer
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? deviceId = null,
    Object? displayName = null,
    Object? platform = freezed,
    Object? lastSeen = null,
    Object? isConnected = null,
  }) {
    return _then(
      _$P2PPeerImpl(
        deviceId: null == deviceId
            ? _value.deviceId
            : deviceId // ignore: cast_nullable_to_non_nullable
                  as String,
        displayName: null == displayName
            ? _value.displayName
            : displayName // ignore: cast_nullable_to_non_nullable
                  as String,
        platform: freezed == platform
            ? _value.platform
            : platform // ignore: cast_nullable_to_non_nullable
                  as String?,
        lastSeen: null == lastSeen
            ? _value.lastSeen
            : lastSeen // ignore: cast_nullable_to_non_nullable
                  as DateTime,
        isConnected: null == isConnected
            ? _value.isConnected
            : isConnected // ignore: cast_nullable_to_non_nullable
                  as bool,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$P2PPeerImpl implements _P2PPeer {
  const _$P2PPeerImpl({
    required this.deviceId,
    required this.displayName,
    this.platform,
    required this.lastSeen,
    this.isConnected = false,
  });

  factory _$P2PPeerImpl.fromJson(Map<String, dynamic> json) =>
      _$$P2PPeerImplFromJson(json);

  @override
  final String deviceId;
  @override
  final String displayName;
  @override
  final String? platform;
  @override
  final DateTime lastSeen;
  @override
  @JsonKey()
  final bool isConnected;

  @override
  String toString() {
    return 'P2PPeer(deviceId: $deviceId, displayName: $displayName, platform: $platform, lastSeen: $lastSeen, isConnected: $isConnected)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$P2PPeerImpl &&
            (identical(other.deviceId, deviceId) ||
                other.deviceId == deviceId) &&
            (identical(other.displayName, displayName) ||
                other.displayName == displayName) &&
            (identical(other.platform, platform) ||
                other.platform == platform) &&
            (identical(other.lastSeen, lastSeen) ||
                other.lastSeen == lastSeen) &&
            (identical(other.isConnected, isConnected) ||
                other.isConnected == isConnected));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    deviceId,
    displayName,
    platform,
    lastSeen,
    isConnected,
  );

  /// Create a copy of P2PPeer
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$P2PPeerImplCopyWith<_$P2PPeerImpl> get copyWith =>
      __$$P2PPeerImplCopyWithImpl<_$P2PPeerImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$P2PPeerImplToJson(this);
  }
}

abstract class _P2PPeer implements P2PPeer {
  const factory _P2PPeer({
    required final String deviceId,
    required final String displayName,
    final String? platform,
    required final DateTime lastSeen,
    final bool isConnected,
  }) = _$P2PPeerImpl;

  factory _P2PPeer.fromJson(Map<String, dynamic> json) = _$P2PPeerImpl.fromJson;

  @override
  String get deviceId;
  @override
  String get displayName;
  @override
  String? get platform;
  @override
  DateTime get lastSeen;
  @override
  bool get isConnected;

  /// Create a copy of P2PPeer
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$P2PPeerImplCopyWith<_$P2PPeerImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
