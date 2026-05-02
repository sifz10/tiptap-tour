// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'expense_split.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

ExpenseSplit _$ExpenseSplitFromJson(Map<String, dynamic> json) {
  return _ExpenseSplit.fromJson(json);
}

/// @nodoc
mixin _$ExpenseSplit {
  String get id => throw _privateConstructorUsedError;
  String get expenseId => throw _privateConstructorUsedError;
  String get userId => throw _privateConstructorUsedError;
  double get amount => throw _privateConstructorUsedError;
  double? get percentage => throw _privateConstructorUsedError;
  int? get shares => throw _privateConstructorUsedError;
  bool get isSettled => throw _privateConstructorUsedError;
  String get hlcTimestamp => throw _privateConstructorUsedError;

  /// Serializes this ExpenseSplit to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of ExpenseSplit
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ExpenseSplitCopyWith<ExpenseSplit> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ExpenseSplitCopyWith<$Res> {
  factory $ExpenseSplitCopyWith(
    ExpenseSplit value,
    $Res Function(ExpenseSplit) then,
  ) = _$ExpenseSplitCopyWithImpl<$Res, ExpenseSplit>;
  @useResult
  $Res call({
    String id,
    String expenseId,
    String userId,
    double amount,
    double? percentage,
    int? shares,
    bool isSettled,
    String hlcTimestamp,
  });
}

/// @nodoc
class _$ExpenseSplitCopyWithImpl<$Res, $Val extends ExpenseSplit>
    implements $ExpenseSplitCopyWith<$Res> {
  _$ExpenseSplitCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ExpenseSplit
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? expenseId = null,
    Object? userId = null,
    Object? amount = null,
    Object? percentage = freezed,
    Object? shares = freezed,
    Object? isSettled = null,
    Object? hlcTimestamp = null,
  }) {
    return _then(
      _value.copyWith(
            id: null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as String,
            expenseId: null == expenseId
                ? _value.expenseId
                : expenseId // ignore: cast_nullable_to_non_nullable
                      as String,
            userId: null == userId
                ? _value.userId
                : userId // ignore: cast_nullable_to_non_nullable
                      as String,
            amount: null == amount
                ? _value.amount
                : amount // ignore: cast_nullable_to_non_nullable
                      as double,
            percentage: freezed == percentage
                ? _value.percentage
                : percentage // ignore: cast_nullable_to_non_nullable
                      as double?,
            shares: freezed == shares
                ? _value.shares
                : shares // ignore: cast_nullable_to_non_nullable
                      as int?,
            isSettled: null == isSettled
                ? _value.isSettled
                : isSettled // ignore: cast_nullable_to_non_nullable
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
abstract class _$$ExpenseSplitImplCopyWith<$Res>
    implements $ExpenseSplitCopyWith<$Res> {
  factory _$$ExpenseSplitImplCopyWith(
    _$ExpenseSplitImpl value,
    $Res Function(_$ExpenseSplitImpl) then,
  ) = __$$ExpenseSplitImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String id,
    String expenseId,
    String userId,
    double amount,
    double? percentage,
    int? shares,
    bool isSettled,
    String hlcTimestamp,
  });
}

/// @nodoc
class __$$ExpenseSplitImplCopyWithImpl<$Res>
    extends _$ExpenseSplitCopyWithImpl<$Res, _$ExpenseSplitImpl>
    implements _$$ExpenseSplitImplCopyWith<$Res> {
  __$$ExpenseSplitImplCopyWithImpl(
    _$ExpenseSplitImpl _value,
    $Res Function(_$ExpenseSplitImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of ExpenseSplit
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? expenseId = null,
    Object? userId = null,
    Object? amount = null,
    Object? percentage = freezed,
    Object? shares = freezed,
    Object? isSettled = null,
    Object? hlcTimestamp = null,
  }) {
    return _then(
      _$ExpenseSplitImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as String,
        expenseId: null == expenseId
            ? _value.expenseId
            : expenseId // ignore: cast_nullable_to_non_nullable
                  as String,
        userId: null == userId
            ? _value.userId
            : userId // ignore: cast_nullable_to_non_nullable
                  as String,
        amount: null == amount
            ? _value.amount
            : amount // ignore: cast_nullable_to_non_nullable
                  as double,
        percentage: freezed == percentage
            ? _value.percentage
            : percentage // ignore: cast_nullable_to_non_nullable
                  as double?,
        shares: freezed == shares
            ? _value.shares
            : shares // ignore: cast_nullable_to_non_nullable
                  as int?,
        isSettled: null == isSettled
            ? _value.isSettled
            : isSettled // ignore: cast_nullable_to_non_nullable
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
class _$ExpenseSplitImpl implements _ExpenseSplit {
  const _$ExpenseSplitImpl({
    required this.id,
    required this.expenseId,
    required this.userId,
    required this.amount,
    this.percentage,
    this.shares,
    this.isSettled = false,
    required this.hlcTimestamp,
  });

  factory _$ExpenseSplitImpl.fromJson(Map<String, dynamic> json) =>
      _$$ExpenseSplitImplFromJson(json);

  @override
  final String id;
  @override
  final String expenseId;
  @override
  final String userId;
  @override
  final double amount;
  @override
  final double? percentage;
  @override
  final int? shares;
  @override
  @JsonKey()
  final bool isSettled;
  @override
  final String hlcTimestamp;

  @override
  String toString() {
    return 'ExpenseSplit(id: $id, expenseId: $expenseId, userId: $userId, amount: $amount, percentage: $percentage, shares: $shares, isSettled: $isSettled, hlcTimestamp: $hlcTimestamp)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ExpenseSplitImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.expenseId, expenseId) ||
                other.expenseId == expenseId) &&
            (identical(other.userId, userId) || other.userId == userId) &&
            (identical(other.amount, amount) || other.amount == amount) &&
            (identical(other.percentage, percentage) ||
                other.percentage == percentage) &&
            (identical(other.shares, shares) || other.shares == shares) &&
            (identical(other.isSettled, isSettled) ||
                other.isSettled == isSettled) &&
            (identical(other.hlcTimestamp, hlcTimestamp) ||
                other.hlcTimestamp == hlcTimestamp));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    expenseId,
    userId,
    amount,
    percentage,
    shares,
    isSettled,
    hlcTimestamp,
  );

  /// Create a copy of ExpenseSplit
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ExpenseSplitImplCopyWith<_$ExpenseSplitImpl> get copyWith =>
      __$$ExpenseSplitImplCopyWithImpl<_$ExpenseSplitImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ExpenseSplitImplToJson(this);
  }
}

abstract class _ExpenseSplit implements ExpenseSplit {
  const factory _ExpenseSplit({
    required final String id,
    required final String expenseId,
    required final String userId,
    required final double amount,
    final double? percentage,
    final int? shares,
    final bool isSettled,
    required final String hlcTimestamp,
  }) = _$ExpenseSplitImpl;

  factory _ExpenseSplit.fromJson(Map<String, dynamic> json) =
      _$ExpenseSplitImpl.fromJson;

  @override
  String get id;
  @override
  String get expenseId;
  @override
  String get userId;
  @override
  double get amount;
  @override
  double? get percentage;
  @override
  int? get shares;
  @override
  bool get isSettled;
  @override
  String get hlcTimestamp;

  /// Create a copy of ExpenseSplit
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ExpenseSplitImplCopyWith<_$ExpenseSplitImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
