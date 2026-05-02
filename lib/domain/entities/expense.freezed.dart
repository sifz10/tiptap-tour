// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'expense.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

Expense _$ExpenseFromJson(Map<String, dynamic> json) {
  return _Expense.fromJson(json);
}

/// @nodoc
mixin _$Expense {
  String get id => throw _privateConstructorUsedError;
  String get tripId => throw _privateConstructorUsedError;
  String get paidBy => throw _privateConstructorUsedError;
  String get title => throw _privateConstructorUsedError;
  double get amount => throw _privateConstructorUsedError;
  String get currency => throw _privateConstructorUsedError;
  String get category => throw _privateConstructorUsedError;
  SplitType get splitType => throw _privateConstructorUsedError;
  String? get receiptImagePath => throw _privateConstructorUsedError;
  String? get notes => throw _privateConstructorUsedError;
  DateTime get expenseDate => throw _privateConstructorUsedError;
  DateTime get createdAt => throw _privateConstructorUsedError;
  DateTime get updatedAt => throw _privateConstructorUsedError;
  bool get isDeleted => throw _privateConstructorUsedError;
  String get hlcTimestamp => throw _privateConstructorUsedError;

  /// Serializes this Expense to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of Expense
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ExpenseCopyWith<Expense> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ExpenseCopyWith<$Res> {
  factory $ExpenseCopyWith(Expense value, $Res Function(Expense) then) =
      _$ExpenseCopyWithImpl<$Res, Expense>;
  @useResult
  $Res call({
    String id,
    String tripId,
    String paidBy,
    String title,
    double amount,
    String currency,
    String category,
    SplitType splitType,
    String? receiptImagePath,
    String? notes,
    DateTime expenseDate,
    DateTime createdAt,
    DateTime updatedAt,
    bool isDeleted,
    String hlcTimestamp,
  });
}

/// @nodoc
class _$ExpenseCopyWithImpl<$Res, $Val extends Expense>
    implements $ExpenseCopyWith<$Res> {
  _$ExpenseCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Expense
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? tripId = null,
    Object? paidBy = null,
    Object? title = null,
    Object? amount = null,
    Object? currency = null,
    Object? category = null,
    Object? splitType = null,
    Object? receiptImagePath = freezed,
    Object? notes = freezed,
    Object? expenseDate = null,
    Object? createdAt = null,
    Object? updatedAt = null,
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
            paidBy: null == paidBy
                ? _value.paidBy
                : paidBy // ignore: cast_nullable_to_non_nullable
                      as String,
            title: null == title
                ? _value.title
                : title // ignore: cast_nullable_to_non_nullable
                      as String,
            amount: null == amount
                ? _value.amount
                : amount // ignore: cast_nullable_to_non_nullable
                      as double,
            currency: null == currency
                ? _value.currency
                : currency // ignore: cast_nullable_to_non_nullable
                      as String,
            category: null == category
                ? _value.category
                : category // ignore: cast_nullable_to_non_nullable
                      as String,
            splitType: null == splitType
                ? _value.splitType
                : splitType // ignore: cast_nullable_to_non_nullable
                      as SplitType,
            receiptImagePath: freezed == receiptImagePath
                ? _value.receiptImagePath
                : receiptImagePath // ignore: cast_nullable_to_non_nullable
                      as String?,
            notes: freezed == notes
                ? _value.notes
                : notes // ignore: cast_nullable_to_non_nullable
                      as String?,
            expenseDate: null == expenseDate
                ? _value.expenseDate
                : expenseDate // ignore: cast_nullable_to_non_nullable
                      as DateTime,
            createdAt: null == createdAt
                ? _value.createdAt
                : createdAt // ignore: cast_nullable_to_non_nullable
                      as DateTime,
            updatedAt: null == updatedAt
                ? _value.updatedAt
                : updatedAt // ignore: cast_nullable_to_non_nullable
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
abstract class _$$ExpenseImplCopyWith<$Res> implements $ExpenseCopyWith<$Res> {
  factory _$$ExpenseImplCopyWith(
    _$ExpenseImpl value,
    $Res Function(_$ExpenseImpl) then,
  ) = __$$ExpenseImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String id,
    String tripId,
    String paidBy,
    String title,
    double amount,
    String currency,
    String category,
    SplitType splitType,
    String? receiptImagePath,
    String? notes,
    DateTime expenseDate,
    DateTime createdAt,
    DateTime updatedAt,
    bool isDeleted,
    String hlcTimestamp,
  });
}

