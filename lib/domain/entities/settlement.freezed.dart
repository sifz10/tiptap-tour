// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'settlement.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

Settlement _$SettlementFromJson(Map<String, dynamic> json) {
  return _Settlement.fromJson(json);
}

/// @nodoc
mixin _$Settlement {
  String get id => throw _privateConstructorUsedError;
  String get tripId => throw _privateConstructorUsedError;
  String get payerId => throw _privateConstructorUsedError;
  String get payeeId => throw _privateConstructorUsedError;
  double get amount => throw _privateConstructorUsedError;
  String get currency => throw _privateConstructorUsedError;
  DateTime get settledAt => throw _privateConstructorUsedError;
  String? get notes => throw _privateConstructorUsedError;
  bool get isDeleted => throw _privateConstructorUsedError;
  String get hlcTimestamp => throw _privateConstructorUsedError;

  /// Serializes this Settlement to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of Settlement
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $SettlementCopyWith<Settlement> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SettlementCopyWith<$Res> {
  factory $SettlementCopyWith(
    Settlement value,
    $Res Function(Settlement) then,
  ) = _$SettlementCopyWithImpl<$Res, Settlement>;
  @useResult
  $Res call({
    String id,
    String tripId,
    String payerId,
    String payeeId,
    double amount,
    String currency,
    DateTime settledAt,
    String? notes,
    bool isDeleted,
    String hlcTimestamp,
  });
}

/// @nodoc
class _$SettlementCopyWithImpl<$Res, $Val extends Settlement>
    implements $SettlementCopyWith<$Res> {
  _$SettlementCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Settlement
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? tripId = null,
    Object? payerId = null,
    Object? payeeId = null,
    Object? amount = null,
    Object? currency = null,
    Object? settledAt = null,
    Object? notes = freezed,
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
            payerId: null == payerId
                ? _value.payerId
                : payerId // ignore: cast_nullable_to_non_nullable
                      as String,
            payeeId: null == payeeId
                ? _value.payeeId
                : payeeId // ignore: cast_nullable_to_non_nullable
                      as String,
            amount: null == amount
                ? _value.amount
                : amount // ignore: cast_nullable_to_non_nullable
                      as double,
            currency: null == currency
                ? _value.currency
                : currency // ignore: cast_nullable_to_non_nullable
                      as String,
            settledAt: null == settledAt
                ? _value.settledAt
                : settledAt // ignore: cast_nullable_to_non_nullable
                      as DateTime,
            notes: freezed == notes
                ? _value.notes
                : notes // ignore: cast_nullable_to_non_nullable
                      as String?,
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
abstract class _$$SettlementImplCopyWith<$Res>
    implements $SettlementCopyWith<$Res> {
  factory _$$SettlementImplCopyWith(
    _$SettlementImpl value,
    $Res Function(_$SettlementImpl) then,
  ) = __$$SettlementImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String id,
    String tripId,
    String payerId,
    String payeeId,
    double amount,
    String currency,
    DateTime settledAt,
    String? notes,
    bool isDeleted,
    String hlcTimestamp,
  });
}

/// @nodoc
class __$$SettlementImplCopyWithImpl<$Res>
    extends _$SettlementCopyWithImpl<$Res, _$SettlementImpl>
    implements _$$SettlementImplCopyWith<$Res> {
  __$$SettlementImplCopyWithImpl(
    _$SettlementImpl _value,
    $Res Function(_$SettlementImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of Settlement
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? tripId = null,
    Object? payerId = null,
    Object? payeeId = null,
    Object? amount = null,
    Object? currency = null,
    Object? settledAt = null,
    Object? notes = freezed,
    Object? isDeleted = null,
    Object? hlcTimestamp = null,
  }) {
    return _then(
      _$SettlementImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as String,
        tripId: null == tripId
            ? _value.tripId
            : tripId // ignore: cast_nullable_to_non_nullable
                  as String,
        payerId: null == payerId
            ? _value.payerId
            : payerId // ignore: cast_nullable_to_non_nullable
                  as String,
        payeeId: null == payeeId
            ? _value.payeeId
            : payeeId // ignore: cast_nullable_to_non_nullable
                  as String,
        amount: null == amount
            ? _value.amount
            : amount // ignore: cast_nullable_to_non_nullable
                  as double,
        currency: null == currency
            ? _value.currency
            : currency // ignore: cast_nullable_to_non_nullable
                  as String,
        settledAt: null == settledAt
            ? _value.settledAt
            : settledAt // ignore: cast_nullable_to_non_nullable
                  as DateTime,
        notes: freezed == notes
            ? _value.notes
            : notes // ignore: cast_nullable_to_non_nullable
                  as String?,
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
class _$SettlementImpl implements _Settlement {
  const _$SettlementImpl({
    required this.id,
    required this.tripId,
    required this.payerId,
    required this.payeeId,
    required this.amount,
    this.currency = 'BDT',
    required this.settledAt,
    this.notes,
    this.isDeleted = false,
    required this.hlcTimestamp,
  });

  factory _$SettlementImpl.fromJson(Map<String, dynamic> json) =>
      _$$SettlementImplFromJson(json);

  @override
  final String id;
  @override
  final String tripId;
  @override
  final String payerId;
  @override
  final String payeeId;
  @override
  final double amount;
  @override
  @JsonKey()
  final String currency;
  @override
  final DateTime settledAt;
  @override
  final String? notes;
  @override
  @JsonKey()
  final bool isDeleted;
  @override
  final String hlcTimestamp;

  @override
  String toString() {
    return 'Settlement(id: $id, tripId: $tripId, payerId: $payerId, payeeId: $payeeId, amount: $amount, currency: $currency, settledAt: $settledAt, notes: $notes, isDeleted: $isDeleted, hlcTimestamp: $hlcTimestamp)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SettlementImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.tripId, tripId) || other.tripId == tripId) &&
            (identical(other.payerId, payerId) || other.payerId == payerId) &&
            (identical(other.payeeId, payeeId) || other.payeeId == payeeId) &&
            (identical(other.amount, amount) || other.amount == amount) &&
            (identical(other.currency, currency) ||
                other.currency == currency) &&
            (identical(other.settledAt, settledAt) ||
                other.settledAt == settledAt) &&
            (identical(other.notes, notes) || other.notes == notes) &&
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
    payerId,
    payeeId,
    amount,
    currency,
    settledAt,
    notes,
    isDeleted,
    hlcTimestamp,
  );

  /// Create a copy of Settlement
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$SettlementImplCopyWith<_$SettlementImpl> get copyWith =>
      __$$SettlementImplCopyWithImpl<_$SettlementImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$SettlementImplToJson(this);
  }
}

abstract class _Settlement implements Settlement {
  const factory _Settlement({
    required final String id,
    required final String tripId,
    required final String payerId,
    required final String payeeId,
    required final double amount,
    final String currency,
    required final DateTime settledAt,
    final String? notes,
    final bool isDeleted,
    required final String hlcTimestamp,
  }) = _$SettlementImpl;

  factory _Settlement.fromJson(Map<String, dynamic> json) =
      _$SettlementImpl.fromJson;

  @override
  String get id;
  @override
  String get tripId;
  @override
  String get payerId;
  @override
  String get payeeId;
  @override
  double get amount;
  @override
  String get currency;
  @override
  DateTime get settledAt;
  @override
  String? get notes;
  @override
  bool get isDeleted;
  @override
  String get hlcTimestamp;

  /// Create a copy of Settlement
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$SettlementImplCopyWith<_$SettlementImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
