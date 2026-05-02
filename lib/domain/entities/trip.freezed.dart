// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'trip.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

Trip _$TripFromJson(Map<String, dynamic> json) {
  return _Trip.fromJson(json);
}

/// @nodoc
mixin _$Trip {
  String get id => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  String? get description => throw _privateConstructorUsedError;
  String? get coverImagePath => throw _privateConstructorUsedError;
  String get baseCurrency => throw _privateConstructorUsedError;
  String get createdBy => throw _privateConstructorUsedError;
  DateTime? get startDate => throw _privateConstructorUsedError;
  DateTime? get endDate => throw _privateConstructorUsedError;
  bool get isArchived => throw _privateConstructorUsedError;
  DateTime get createdAt => throw _privateConstructorUsedError;
  DateTime get updatedAt => throw _privateConstructorUsedError;
  String get hlcTimestamp => throw _privateConstructorUsedError;

  /// Serializes this Trip to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of Trip
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $TripCopyWith<Trip> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TripCopyWith<$Res> {
  factory $TripCopyWith(Trip value, $Res Function(Trip) then) =
      _$TripCopyWithImpl<$Res, Trip>;
  @useResult
  $Res call({
    String id,
    String name,
    String? description,
    String? coverImagePath,
    String baseCurrency,
    String createdBy,
    DateTime? startDate,
    DateTime? endDate,
    bool isArchived,
    DateTime createdAt,
    DateTime updatedAt,
    String hlcTimestamp,
  });
}

/// @nodoc
class _$TripCopyWithImpl<$Res, $Val extends Trip>
    implements $TripCopyWith<$Res> {
  _$TripCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Trip
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? description = freezed,
    Object? coverImagePath = freezed,
    Object? baseCurrency = null,
    Object? createdBy = null,
    Object? startDate = freezed,
    Object? endDate = freezed,
    Object? isArchived = null,
    Object? createdAt = null,
    Object? updatedAt = null,
    Object? hlcTimestamp = null,
  }) {
    return _then(
      _value.copyWith(
            id: null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as String,
            name: null == name
                ? _value.name
                : name // ignore: cast_nullable_to_non_nullable
                      as String,
            description: freezed == description
                ? _value.description
                : description // ignore: cast_nullable_to_non_nullable
                      as String?,
            coverImagePath: freezed == coverImagePath
                ? _value.coverImagePath
                : coverImagePath // ignore: cast_nullable_to_non_nullable
                      as String?,
            baseCurrency: null == baseCurrency
                ? _value.baseCurrency
                : baseCurrency // ignore: cast_nullable_to_non_nullable
                      as String,
            createdBy: null == createdBy
                ? _value.createdBy
                : createdBy // ignore: cast_nullable_to_non_nullable
                      as String,
            startDate: freezed == startDate
                ? _value.startDate
                : startDate // ignore: cast_nullable_to_non_nullable
                      as DateTime?,
            endDate: freezed == endDate
                ? _value.endDate
                : endDate // ignore: cast_nullable_to_non_nullable
                      as DateTime?,
            isArchived: null == isArchived
                ? _value.isArchived
                : isArchived // ignore: cast_nullable_to_non_nullable
                      as bool,
            createdAt: null == createdAt
                ? _value.createdAt
                : createdAt // ignore: cast_nullable_to_non_nullable
                      as DateTime,
            updatedAt: null == updatedAt
                ? _value.updatedAt
                : updatedAt // ignore: cast_nullable_to_non_nullable
                      as DateTime,
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
abstract class _$$TripImplCopyWith<$Res> implements $TripCopyWith<$Res> {
  factory _$$TripImplCopyWith(
    _$TripImpl value,
    $Res Function(_$TripImpl) then,
  ) = __$$TripImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String id,
    String name,
    String? description,
    String? coverImagePath,
    String baseCurrency,
    String createdBy,
    DateTime? startDate,
    DateTime? endDate,
    bool isArchived,
    DateTime createdAt,
    DateTime updatedAt,
    String hlcTimestamp,
  });
}

/// @nodoc
class __$$TripImplCopyWithImpl<$Res>
    extends _$TripCopyWithImpl<$Res, _$TripImpl>
    implements _$$TripImplCopyWith<$Res> {
  __$$TripImplCopyWithImpl(_$TripImpl _value, $Res Function(_$TripImpl) _then)
    : super(_value, _then);

  /// Create a copy of Trip
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? description = freezed,
    Object? coverImagePath = freezed,
    Object? baseCurrency = null,
    Object? createdBy = null,
    Object? startDate = freezed,
    Object? endDate = freezed,
    Object? isArchived = null,
    Object? createdAt = null,
    Object? updatedAt = null,
    Object? hlcTimestamp = null,
  }) {
    return _then(
      _$TripImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as String,
        name: null == name
            ? _value.name
            : name // ignore: cast_nullable_to_non_nullable
                  as String,
        description: freezed == description
            ? _value.description
            : description // ignore: cast_nullable_to_non_nullable
                  as String?,
        coverImagePath: freezed == coverImagePath
            ? _value.coverImagePath
            : coverImagePath // ignore: cast_nullable_to_non_nullable
                  as String?,
        baseCurrency: null == baseCurrency
            ? _value.baseCurrency
            : baseCurrency // ignore: cast_nullable_to_non_nullable
                  as String,
        createdBy: null == createdBy
            ? _value.createdBy
            : createdBy // ignore: cast_nullable_to_non_nullable
                  as String,
        startDate: freezed == startDate
            ? _value.startDate
            : startDate // ignore: cast_nullable_to_non_nullable
                  as DateTime?,
        endDate: freezed == endDate
            ? _value.endDate
            : endDate // ignore: cast_nullable_to_non_nullable
                  as DateTime?,
        isArchived: null == isArchived
            ? _value.isArchived
            : isArchived // ignore: cast_nullable_to_non_nullable
                  as bool,
        createdAt: null == createdAt
            ? _value.createdAt
            : createdAt // ignore: cast_nullable_to_non_nullable
                  as DateTime,
        updatedAt: null == updatedAt
            ? _value.updatedAt
            : updatedAt // ignore: cast_nullable_to_non_nullable
                  as DateTime,
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
class _$TripImpl implements _Trip {
  const _$TripImpl({
    required this.id,
    required this.name,
    this.description,
    this.coverImagePath,
    this.baseCurrency = 'BDT',
    required this.createdBy,
    this.startDate,
    this.endDate,
    this.isArchived = false,
    required this.createdAt,
    required this.updatedAt,
    required this.hlcTimestamp,
  });

  factory _$TripImpl.fromJson(Map<String, dynamic> json) =>
      _$$TripImplFromJson(json);

  @override
  final String id;
  @override
  final String name;
  @override
  final String? description;
  @override
  final String? coverImagePath;
  @override
  @JsonKey()
  final String baseCurrency;
  @override
  final String createdBy;
  @override
  final DateTime? startDate;
  @override
  final DateTime? endDate;
  @override
  @JsonKey()
  final bool isArchived;
  @override
  final DateTime createdAt;
  @override
  final DateTime updatedAt;
  @override
  final String hlcTimestamp;

  @override
  String toString() {
    return 'Trip(id: $id, name: $name, description: $description, coverImagePath: $coverImagePath, baseCurrency: $baseCurrency, createdBy: $createdBy, startDate: $startDate, endDate: $endDate, isArchived: $isArchived, createdAt: $createdAt, updatedAt: $updatedAt, hlcTimestamp: $hlcTimestamp)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TripImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.coverImagePath, coverImagePath) ||
                other.coverImagePath == coverImagePath) &&
            (identical(other.baseCurrency, baseCurrency) ||
                other.baseCurrency == baseCurrency) &&
            (identical(other.createdBy, createdBy) ||
                other.createdBy == createdBy) &&
            (identical(other.startDate, startDate) ||
                other.startDate == startDate) &&
            (identical(other.endDate, endDate) || other.endDate == endDate) &&
            (identical(other.isArchived, isArchived) ||
                other.isArchived == isArchived) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.updatedAt, updatedAt) ||
                other.updatedAt == updatedAt) &&
            (identical(other.hlcTimestamp, hlcTimestamp) ||
                other.hlcTimestamp == hlcTimestamp));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    name,
    description,
    coverImagePath,
    baseCurrency,
    createdBy,
    startDate,
    endDate,
    isArchived,
    createdAt,
    updatedAt,
    hlcTimestamp,
  );

  /// Create a copy of Trip
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$TripImplCopyWith<_$TripImpl> get copyWith =>
      __$$TripImplCopyWithImpl<_$TripImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$TripImplToJson(this);
  }
}

abstract class _Trip implements Trip {
  const factory _Trip({
    required final String id,
    required final String name,
    final String? description,
    final String? coverImagePath,
    final String baseCurrency,
    required final String createdBy,
    final DateTime? startDate,
    final DateTime? endDate,
    final bool isArchived,
    required final DateTime createdAt,
    required final DateTime updatedAt,
    required final String hlcTimestamp,
  }) = _$TripImpl;

  factory _Trip.fromJson(Map<String, dynamic> json) = _$TripImpl.fromJson;

  @override
  String get id;
  @override
  String get name;
  @override
  String? get description;
  @override
  String? get coverImagePath;
  @override
  String get baseCurrency;
  @override
  String get createdBy;
  @override
  DateTime? get startDate;
  @override
  DateTime? get endDate;
  @override
  bool get isArchived;
  @override
  DateTime get createdAt;
  @override
  DateTime get updatedAt;
  @override
  String get hlcTimestamp;

  /// Create a copy of Trip
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$TripImplCopyWith<_$TripImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