/// @nodoc
class __$$ExpenseImplCopyWithImpl<$Res>
    extends _$ExpenseCopyWithImpl<$Res, _$ExpenseImpl>
    implements _$$ExpenseImplCopyWith<$Res> {
  __$$ExpenseImplCopyWithImpl(
    _$ExpenseImpl _value,
    $Res Function(_$ExpenseImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of Expense
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? tripId = null,
    Object? paidBy = null,
    Object? title = null,
    Object? amount = null,
    Object? currency = null,
    Object? category = null,
    Object? splitType = null,
    Object? receiptImagePath = freezed,
    Object? notes = freezed,
    Object? expenseDate = null,
    Object? createdAt = null,
    Object? updatedAt = null,
    Object? isDeleted = null,
    Object? hlcTimestamp = null,
  }) {
    return _then(
      _$ExpenseImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as String,
        tripId: null == tripId
            ? _value.tripId
            : tripId // ignore: cast_nullable_to_non_nullable
                  as String,
        paidBy: null == paidBy
            ? _value.paidBy
            : paidBy // ignore: cast_nullable_to_non_nullable
                  as String,
        title: null == title
            ? _value.title
            : title // ignore: cast_nullable_to_non_nullable
                  as String,
        amount: null == amount
            ? _value.amount
            : amount // ignore: cast_nullable_to_non_nullable
                  as double,
        currency: null == currency
            ? _value.currency
            : currency // ignore: cast_nullable_to_non_nullable
                  as String,
        category: null == category
            ? _value.category
            : category // ignore: cast_nullable_to_non_nullable
                  as String,
        splitType: null == splitType
            ? _value.splitType
            : splitType // ignore: cast_nullable_to_non_nullable
                  as SplitType,
        receiptImagePath: freezed == receiptImagePath
            ? _value.receiptImagePath
            : receiptImagePath // ignore: cast_nullable_to_non_nullable
                  as String?,
        notes: freezed == notes
            ? _value.notes
            : notes // ignore: cast_nullable_to_non_nullable
                  as String?,
        expenseDate: null == expenseDate
            ? _value.expenseDate
            : expenseDate // ignore: cast_nullable_to_non_nullable
                  as DateTime,
        createdAt: null == createdAt
            ? _value.createdAt
            : createdAt // ignore: cast_nullable_to_non_nullable
                  as DateTime,
        updatedAt: null == updatedAt
            ? _value.updatedAt
            : updatedAt // ignore: cast_nullable_to_non_nullable
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
class _$ExpenseImpl implements _Expense {
  const _$ExpenseImpl({
    required this.id,
    required this.tripId,
    required this.paidBy,
    required this.title,
    required this.amount,
    this.currency = 'BDT',
    required this.category,
    required this.splitType,
    this.receiptImagePath,
    this.notes,
    required this.expenseDate,
    required this.createdAt,
    required this.updatedAt,
    this.isDeleted = false,
    required this.hlcTimestamp,
  });

  factory _$ExpenseImpl.fromJson(Map<String, dynamic> json) =>
      _$$ExpenseImplFromJson(json);

  @override
  final String id;
  @override
  final String tripId;
  @override
  final String paidBy;
  @override
  final String title;
  @override
  final double amount;
  @override
  @JsonKey()
  final String currency;
  @override
  final String category;
  @override
  final SplitType splitType;
  @override
  final String? receiptImagePath;
  @override
  final String? notes;
  @override
  final DateTime expenseDate;
  @override
  final DateTime createdAt;
  @override
  final DateTime updatedAt;
  @override
  @JsonKey()
  final bool isDeleted;
  @override
  final String hlcTimestamp;

  @override
  String toString() {
    return 'Expense(id: $id, tripId: $tripId, paidBy: $paidBy, title: $title, amount: $amount, currency: $currency, category: $category, splitType: $splitType, receiptImagePath: $receiptImagePath, notes: $notes, expenseDate: $expenseDate, createdAt: $createdAt, updatedAt: $updatedAt, isDeleted: $isDeleted, hlcTimestamp: $hlcTimestamp)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ExpenseImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.tripId, tripId) || other.tripId == tripId) &&
            (identical(other.paidBy, paidBy) || other.paidBy == paidBy) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.amount, amount) || other.amount == amount) &&
            (identical(other.currency, currency) ||
                other.currency == currency) &&
            (identical(other.category, category) ||
                other.category == category) &&
            (identical(other.splitType, splitType) ||
                other.splitType == splitType) &&
            (identical(other.receiptImagePath, receiptImagePath) ||
                other.receiptImagePath == receiptImagePath) &&
            (identical(other.notes, notes) || other.notes == notes) &&
            (identical(other.expenseDate, expenseDate) ||
                other.expenseDate == expenseDate) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.updatedAt, updatedAt) ||
                other.updatedAt == updatedAt) &&
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
    paidBy,
    title,
    amount,
    currency,
    category,
    splitType,
    receiptImagePath,
    notes,
    expenseDate,
    createdAt,
    updatedAt,
    isDeleted,
    hlcTimestamp,
  );

  /// Create a copy of Expense
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ExpenseImplCopyWith<_$ExpenseImpl> get copyWith =>
      __$$ExpenseImplCopyWithImpl<_$ExpenseImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ExpenseImplToJson(this);
  }
}

abstract class _Expense implements Expense {
  const factory _Expense({
    required final String id,
    required final String tripId,
    required final String paidBy,
    required final String title,
    required final double amount,
    final String currency,
    required final String category,
    required final SplitType splitType,
    final String? receiptImagePath,
    final String? notes,
    required final DateTime expenseDate,
    required final DateTime createdAt,
    required final DateTime updatedAt,
    final bool isDeleted,
    required final String hlcTimestamp,
  }) = _$ExpenseImpl;

  factory _Expense.fromJson(Map<String, dynamic> json) = _$ExpenseImpl.fromJson;

  @override
  String get id;
  @override
  String get tripId;
  @override
  String get paidBy;
  @override
  String get title;
  @override
  double get amount;
  @override
  String get currency;
  @override
  String get category;
  @override
  SplitType get splitType;
  @override
  String? get receiptImagePath;
  @override
  String? get notes;
  @override
  DateTime get expenseDate;
  @override
  DateTime get createdAt;
  @override
  DateTime get updatedAt;
  @override
  bool get isDeleted;
  @override
  String get hlcTimestamp;

  /// Create a copy of Expense
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ExpenseImplCopyWith<_$ExpenseImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
