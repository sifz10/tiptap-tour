// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_database.dart';

// ignore_for_file: type=lint
class $UsersTable extends Users with TableInfo<$UsersTable, User> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $UsersTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _displayNameMeta = const VerificationMeta(
    'displayName',
  );
  @override
  late final GeneratedColumn<String> displayName = GeneratedColumn<String>(
    'display_name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _avatarPathMeta = const VerificationMeta(
    'avatarPath',
  );
  @override
  late final GeneratedColumn<String> avatarPath = GeneratedColumn<String>(
    'avatar_path',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _deviceIdMeta = const VerificationMeta(
    'deviceId',
  );
  @override
  late final GeneratedColumn<String> deviceId = GeneratedColumn<String>(
    'device_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _phoneNumberMeta = const VerificationMeta(
    'phoneNumber',
  );
  @override
  late final GeneratedColumn<String> phoneNumber = GeneratedColumn<String>(
    'phone_number',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<int> createdAt = GeneratedColumn<int>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _hlcTimestampMeta = const VerificationMeta(
    'hlcTimestamp',
  );
  @override
  late final GeneratedColumn<String> hlcTimestamp = GeneratedColumn<String>(
    'hlc_timestamp',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    displayName,
    avatarPath,
    deviceId,
    phoneNumber,
    createdAt,
    hlcTimestamp,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'users';
  @override
  VerificationContext validateIntegrity(
    Insertable<User> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('display_name')) {
      context.handle(
        _displayNameMeta,
        displayName.isAcceptableOrUnknown(
          data['display_name']!,
          _displayNameMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_displayNameMeta);
    }
    if (data.containsKey('avatar_path')) {
      context.handle(
        _avatarPathMeta,
        avatarPath.isAcceptableOrUnknown(data['avatar_path']!, _avatarPathMeta),
      );
    }
    if (data.containsKey('device_id')) {
      context.handle(
        _deviceIdMeta,
        deviceId.isAcceptableOrUnknown(data['device_id']!, _deviceIdMeta),
      );
    } else if (isInserting) {
      context.missing(_deviceIdMeta);
    }
    if (data.containsKey('phone_number')) {
      context.handle(
        _phoneNumberMeta,
        phoneNumber.isAcceptableOrUnknown(
          data['phone_number']!,
          _phoneNumberMeta,
        ),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    if (data.containsKey('hlc_timestamp')) {
      context.handle(
        _hlcTimestampMeta,
        hlcTimestamp.isAcceptableOrUnknown(
          data['hlc_timestamp']!,
          _hlcTimestampMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_hlcTimestampMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  User map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return User(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      displayName: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}display_name'],
      )!,
      avatarPath: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}avatar_path'],
      ),
      deviceId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}device_id'],
      )!,
      phoneNumber: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}phone_number'],
      ),
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}created_at'],
      )!,
      hlcTimestamp: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}hlc_timestamp'],
      )!,
    );
  }

  @override
  $UsersTable createAlias(String alias) {
    return $UsersTable(attachedDatabase, alias);
  }
}

class User extends DataClass implements Insertable<User> {
  final String id;
  final String displayName;
  final String? avatarPath;
  final String deviceId;
  final String? phoneNumber;
  final int createdAt;
  final String hlcTimestamp;
  const User({
    required this.id,
    required this.displayName,
    this.avatarPath,
    required this.deviceId,
    this.phoneNumber,
    required this.createdAt,
    required this.hlcTimestamp,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['display_name'] = Variable<String>(displayName);
    if (!nullToAbsent || avatarPath != null) {
      map['avatar_path'] = Variable<String>(avatarPath);
    }
    map['device_id'] = Variable<String>(deviceId);
    if (!nullToAbsent || phoneNumber != null) {
      map['phone_number'] = Variable<String>(phoneNumber);
    }
    map['created_at'] = Variable<int>(createdAt);
    map['hlc_timestamp'] = Variable<String>(hlcTimestamp);
    return map;
  }

  UsersCompanion toCompanion(bool nullToAbsent) {
    return UsersCompanion(
      id: Value(id),
      displayName: Value(displayName),
      avatarPath: avatarPath == null && nullToAbsent
          ? const Value.absent()
          : Value(avatarPath),
      deviceId: Value(deviceId),
      phoneNumber: phoneNumber == null && nullToAbsent
          ? const Value.absent()
          : Value(phoneNumber),
      createdAt: Value(createdAt),
      hlcTimestamp: Value(hlcTimestamp),
    );
  }

  factory User.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return User(
      id: serializer.fromJson<String>(json['id']),
      displayName: serializer.fromJson<String>(json['displayName']),
      avatarPath: serializer.fromJson<String?>(json['avatarPath']),
      deviceId: serializer.fromJson<String>(json['deviceId']),
      phoneNumber: serializer.fromJson<String?>(json['phoneNumber']),
      createdAt: serializer.fromJson<int>(json['createdAt']),
      hlcTimestamp: serializer.fromJson<String>(json['hlcTimestamp']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'displayName': serializer.toJson<String>(displayName),
      'avatarPath': serializer.toJson<String?>(avatarPath),
      'deviceId': serializer.toJson<String>(deviceId),
      'phoneNumber': serializer.toJson<String?>(phoneNumber),
      'createdAt': serializer.toJson<int>(createdAt),
      'hlcTimestamp': serializer.toJson<String>(hlcTimestamp),
    };
  }

  User copyWith({
    String? id,
    String? displayName,
    Value<String?> avatarPath = const Value.absent(),
    String? deviceId,
    Value<String?> phoneNumber = const Value.absent(),
    int? createdAt,
    String? hlcTimestamp,
  }) => User(
    id: id ?? this.id,
    displayName: displayName ?? this.displayName,
    avatarPath: avatarPath.present ? avatarPath.value : this.avatarPath,
    deviceId: deviceId ?? this.deviceId,
    phoneNumber: phoneNumber.present ? phoneNumber.value : this.phoneNumber,
    createdAt: createdAt ?? this.createdAt,
    hlcTimestamp: hlcTimestamp ?? this.hlcTimestamp,
  );
  User copyWithCompanion(UsersCompanion data) {
    return User(
      id: data.id.present ? data.id.value : this.id,
      displayName: data.displayName.present
          ? data.displayName.value
          : this.displayName,
      avatarPath: data.avatarPath.present
          ? data.avatarPath.value
          : this.avatarPath,
      deviceId: data.deviceId.present ? data.deviceId.value : this.deviceId,
      phoneNumber: data.phoneNumber.present
          ? data.phoneNumber.value
          : this.phoneNumber,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      hlcTimestamp: data.hlcTimestamp.present
          ? data.hlcTimestamp.value
          : this.hlcTimestamp,
    );
  }

  @override
  String toString() {
    return (StringBuffer('User(')
          ..write('id: $id, ')
          ..write('displayName: $displayName, ')
          ..write('avatarPath: $avatarPath, ')
          ..write('deviceId: $deviceId, ')
          ..write('phoneNumber: $phoneNumber, ')
          ..write('createdAt: $createdAt, ')
          ..write('hlcTimestamp: $hlcTimestamp')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    displayName,
    avatarPath,
    deviceId,
    phoneNumber,
    createdAt,
    hlcTimestamp,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is User &&
          other.id == this.id &&
          other.displayName == this.displayName &&
          other.avatarPath == this.avatarPath &&
          other.deviceId == this.deviceId &&
          other.phoneNumber == this.phoneNumber &&
          other.createdAt == this.createdAt &&
          other.hlcTimestamp == this.hlcTimestamp);
}

class UsersCompanion extends UpdateCompanion<User> {
  final Value<String> id;
  final Value<String> displayName;
  final Value<String?> avatarPath;
  final Value<String> deviceId;
  final Value<String?> phoneNumber;
  final Value<int> createdAt;
  final Value<String> hlcTimestamp;
  final Value<int> rowid;
  const UsersCompanion({
    this.id = const Value.absent(),
    this.displayName = const Value.absent(),
    this.avatarPath = const Value.absent(),
    this.deviceId = const Value.absent(),
    this.phoneNumber = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.hlcTimestamp = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  UsersCompanion.insert({
    required String id,
    required String displayName,
    this.avatarPath = const Value.absent(),
    required String deviceId,
    this.phoneNumber = const Value.absent(),
    required int createdAt,
    required String hlcTimestamp,
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       displayName = Value(displayName),
       deviceId = Value(deviceId),
       createdAt = Value(createdAt),
       hlcTimestamp = Value(hlcTimestamp);
  static Insertable<User> custom({
    Expression<String>? id,
    Expression<String>? displayName,
    Expression<String>? avatarPath,
    Expression<String>? deviceId,
    Expression<String>? phoneNumber,
    Expression<int>? createdAt,
    Expression<String>? hlcTimestamp,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (displayName != null) 'display_name': displayName,
      if (avatarPath != null) 'avatar_path': avatarPath,
      if (deviceId != null) 'device_id': deviceId,
      if (phoneNumber != null) 'phone_number': phoneNumber,
      if (createdAt != null) 'created_at': createdAt,
      if (hlcTimestamp != null) 'hlc_timestamp': hlcTimestamp,
      if (rowid != null) 'rowid': rowid,
    });
  }

  UsersCompanion copyWith({
    Value<String>? id,
    Value<String>? displayName,
    Value<String?>? avatarPath,
    Value<String>? deviceId,
    Value<String?>? phoneNumber,
    Value<int>? createdAt,
    Value<String>? hlcTimestamp,
    Value<int>? rowid,
  }) {
    return UsersCompanion(
      id: id ?? this.id,
      displayName: displayName ?? this.displayName,
      avatarPath: avatarPath ?? this.avatarPath,
      deviceId: deviceId ?? this.deviceId,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      createdAt: createdAt ?? this.createdAt,
      hlcTimestamp: hlcTimestamp ?? this.hlcTimestamp,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (displayName.present) {
      map['display_name'] = Variable<String>(displayName.value);
    }
    if (avatarPath.present) {
      map['avatar_path'] = Variable<String>(avatarPath.value);
    }
    if (deviceId.present) {
      map['device_id'] = Variable<String>(deviceId.value);
    }
    if (phoneNumber.present) {
      map['phone_number'] = Variable<String>(phoneNumber.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<int>(createdAt.value);
    }
    if (hlcTimestamp.present) {
      map['hlc_timestamp'] = Variable<String>(hlcTimestamp.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('UsersCompanion(')
          ..write('id: $id, ')
          ..write('displayName: $displayName, ')
          ..write('avatarPath: $avatarPath, ')
          ..write('deviceId: $deviceId, ')
          ..write('phoneNumber: $phoneNumber, ')
          ..write('createdAt: $createdAt, ')
          ..write('hlcTimestamp: $hlcTimestamp, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $TripsTable extends Trips with TableInfo<$TripsTable, Trip> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $TripsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
    'name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _descriptionMeta = const VerificationMeta(
    'description',
  );
  @override
  late final GeneratedColumn<String> description = GeneratedColumn<String>(
    'description',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _coverImagePathMeta = const VerificationMeta(
    'coverImagePath',
  );
  @override
  late final GeneratedColumn<String> coverImagePath = GeneratedColumn<String>(
    'cover_image_path',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _baseCurrencyMeta = const VerificationMeta(
    'baseCurrency',
  );
  @override
  late final GeneratedColumn<String> baseCurrency = GeneratedColumn<String>(
    'base_currency',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('BDT'),
  );
  static const VerificationMeta _createdByMeta = const VerificationMeta(
    'createdBy',
  );
  @override
  late final GeneratedColumn<String> createdBy = GeneratedColumn<String>(
    'created_by',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _startDateMeta = const VerificationMeta(
    'startDate',
  );
  @override
  late final GeneratedColumn<int> startDate = GeneratedColumn<int>(
    'start_date',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _endDateMeta = const VerificationMeta(
    'endDate',
  );
  @override
  late final GeneratedColumn<int> endDate = GeneratedColumn<int>(
    'end_date',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _isArchivedMeta = const VerificationMeta(
    'isArchived',
  );
  @override
  late final GeneratedColumn<bool> isArchived = GeneratedColumn<bool>(
    'is_archived',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_archived" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<int> createdAt = GeneratedColumn<int>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<int> updatedAt = GeneratedColumn<int>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _hlcTimestampMeta = const VerificationMeta(
    'hlcTimestamp',
  );
  @override
  late final GeneratedColumn<String> hlcTimestamp = GeneratedColumn<String>(
    'hlc_timestamp',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
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
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'trips';
  @override
  VerificationContext validateIntegrity(
    Insertable<Trip> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('description')) {
      context.handle(
        _descriptionMeta,
        description.isAcceptableOrUnknown(
          data['description']!,
          _descriptionMeta,
        ),
      );
    }
    if (data.containsKey('cover_image_path')) {
      context.handle(
        _coverImagePathMeta,
        coverImagePath.isAcceptableOrUnknown(
          data['cover_image_path']!,
          _coverImagePathMeta,
        ),
      );
    }
    if (data.containsKey('base_currency')) {
      context.handle(
        _baseCurrencyMeta,
        baseCurrency.isAcceptableOrUnknown(
          data['base_currency']!,
          _baseCurrencyMeta,
        ),
      );
    }
    if (data.containsKey('created_by')) {
      context.handle(
        _createdByMeta,
        createdBy.isAcceptableOrUnknown(data['created_by']!, _createdByMeta),
      );
    } else if (isInserting) {
      context.missing(_createdByMeta);
    }
    if (data.containsKey('start_date')) {
      context.handle(
        _startDateMeta,
        startDate.isAcceptableOrUnknown(data['start_date']!, _startDateMeta),
      );
    }
    if (data.containsKey('end_date')) {
      context.handle(
        _endDateMeta,
        endDate.isAcceptableOrUnknown(data['end_date']!, _endDateMeta),
      );
    }
    if (data.containsKey('is_archived')) {
      context.handle(
        _isArchivedMeta,
        isArchived.isAcceptableOrUnknown(data['is_archived']!, _isArchivedMeta),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_updatedAtMeta);
    }
    if (data.containsKey('hlc_timestamp')) {
      context.handle(
        _hlcTimestampMeta,
        hlcTimestamp.isAcceptableOrUnknown(
          data['hlc_timestamp']!,
          _hlcTimestampMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_hlcTimestampMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Trip map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Trip(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      description: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}description'],
      ),
      coverImagePath: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}cover_image_path'],
      ),
      baseCurrency: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}base_currency'],
      )!,
      createdBy: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}created_by'],
      )!,
      startDate: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}start_date'],
      ),
      endDate: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}end_date'],
      ),
      isArchived: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_archived'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}created_at'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}updated_at'],
      )!,
      hlcTimestamp: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}hlc_timestamp'],
      )!,
    );
  }

  @override
  $TripsTable createAlias(String alias) {
    return $TripsTable(attachedDatabase, alias);
  }
}

class Trip extends DataClass implements Insertable<Trip> {
  final String id;
  final String name;
  final String? description;
  final String? coverImagePath;
  final String baseCurrency;
  final String createdBy;
  final int? startDate;
  final int? endDate;
  final bool isArchived;
  final int createdAt;
  final int updatedAt;
  final String hlcTimestamp;
  const Trip({
    required this.id,
    required this.name,
    this.description,
    this.coverImagePath,
    required this.baseCurrency,
    required this.createdBy,
    this.startDate,
    this.endDate,
    required this.isArchived,
    required this.createdAt,
    required this.updatedAt,
    required this.hlcTimestamp,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['name'] = Variable<String>(name);
    if (!nullToAbsent || description != null) {
      map['description'] = Variable<String>(description);
    }
    if (!nullToAbsent || coverImagePath != null) {
      map['cover_image_path'] = Variable<String>(coverImagePath);
    }
    map['base_currency'] = Variable<String>(baseCurrency);
    map['created_by'] = Variable<String>(createdBy);
    if (!nullToAbsent || startDate != null) {
      map['start_date'] = Variable<int>(startDate);
    }
    if (!nullToAbsent || endDate != null) {
      map['end_date'] = Variable<int>(endDate);
    }
    map['is_archived'] = Variable<bool>(isArchived);
    map['created_at'] = Variable<int>(createdAt);
    map['updated_at'] = Variable<int>(updatedAt);
    map['hlc_timestamp'] = Variable<String>(hlcTimestamp);
    return map;
  }

  TripsCompanion toCompanion(bool nullToAbsent) {
    return TripsCompanion(
      id: Value(id),
      name: Value(name),
      description: description == null && nullToAbsent
          ? const Value.absent()
          : Value(description),
      coverImagePath: coverImagePath == null && nullToAbsent
          ? const Value.absent()
          : Value(coverImagePath),
      baseCurrency: Value(baseCurrency),
      createdBy: Value(createdBy),
      startDate: startDate == null && nullToAbsent
          ? const Value.absent()
          : Value(startDate),
      endDate: endDate == null && nullToAbsent
          ? const Value.absent()
          : Value(endDate),
      isArchived: Value(isArchived),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
      hlcTimestamp: Value(hlcTimestamp),
    );
  }

  factory Trip.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Trip(
      id: serializer.fromJson<String>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      description: serializer.fromJson<String?>(json['description']),
      coverImagePath: serializer.fromJson<String?>(json['coverImagePath']),
      baseCurrency: serializer.fromJson<String>(json['baseCurrency']),
      createdBy: serializer.fromJson<String>(json['createdBy']),
      startDate: serializer.fromJson<int?>(json['startDate']),
      endDate: serializer.fromJson<int?>(json['endDate']),
      isArchived: serializer.fromJson<bool>(json['isArchived']),
      createdAt: serializer.fromJson<int>(json['createdAt']),
      updatedAt: serializer.fromJson<int>(json['updatedAt']),
      hlcTimestamp: serializer.fromJson<String>(json['hlcTimestamp']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'name': serializer.toJson<String>(name),
      'description': serializer.toJson<String?>(description),
      'coverImagePath': serializer.toJson<String?>(coverImagePath),
      'baseCurrency': serializer.toJson<String>(baseCurrency),
      'createdBy': serializer.toJson<String>(createdBy),
      'startDate': serializer.toJson<int?>(startDate),
      'endDate': serializer.toJson<int?>(endDate),
      'isArchived': serializer.toJson<bool>(isArchived),
      'createdAt': serializer.toJson<int>(createdAt),
      'updatedAt': serializer.toJson<int>(updatedAt),
      'hlcTimestamp': serializer.toJson<String>(hlcTimestamp),
    };
  }

  Trip copyWith({
    String? id,
    String? name,
    Value<String?> description = const Value.absent(),
    Value<String?> coverImagePath = const Value.absent(),
    String? baseCurrency,
    String? createdBy,
    Value<int?> startDate = const Value.absent(),
    Value<int?> endDate = const Value.absent(),
    bool? isArchived,
    int? createdAt,
    int? updatedAt,
    String? hlcTimestamp,
  }) => Trip(
    id: id ?? this.id,
    name: name ?? this.name,
    description: description.present ? description.value : this.description,
    coverImagePath: coverImagePath.present
        ? coverImagePath.value
        : this.coverImagePath,
    baseCurrency: baseCurrency ?? this.baseCurrency,
    createdBy: createdBy ?? this.createdBy,
    startDate: startDate.present ? startDate.value : this.startDate,
    endDate: endDate.present ? endDate.value : this.endDate,
    isArchived: isArchived ?? this.isArchived,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
    hlcTimestamp: hlcTimestamp ?? this.hlcTimestamp,
  );
  Trip copyWithCompanion(TripsCompanion data) {
    return Trip(
      id: data.id.present ? data.id.value : this.id,
      name: data.name.present ? data.name.value : this.name,
      description: data.description.present
          ? data.description.value
          : this.description,
      coverImagePath: data.coverImagePath.present
          ? data.coverImagePath.value
          : this.coverImagePath,
      baseCurrency: data.baseCurrency.present
          ? data.baseCurrency.value
          : this.baseCurrency,
      createdBy: data.createdBy.present ? data.createdBy.value : this.createdBy,
      startDate: data.startDate.present ? data.startDate.value : this.startDate,
      endDate: data.endDate.present ? data.endDate.value : this.endDate,
      isArchived: data.isArchived.present
          ? data.isArchived.value
          : this.isArchived,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
      hlcTimestamp: data.hlcTimestamp.present
          ? data.hlcTimestamp.value
          : this.hlcTimestamp,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Trip(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('description: $description, ')
          ..write('coverImagePath: $coverImagePath, ')
          ..write('baseCurrency: $baseCurrency, ')
          ..write('createdBy: $createdBy, ')
          ..write('startDate: $startDate, ')
          ..write('endDate: $endDate, ')
          ..write('isArchived: $isArchived, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('hlcTimestamp: $hlcTimestamp')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
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
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Trip &&
          other.id == this.id &&
          other.name == this.name &&
          other.description == this.description &&
          other.coverImagePath == this.coverImagePath &&
          other.baseCurrency == this.baseCurrency &&
          other.createdBy == this.createdBy &&
          other.startDate == this.startDate &&
          other.endDate == this.endDate &&
          other.isArchived == this.isArchived &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt &&
          other.hlcTimestamp == this.hlcTimestamp);
}

class TripsCompanion extends UpdateCompanion<Trip> {
  final Value<String> id;
  final Value<String> name;
  final Value<String?> description;
  final Value<String?> coverImagePath;
  final Value<String> baseCurrency;
  final Value<String> createdBy;
  final Value<int?> startDate;
  final Value<int?> endDate;
  final Value<bool> isArchived;
  final Value<int> createdAt;
  final Value<int> updatedAt;
  final Value<String> hlcTimestamp;
  final Value<int> rowid;
  const TripsCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.description = const Value.absent(),
    this.coverImagePath = const Value.absent(),
    this.baseCurrency = const Value.absent(),
    this.createdBy = const Value.absent(),
    this.startDate = const Value.absent(),
    this.endDate = const Value.absent(),
    this.isArchived = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.hlcTimestamp = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  TripsCompanion.insert({
    required String id,
    required String name,
    this.description = const Value.absent(),
    this.coverImagePath = const Value.absent(),
    this.baseCurrency = const Value.absent(),
    required String createdBy,
    this.startDate = const Value.absent(),
    this.endDate = const Value.absent(),
    this.isArchived = const Value.absent(),
    required int createdAt,
    required int updatedAt,
    required String hlcTimestamp,
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       name = Value(name),
       createdBy = Value(createdBy),
       createdAt = Value(createdAt),
       updatedAt = Value(updatedAt),
       hlcTimestamp = Value(hlcTimestamp);
  static Insertable<Trip> custom({
    Expression<String>? id,
    Expression<String>? name,
    Expression<String>? description,
    Expression<String>? coverImagePath,
    Expression<String>? baseCurrency,
    Expression<String>? createdBy,
    Expression<int>? startDate,
    Expression<int>? endDate,
    Expression<bool>? isArchived,
    Expression<int>? createdAt,
    Expression<int>? updatedAt,
    Expression<String>? hlcTimestamp,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (description != null) 'description': description,
      if (coverImagePath != null) 'cover_image_path': coverImagePath,
      if (baseCurrency != null) 'base_currency': baseCurrency,
      if (createdBy != null) 'created_by': createdBy,
      if (startDate != null) 'start_date': startDate,
      if (endDate != null) 'end_date': endDate,
      if (isArchived != null) 'is_archived': isArchived,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (hlcTimestamp != null) 'hlc_timestamp': hlcTimestamp,
      if (rowid != null) 'rowid': rowid,
    });
  }

  TripsCompanion copyWith({
    Value<String>? id,
    Value<String>? name,
    Value<String?>? description,
    Value<String?>? coverImagePath,
    Value<String>? baseCurrency,
    Value<String>? createdBy,
    Value<int?>? startDate,
    Value<int?>? endDate,
    Value<bool>? isArchived,
    Value<int>? createdAt,
    Value<int>? updatedAt,
    Value<String>? hlcTimestamp,
    Value<int>? rowid,
  }) {
    return TripsCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      coverImagePath: coverImagePath ?? this.coverImagePath,
      baseCurrency: baseCurrency ?? this.baseCurrency,
      createdBy: createdBy ?? this.createdBy,
      startDate: startDate ?? this.startDate,
      endDate: endDate ?? this.endDate,
      isArchived: isArchived ?? this.isArchived,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      hlcTimestamp: hlcTimestamp ?? this.hlcTimestamp,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (description.present) {
      map['description'] = Variable<String>(description.value);
    }
    if (coverImagePath.present) {
      map['cover_image_path'] = Variable<String>(coverImagePath.value);
    }
    if (baseCurrency.present) {
      map['base_currency'] = Variable<String>(baseCurrency.value);
    }
    if (createdBy.present) {
      map['created_by'] = Variable<String>(createdBy.value);
    }
    if (startDate.present) {
      map['start_date'] = Variable<int>(startDate.value);
    }
    if (endDate.present) {
      map['end_date'] = Variable<int>(endDate.value);
    }
    if (isArchived.present) {
      map['is_archived'] = Variable<bool>(isArchived.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<int>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<int>(updatedAt.value);
    }
    if (hlcTimestamp.present) {
      map['hlc_timestamp'] = Variable<String>(hlcTimestamp.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('TripsCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('description: $description, ')
          ..write('coverImagePath: $coverImagePath, ')
          ..write('baseCurrency: $baseCurrency, ')
          ..write('createdBy: $createdBy, ')
          ..write('startDate: $startDate, ')
          ..write('endDate: $endDate, ')
          ..write('isArchived: $isArchived, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('hlcTimestamp: $hlcTimestamp, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $TripMembersTable extends TripMembers
    with TableInfo<$TripMembersTable, TripMember> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $TripMembersTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _tripIdMeta = const VerificationMeta('tripId');
  @override
  late final GeneratedColumn<String> tripId = GeneratedColumn<String>(
    'trip_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _userIdMeta = const VerificationMeta('userId');
  @override
  late final GeneratedColumn<String> userId = GeneratedColumn<String>(
    'user_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _roleMeta = const VerificationMeta('role');
  @override
  late final GeneratedColumn<String> role = GeneratedColumn<String>(
    'role',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('member'),
  );
  static const VerificationMeta _joinedAtMeta = const VerificationMeta(
    'joinedAt',
  );
  @override
  late final GeneratedColumn<int> joinedAt = GeneratedColumn<int>(
    'joined_at',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [tripId, userId, role, joinedAt];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'trip_members';
  @override
  VerificationContext validateIntegrity(
    Insertable<TripMember> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('trip_id')) {
      context.handle(
        _tripIdMeta,
        tripId.isAcceptableOrUnknown(data['trip_id']!, _tripIdMeta),
      );
    } else if (isInserting) {
      context.missing(_tripIdMeta);
    }
    if (data.containsKey('user_id')) {
      context.handle(
        _userIdMeta,
        userId.isAcceptableOrUnknown(data['user_id']!, _userIdMeta),
      );
    } else if (isInserting) {
      context.missing(_userIdMeta);
    }
    if (data.containsKey('role')) {
      context.handle(
        _roleMeta,
        role.isAcceptableOrUnknown(data['role']!, _roleMeta),
      );
    }
    if (data.containsKey('joined_at')) {
      context.handle(
        _joinedAtMeta,
        joinedAt.isAcceptableOrUnknown(data['joined_at']!, _joinedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_joinedAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {tripId, userId};
  @override
  TripMember map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return TripMember(
      tripId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}trip_id'],
      )!,
      userId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}user_id'],
      )!,
      role: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}role'],
      )!,
      joinedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}joined_at'],
      )!,
    );
  }

  @override
  $TripMembersTable createAlias(String alias) {
    return $TripMembersTable(attachedDatabase, alias);
  }
}

class TripMember extends DataClass implements Insertable<TripMember> {
  final String tripId;
  final String userId;
  final String role;
  final int joinedAt;
  const TripMember({
    required this.tripId,
    required this.userId,
    required this.role,
    required this.joinedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['trip_id'] = Variable<String>(tripId);
    map['user_id'] = Variable<String>(userId);
    map['role'] = Variable<String>(role);
    map['joined_at'] = Variable<int>(joinedAt);
    return map;
  }

  TripMembersCompanion toCompanion(bool nullToAbsent) {
    return TripMembersCompanion(
      tripId: Value(tripId),
      userId: Value(userId),
      role: Value(role),
      joinedAt: Value(joinedAt),
    );
  }

  factory TripMember.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return TripMember(
      tripId: serializer.fromJson<String>(json['tripId']),
      userId: serializer.fromJson<String>(json['userId']),
      role: serializer.fromJson<String>(json['role']),
      joinedAt: serializer.fromJson<int>(json['joinedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'tripId': serializer.toJson<String>(tripId),
      'userId': serializer.toJson<String>(userId),
      'role': serializer.toJson<String>(role),
      'joinedAt': serializer.toJson<int>(joinedAt),
    };
  }

  TripMember copyWith({
    String? tripId,
    String? userId,
    String? role,
    int? joinedAt,
  }) => TripMember(
    tripId: tripId ?? this.tripId,
    userId: userId ?? this.userId,
    role: role ?? this.role,
    joinedAt: joinedAt ?? this.joinedAt,
  );
  TripMember copyWithCompanion(TripMembersCompanion data) {
    return TripMember(
      tripId: data.tripId.present ? data.tripId.value : this.tripId,
      userId: data.userId.present ? data.userId.value : this.userId,
      role: data.role.present ? data.role.value : this.role,
      joinedAt: data.joinedAt.present ? data.joinedAt.value : this.joinedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('TripMember(')
          ..write('tripId: $tripId, ')
          ..write('userId: $userId, ')
          ..write('role: $role, ')
          ..write('joinedAt: $joinedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(tripId, userId, role, joinedAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is TripMember &&
          other.tripId == this.tripId &&
          other.userId == this.userId &&
          other.role == this.role &&
          other.joinedAt == this.joinedAt);
}

class TripMembersCompanion extends UpdateCompanion<TripMember> {
  final Value<String> tripId;
  final Value<String> userId;
  final Value<String> role;
  final Value<int> joinedAt;
  final Value<int> rowid;
  const TripMembersCompanion({
    this.tripId = const Value.absent(),
    this.userId = const Value.absent(),
    this.role = const Value.absent(),
    this.joinedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  TripMembersCompanion.insert({
    required String tripId,
    required String userId,
    this.role = const Value.absent(),
    required int joinedAt,
    this.rowid = const Value.absent(),
  }) : tripId = Value(tripId),
       userId = Value(userId),
       joinedAt = Value(joinedAt);
  static Insertable<TripMember> custom({
    Expression<String>? tripId,
    Expression<String>? userId,
    Expression<String>? role,
    Expression<int>? joinedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (tripId != null) 'trip_id': tripId,
      if (userId != null) 'user_id': userId,
      if (role != null) 'role': role,
      if (joinedAt != null) 'joined_at': joinedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  TripMembersCompanion copyWith({
    Value<String>? tripId,
    Value<String>? userId,
    Value<String>? role,
    Value<int>? joinedAt,
    Value<int>? rowid,
  }) {
    return TripMembersCompanion(
      tripId: tripId ?? this.tripId,
      userId: userId ?? this.userId,
      role: role ?? this.role,
      joinedAt: joinedAt ?? this.joinedAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (tripId.present) {
      map['trip_id'] = Variable<String>(tripId.value);
    }
    if (userId.present) {
      map['user_id'] = Variable<String>(userId.value);
    }
    if (role.present) {
      map['role'] = Variable<String>(role.value);
    }
    if (joinedAt.present) {
      map['joined_at'] = Variable<int>(joinedAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('TripMembersCompanion(')
          ..write('tripId: $tripId, ')
          ..write('userId: $userId, ')
          ..write('role: $role, ')
          ..write('joinedAt: $joinedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $ExpensesTable extends Expenses with TableInfo<$ExpensesTable, Expense> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ExpensesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _tripIdMeta = const VerificationMeta('tripId');
  @override
  late final GeneratedColumn<String> tripId = GeneratedColumn<String>(
    'trip_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _paidByMeta = const VerificationMeta('paidBy');
  @override
  late final GeneratedColumn<String> paidBy = GeneratedColumn<String>(
    'paid_by',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _titleMeta = const VerificationMeta('title');
  @override
  late final GeneratedColumn<String> title = GeneratedColumn<String>(
    'title',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _amountMeta = const VerificationMeta('amount');
  @override
  late final GeneratedColumn<double> amount = GeneratedColumn<double>(
    'amount',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _currencyMeta = const VerificationMeta(
    'currency',
  );
  @override
  late final GeneratedColumn<String> currency = GeneratedColumn<String>(
    'currency',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('BDT'),
  );
  static const VerificationMeta _categoryMeta = const VerificationMeta(
    'category',
  );
  @override
  late final GeneratedColumn<String> category = GeneratedColumn<String>(
    'category',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _splitTypeMeta = const VerificationMeta(
    'splitType',
  );
  @override
  late final GeneratedColumn<String> splitType = GeneratedColumn<String>(
    'split_type',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _receiptImagePathMeta = const VerificationMeta(
    'receiptImagePath',
  );
  @override
  late final GeneratedColumn<String> receiptImagePath = GeneratedColumn<String>(
    'receipt_image_path',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _notesMeta = const VerificationMeta('notes');
  @override
  late final GeneratedColumn<String> notes = GeneratedColumn<String>(
    'notes',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _expenseDateMeta = const VerificationMeta(
    'expenseDate',
  );
  @override
  late final GeneratedColumn<int> expenseDate = GeneratedColumn<int>(
    'expense_date',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<int> createdAt = GeneratedColumn<int>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<int> updatedAt = GeneratedColumn<int>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _isDeletedMeta = const VerificationMeta(
    'isDeleted',
  );
  @override
  late final GeneratedColumn<bool> isDeleted = GeneratedColumn<bool>(
    'is_deleted',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_deleted" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  static const VerificationMeta _hlcTimestampMeta = const VerificationMeta(
    'hlcTimestamp',
  );
  @override
  late final GeneratedColumn<String> hlcTimestamp = GeneratedColumn<String>(
    'hlc_timestamp',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
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
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'expenses';
  @override
  VerificationContext validateIntegrity(
    Insertable<Expense> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('trip_id')) {
      context.handle(
        _tripIdMeta,
        tripId.isAcceptableOrUnknown(data['trip_id']!, _tripIdMeta),
      );
    } else if (isInserting) {
      context.missing(_tripIdMeta);
    }
    if (data.containsKey('paid_by')) {
      context.handle(
        _paidByMeta,
        paidBy.isAcceptableOrUnknown(data['paid_by']!, _paidByMeta),
      );
    } else if (isInserting) {
      context.missing(_paidByMeta);
    }
    if (data.containsKey('title')) {
      context.handle(
        _titleMeta,
        title.isAcceptableOrUnknown(data['title']!, _titleMeta),
      );
    } else if (isInserting) {
      context.missing(_titleMeta);
    }
    if (data.containsKey('amount')) {
      context.handle(
        _amountMeta,
        amount.isAcceptableOrUnknown(data['amount']!, _amountMeta),
      );
    } else if (isInserting) {
      context.missing(_amountMeta);
    }
    if (data.containsKey('currency')) {
      context.handle(
        _currencyMeta,
        currency.isAcceptableOrUnknown(data['currency']!, _currencyMeta),
      );
    }
    if (data.containsKey('category')) {
      context.handle(
        _categoryMeta,
        category.isAcceptableOrUnknown(data['category']!, _categoryMeta),
      );
    } else if (isInserting) {
      context.missing(_categoryMeta);
    }
    if (data.containsKey('split_type')) {
      context.handle(
        _splitTypeMeta,
        splitType.isAcceptableOrUnknown(data['split_type']!, _splitTypeMeta),
      );
    } else if (isInserting) {
      context.missing(_splitTypeMeta);
    }
    if (data.containsKey('receipt_image_path')) {
      context.handle(
        _receiptImagePathMeta,
        receiptImagePath.isAcceptableOrUnknown(
          data['receipt_image_path']!,
          _receiptImagePathMeta,
        ),
      );
    }
    if (data.containsKey('notes')) {
      context.handle(
        _notesMeta,
        notes.isAcceptableOrUnknown(data['notes']!, _notesMeta),
      );
    }
    if (data.containsKey('expense_date')) {
      context.handle(
        _expenseDateMeta,
        expenseDate.isAcceptableOrUnknown(
          data['expense_date']!,
          _expenseDateMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_expenseDateMeta);
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_updatedAtMeta);
    }
    if (data.containsKey('is_deleted')) {
      context.handle(
        _isDeletedMeta,
        isDeleted.isAcceptableOrUnknown(data['is_deleted']!, _isDeletedMeta),
      );
    }
    if (data.containsKey('hlc_timestamp')) {
      context.handle(
        _hlcTimestampMeta,
        hlcTimestamp.isAcceptableOrUnknown(
          data['hlc_timestamp']!,
          _hlcTimestampMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_hlcTimestampMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Expense map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Expense(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      tripId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}trip_id'],
      )!,
      paidBy: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}paid_by'],
      )!,
      title: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}title'],
      )!,
      amount: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}amount'],
      )!,
      currency: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}currency'],
      )!,
      category: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}category'],
      )!,
      splitType: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}split_type'],
      )!,
      receiptImagePath: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}receipt_image_path'],
      ),
      notes: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}notes'],
      ),
      expenseDate: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}expense_date'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}created_at'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}updated_at'],
      )!,
      isDeleted: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_deleted'],
      )!,
      hlcTimestamp: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}hlc_timestamp'],
      )!,
    );
  }

  @override
  $ExpensesTable createAlias(String alias) {
    return $ExpensesTable(attachedDatabase, alias);
  }
}

class Expense extends DataClass implements Insertable<Expense> {
  final String id;
  final String tripId;
  final String paidBy;
  final String title;
  final double amount;
  final String currency;
  final String category;
  final String splitType;
  final String? receiptImagePath;
  final String? notes;
  final int expenseDate;
  final int createdAt;
  final int updatedAt;
  final bool isDeleted;
  final String hlcTimestamp;
  const Expense({
    required this.id,
    required this.tripId,
    required this.paidBy,
    required this.title,
    required this.amount,
    required this.currency,
    required this.category,
    required this.splitType,
    this.receiptImagePath,
    this.notes,
    required this.expenseDate,
    required this.createdAt,
    required this.updatedAt,
    required this.isDeleted,
    required this.hlcTimestamp,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['trip_id'] = Variable<String>(tripId);
    map['paid_by'] = Variable<String>(paidBy);
    map['title'] = Variable<String>(title);
    map['amount'] = Variable<double>(amount);
    map['currency'] = Variable<String>(currency);
    map['category'] = Variable<String>(category);
    map['split_type'] = Variable<String>(splitType);
    if (!nullToAbsent || receiptImagePath != null) {
      map['receipt_image_path'] = Variable<String>(receiptImagePath);
    }
    if (!nullToAbsent || notes != null) {
      map['notes'] = Variable<String>(notes);
    }
    map['expense_date'] = Variable<int>(expenseDate);
    map['created_at'] = Variable<int>(createdAt);
    map['updated_at'] = Variable<int>(updatedAt);
    map['is_deleted'] = Variable<bool>(isDeleted);
    map['hlc_timestamp'] = Variable<String>(hlcTimestamp);
    return map;
  }

  ExpensesCompanion toCompanion(bool nullToAbsent) {
    return ExpensesCompanion(
      id: Value(id),
      tripId: Value(tripId),
      paidBy: Value(paidBy),
      title: Value(title),
      amount: Value(amount),
      currency: Value(currency),
      category: Value(category),
      splitType: Value(splitType),
      receiptImagePath: receiptImagePath == null && nullToAbsent
          ? const Value.absent()
          : Value(receiptImagePath),
      notes: notes == null && nullToAbsent
          ? const Value.absent()
          : Value(notes),
      expenseDate: Value(expenseDate),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
      isDeleted: Value(isDeleted),
      hlcTimestamp: Value(hlcTimestamp),
    );
  }

  factory Expense.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Expense(
      id: serializer.fromJson<String>(json['id']),
      tripId: serializer.fromJson<String>(json['tripId']),
      paidBy: serializer.fromJson<String>(json['paidBy']),
      title: serializer.fromJson<String>(json['title']),
      amount: serializer.fromJson<double>(json['amount']),
      currency: serializer.fromJson<String>(json['currency']),
      category: serializer.fromJson<String>(json['category']),
      splitType: serializer.fromJson<String>(json['splitType']),
      receiptImagePath: serializer.fromJson<String?>(json['receiptImagePath']),
      notes: serializer.fromJson<String?>(json['notes']),
      expenseDate: serializer.fromJson<int>(json['expenseDate']),
      createdAt: serializer.fromJson<int>(json['createdAt']),
      updatedAt: serializer.fromJson<int>(json['updatedAt']),
      isDeleted: serializer.fromJson<bool>(json['isDeleted']),
      hlcTimestamp: serializer.fromJson<String>(json['hlcTimestamp']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'tripId': serializer.toJson<String>(tripId),
      'paidBy': serializer.toJson<String>(paidBy),
      'title': serializer.toJson<String>(title),
      'amount': serializer.toJson<double>(amount),
      'currency': serializer.toJson<String>(currency),
      'category': serializer.toJson<String>(category),
      'splitType': serializer.toJson<String>(splitType),
      'receiptImagePath': serializer.toJson<String?>(receiptImagePath),
      'notes': serializer.toJson<String?>(notes),
      'expenseDate': serializer.toJson<int>(expenseDate),
      'createdAt': serializer.toJson<int>(createdAt),
      'updatedAt': serializer.toJson<int>(updatedAt),
      'isDeleted': serializer.toJson<bool>(isDeleted),
      'hlcTimestamp': serializer.toJson<String>(hlcTimestamp),
    };
  }

  Expense copyWith({
    String? id,
    String? tripId,
    String? paidBy,
    String? title,
    double? amount,
    String? currency,
    String? category,
    String? splitType,
    Value<String?> receiptImagePath = const Value.absent(),
    Value<String?> notes = const Value.absent(),
    int? expenseDate,
    int? createdAt,
    int? updatedAt,
    bool? isDeleted,
    String? hlcTimestamp,
  }) => Expense(
    id: id ?? this.id,
    tripId: tripId ?? this.tripId,
    paidBy: paidBy ?? this.paidBy,
    title: title ?? this.title,
    amount: amount ?? this.amount,
    currency: currency ?? this.currency,
    category: category ?? this.category,
    splitType: splitType ?? this.splitType,
    receiptImagePath: receiptImagePath.present
        ? receiptImagePath.value
        : this.receiptImagePath,
    notes: notes.present ? notes.value : this.notes,
    expenseDate: expenseDate ?? this.expenseDate,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
    isDeleted: isDeleted ?? this.isDeleted,
    hlcTimestamp: hlcTimestamp ?? this.hlcTimestamp,
  );
  Expense copyWithCompanion(ExpensesCompanion data) {
    return Expense(
      id: data.id.present ? data.id.value : this.id,
      tripId: data.tripId.present ? data.tripId.value : this.tripId,
      paidBy: data.paidBy.present ? data.paidBy.value : this.paidBy,
      title: data.title.present ? data.title.value : this.title,
      amount: data.amount.present ? data.amount.value : this.amount,
      currency: data.currency.present ? data.currency.value : this.currency,
      category: data.category.present ? data.category.value : this.category,
      splitType: data.splitType.present ? data.splitType.value : this.splitType,
      receiptImagePath: data.receiptImagePath.present
          ? data.receiptImagePath.value
          : this.receiptImagePath,
      notes: data.notes.present ? data.notes.value : this.notes,
      expenseDate: data.expenseDate.present
          ? data.expenseDate.value
          : this.expenseDate,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
      isDeleted: data.isDeleted.present ? data.isDeleted.value : this.isDeleted,
      hlcTimestamp: data.hlcTimestamp.present
          ? data.hlcTimestamp.value
          : this.hlcTimestamp,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Expense(')
          ..write('id: $id, ')
          ..write('tripId: $tripId, ')
          ..write('paidBy: $paidBy, ')
          ..write('title: $title, ')
          ..write('amount: $amount, ')
          ..write('currency: $currency, ')
          ..write('category: $category, ')
          ..write('splitType: $splitType, ')
          ..write('receiptImagePath: $receiptImagePath, ')
          ..write('notes: $notes, ')
          ..write('expenseDate: $expenseDate, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('isDeleted: $isDeleted, ')
          ..write('hlcTimestamp: $hlcTimestamp')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
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
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Expense &&
          other.id == this.id &&
          other.tripId == this.tripId &&
          other.paidBy == this.paidBy &&
          other.title == this.title &&
          other.amount == this.amount &&
          other.currency == this.currency &&
          other.category == this.category &&
          other.splitType == this.splitType &&
          other.receiptImagePath == this.receiptImagePath &&
          other.notes == this.notes &&
          other.expenseDate == this.expenseDate &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt &&
          other.isDeleted == this.isDeleted &&
          other.hlcTimestamp == this.hlcTimestamp);
}

class ExpensesCompanion extends UpdateCompanion<Expense> {
  final Value<String> id;
  final Value<String> tripId;
  final Value<String> paidBy;
  final Value<String> title;
  final Value<double> amount;
  final Value<String> currency;
  final Value<String> category;
  final Value<String> splitType;
  final Value<String?> receiptImagePath;
  final Value<String?> notes;
  final Value<int> expenseDate;
  final Value<int> createdAt;
  final Value<int> updatedAt;
  final Value<bool> isDeleted;
  final Value<String> hlcTimestamp;
  final Value<int> rowid;
  const ExpensesCompanion({
    this.id = const Value.absent(),
    this.tripId = const Value.absent(),
    this.paidBy = const Value.absent(),
    this.title = const Value.absent(),
    this.amount = const Value.absent(),
    this.currency = const Value.absent(),
    this.category = const Value.absent(),
    this.splitType = const Value.absent(),
    this.receiptImagePath = const Value.absent(),
    this.notes = const Value.absent(),
    this.expenseDate = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.isDeleted = const Value.absent(),
    this.hlcTimestamp = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  ExpensesCompanion.insert({
    required String id,
    required String tripId,
    required String paidBy,
    required String title,
    required double amount,
    this.currency = const Value.absent(),
    required String category,
    required String splitType,
    this.receiptImagePath = const Value.absent(),
    this.notes = const Value.absent(),
    required int expenseDate,
    required int createdAt,
    required int updatedAt,
    this.isDeleted = const Value.absent(),
    required String hlcTimestamp,
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       tripId = Value(tripId),
       paidBy = Value(paidBy),
       title = Value(title),
       amount = Value(amount),
       category = Value(category),
       splitType = Value(splitType),
       expenseDate = Value(expenseDate),
       createdAt = Value(createdAt),
       updatedAt = Value(updatedAt),
       hlcTimestamp = Value(hlcTimestamp);
  static Insertable<Expense> custom({
    Expression<String>? id,
    Expression<String>? tripId,
    Expression<String>? paidBy,
    Expression<String>? title,
    Expression<double>? amount,
    Expression<String>? currency,
    Expression<String>? category,
    Expression<String>? splitType,
    Expression<String>? receiptImagePath,
    Expression<String>? notes,
    Expression<int>? expenseDate,
    Expression<int>? createdAt,
    Expression<int>? updatedAt,
    Expression<bool>? isDeleted,
    Expression<String>? hlcTimestamp,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (tripId != null) 'trip_id': tripId,
      if (paidBy != null) 'paid_by': paidBy,
      if (title != null) 'title': title,
      if (amount != null) 'amount': amount,
      if (currency != null) 'currency': currency,
      if (category != null) 'category': category,
      if (splitType != null) 'split_type': splitType,
      if (receiptImagePath != null) 'receipt_image_path': receiptImagePath,
      if (notes != null) 'notes': notes,
      if (expenseDate != null) 'expense_date': expenseDate,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (isDeleted != null) 'is_deleted': isDeleted,
      if (hlcTimestamp != null) 'hlc_timestamp': hlcTimestamp,
      if (rowid != null) 'rowid': rowid,
    });
  }

  ExpensesCompanion copyWith({
    Value<String>? id,
    Value<String>? tripId,
    Value<String>? paidBy,
    Value<String>? title,
    Value<double>? amount,
    Value<String>? currency,
    Value<String>? category,
    Value<String>? splitType,
    Value<String?>? receiptImagePath,
    Value<String?>? notes,
    Value<int>? expenseDate,
    Value<int>? createdAt,
    Value<int>? updatedAt,
    Value<bool>? isDeleted,
    Value<String>? hlcTimestamp,
    Value<int>? rowid,
  }) {
    return ExpensesCompanion(
      id: id ?? this.id,
      tripId: tripId ?? this.tripId,
      paidBy: paidBy ?? this.paidBy,
      title: title ?? this.title,
      amount: amount ?? this.amount,
      currency: currency ?? this.currency,
      category: category ?? this.category,
      splitType: splitType ?? this.splitType,
      receiptImagePath: receiptImagePath ?? this.receiptImagePath,
      notes: notes ?? this.notes,
      expenseDate: expenseDate ?? this.expenseDate,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      isDeleted: isDeleted ?? this.isDeleted,
      hlcTimestamp: hlcTimestamp ?? this.hlcTimestamp,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (tripId.present) {
      map['trip_id'] = Variable<String>(tripId.value);
    }
    if (paidBy.present) {
      map['paid_by'] = Variable<String>(paidBy.value);
    }
    if (title.present) {
      map['title'] = Variable<String>(title.value);
    }
    if (amount.present) {
      map['amount'] = Variable<double>(amount.value);
    }
    if (currency.present) {
      map['currency'] = Variable<String>(currency.value);
    }
    if (category.present) {
      map['category'] = Variable<String>(category.value);
    }
    if (splitType.present) {
      map['split_type'] = Variable<String>(splitType.value);
    }
    if (receiptImagePath.present) {
      map['receipt_image_path'] = Variable<String>(receiptImagePath.value);
    }
    if (notes.present) {
      map['notes'] = Variable<String>(notes.value);
    }
    if (expenseDate.present) {
      map['expense_date'] = Variable<int>(expenseDate.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<int>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<int>(updatedAt.value);
    }
    if (isDeleted.present) {
      map['is_deleted'] = Variable<bool>(isDeleted.value);
    }
    if (hlcTimestamp.present) {
      map['hlc_timestamp'] = Variable<String>(hlcTimestamp.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ExpensesCompanion(')
          ..write('id: $id, ')
          ..write('tripId: $tripId, ')
          ..write('paidBy: $paidBy, ')
          ..write('title: $title, ')
          ..write('amount: $amount, ')
          ..write('currency: $currency, ')
          ..write('category: $category, ')
          ..write('splitType: $splitType, ')
          ..write('receiptImagePath: $receiptImagePath, ')
          ..write('notes: $notes, ')
          ..write('expenseDate: $expenseDate, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('isDeleted: $isDeleted, ')
          ..write('hlcTimestamp: $hlcTimestamp, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $ExpenseSplitsTable extends ExpenseSplits
    with TableInfo<$ExpenseSplitsTable, ExpenseSplit> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ExpenseSplitsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _expenseIdMeta = const VerificationMeta(
    'expenseId',
  );
  @override
  late final GeneratedColumn<String> expenseId = GeneratedColumn<String>(
    'expense_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _userIdMeta = const VerificationMeta('userId');
  @override
  late final GeneratedColumn<String> userId = GeneratedColumn<String>(
    'user_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _amountMeta = const VerificationMeta('amount');
  @override
  late final GeneratedColumn<double> amount = GeneratedColumn<double>(
    'amount',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _percentageMeta = const VerificationMeta(
    'percentage',
  );
  @override
  late final GeneratedColumn<double> percentage = GeneratedColumn<double>(
    'percentage',
    aliasedName,
    true,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _sharesMeta = const VerificationMeta('shares');
  @override
  late final GeneratedColumn<int> shares = GeneratedColumn<int>(
    'shares',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _isSettledMeta = const VerificationMeta(
    'isSettled',
  );
  @override
  late final GeneratedColumn<bool> isSettled = GeneratedColumn<bool>(
    'is_settled',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_settled" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  static const VerificationMeta _hlcTimestampMeta = const VerificationMeta(
    'hlcTimestamp',
  );
  @override
  late final GeneratedColumn<String> hlcTimestamp = GeneratedColumn<String>(
    'hlc_timestamp',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    expenseId,
    userId,
    amount,
    percentage,
    shares,
    isSettled,
    hlcTimestamp,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'expense_splits';
  @override
  VerificationContext validateIntegrity(
    Insertable<ExpenseSplit> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('expense_id')) {
      context.handle(
        _expenseIdMeta,
        expenseId.isAcceptableOrUnknown(data['expense_id']!, _expenseIdMeta),
      );
    } else if (isInserting) {
      context.missing(_expenseIdMeta);
    }
    if (data.containsKey('user_id')) {
      context.handle(
        _userIdMeta,
        userId.isAcceptableOrUnknown(data['user_id']!, _userIdMeta),
      );
    } else if (isInserting) {
      context.missing(_userIdMeta);
    }
    if (data.containsKey('amount')) {
      context.handle(
        _amountMeta,
        amount.isAcceptableOrUnknown(data['amount']!, _amountMeta),
      );
    } else if (isInserting) {
      context.missing(_amountMeta);
    }
    if (data.containsKey('percentage')) {
      context.handle(
        _percentageMeta,
        percentage.isAcceptableOrUnknown(data['percentage']!, _percentageMeta),
      );
    }
    if (data.containsKey('shares')) {
      context.handle(
        _sharesMeta,
        shares.isAcceptableOrUnknown(data['shares']!, _sharesMeta),
      );
    }
    if (data.containsKey('is_settled')) {
      context.handle(
        _isSettledMeta,
        isSettled.isAcceptableOrUnknown(data['is_settled']!, _isSettledMeta),
      );
    }
    if (data.containsKey('hlc_timestamp')) {
      context.handle(
        _hlcTimestampMeta,
        hlcTimestamp.isAcceptableOrUnknown(
          data['hlc_timestamp']!,
          _hlcTimestampMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_hlcTimestampMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  ExpenseSplit map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return ExpenseSplit(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      expenseId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}expense_id'],
      )!,
      userId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}user_id'],
      )!,
      amount: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}amount'],
      )!,
      percentage: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}percentage'],
      ),
      shares: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}shares'],
      ),
      isSettled: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_settled'],
      )!,
      hlcTimestamp: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}hlc_timestamp'],
      )!,
    );
  }

  @override
  $ExpenseSplitsTable createAlias(String alias) {
    return $ExpenseSplitsTable(attachedDatabase, alias);
  }
}

class ExpenseSplit extends DataClass implements Insertable<ExpenseSplit> {
  final String id;
  final String expenseId;
  final String userId;
  final double amount;
  final double? percentage;
  final int? shares;
  final bool isSettled;
  final String hlcTimestamp;
  const ExpenseSplit({
    required this.id,
    required this.expenseId,
    required this.userId,
    required this.amount,
    this.percentage,
    this.shares,
    required this.isSettled,
    required this.hlcTimestamp,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['expense_id'] = Variable<String>(expenseId);
    map['user_id'] = Variable<String>(userId);
    map['amount'] = Variable<double>(amount);
    if (!nullToAbsent || percentage != null) {
      map['percentage'] = Variable<double>(percentage);
    }
    if (!nullToAbsent || shares != null) {
      map['shares'] = Variable<int>(shares);
    }
    map['is_settled'] = Variable<bool>(isSettled);
    map['hlc_timestamp'] = Variable<String>(hlcTimestamp);
    return map;
  }

  ExpenseSplitsCompanion toCompanion(bool nullToAbsent) {
    return ExpenseSplitsCompanion(
      id: Value(id),
      expenseId: Value(expenseId),
      userId: Value(userId),
      amount: Value(amount),
      percentage: percentage == null && nullToAbsent
          ? const Value.absent()
          : Value(percentage),
      shares: shares == null && nullToAbsent
          ? const Value.absent()
          : Value(shares),
      isSettled: Value(isSettled),
      hlcTimestamp: Value(hlcTimestamp),
    );
  }

  factory ExpenseSplit.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return ExpenseSplit(
      id: serializer.fromJson<String>(json['id']),
      expenseId: serializer.fromJson<String>(json['expenseId']),
      userId: serializer.fromJson<String>(json['userId']),
      amount: serializer.fromJson<double>(json['amount']),
      percentage: serializer.fromJson<double?>(json['percentage']),
      shares: serializer.fromJson<int?>(json['shares']),
      isSettled: serializer.fromJson<bool>(json['isSettled']),
      hlcTimestamp: serializer.fromJson<String>(json['hlcTimestamp']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'expenseId': serializer.toJson<String>(expenseId),
      'userId': serializer.toJson<String>(userId),
      'amount': serializer.toJson<double>(amount),
      'percentage': serializer.toJson<double?>(percentage),
      'shares': serializer.toJson<int?>(shares),
      'isSettled': serializer.toJson<bool>(isSettled),
      'hlcTimestamp': serializer.toJson<String>(hlcTimestamp),
    };
  }

  ExpenseSplit copyWith({
    String? id,
    String? expenseId,
    String? userId,
    double? amount,
    Value<double?> percentage = const Value.absent(),
    Value<int?> shares = const Value.absent(),
    bool? isSettled,
    String? hlcTimestamp,
  }) => ExpenseSplit(
    id: id ?? this.id,
    expenseId: expenseId ?? this.expenseId,
    userId: userId ?? this.userId,
    amount: amount ?? this.amount,
    percentage: percentage.present ? percentage.value : this.percentage,
    shares: shares.present ? shares.value : this.shares,
    isSettled: isSettled ?? this.isSettled,
    hlcTimestamp: hlcTimestamp ?? this.hlcTimestamp,
  );
  ExpenseSplit copyWithCompanion(ExpenseSplitsCompanion data) {
    return ExpenseSplit(
      id: data.id.present ? data.id.value : this.id,
      expenseId: data.expenseId.present ? data.expenseId.value : this.expenseId,
      userId: data.userId.present ? data.userId.value : this.userId,
      amount: data.amount.present ? data.amount.value : this.amount,
      percentage: data.percentage.present
          ? data.percentage.value
          : this.percentage,
      shares: data.shares.present ? data.shares.value : this.shares,
      isSettled: data.isSettled.present ? data.isSettled.value : this.isSettled,
      hlcTimestamp: data.hlcTimestamp.present
          ? data.hlcTimestamp.value
          : this.hlcTimestamp,
    );
  }

  @override
  String toString() {
    return (StringBuffer('ExpenseSplit(')
          ..write('id: $id, ')
          ..write('expenseId: $expenseId, ')
          ..write('userId: $userId, ')
          ..write('amount: $amount, ')
          ..write('percentage: $percentage, ')
          ..write('shares: $shares, ')
          ..write('isSettled: $isSettled, ')
          ..write('hlcTimestamp: $hlcTimestamp')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    expenseId,
    userId,
    amount,
    percentage,
    shares,
    isSettled,
    hlcTimestamp,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ExpenseSplit &&
          other.id == this.id &&
          other.expenseId == this.expenseId &&
          other.userId == this.userId &&
          other.amount == this.amount &&
          other.percentage == this.percentage &&
          other.shares == this.shares &&
          other.isSettled == this.isSettled &&
          other.hlcTimestamp == this.hlcTimestamp);
}

class ExpenseSplitsCompanion extends UpdateCompanion<ExpenseSplit> {
  final Value<String> id;
  final Value<String> expenseId;
  final Value<String> userId;
  final Value<double> amount;
  final Value<double?> percentage;
  final Value<int?> shares;
  final Value<bool> isSettled;
  final Value<String> hlcTimestamp;
  final Value<int> rowid;
  const ExpenseSplitsCompanion({
    this.id = const Value.absent(),
    this.expenseId = const Value.absent(),
    this.userId = const Value.absent(),
    this.amount = const Value.absent(),
    this.percentage = const Value.absent(),
    this.shares = const Value.absent(),
    this.isSettled = const Value.absent(),
    this.hlcTimestamp = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  ExpenseSplitsCompanion.insert({
    required String id,
    required String expenseId,
    required String userId,
    required double amount,
    this.percentage = const Value.absent(),
    this.shares = const Value.absent(),
    this.isSettled = const Value.absent(),
    required String hlcTimestamp,
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       expenseId = Value(expenseId),
       userId = Value(userId),
       amount = Value(amount),
       hlcTimestamp = Value(hlcTimestamp);
  static Insertable<ExpenseSplit> custom({
    Expression<String>? id,
    Expression<String>? expenseId,
    Expression<String>? userId,
    Expression<double>? amount,
    Expression<double>? percentage,
    Expression<int>? shares,
    Expression<bool>? isSettled,
    Expression<String>? hlcTimestamp,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (expenseId != null) 'expense_id': expenseId,
      if (userId != null) 'user_id': userId,
      if (amount != null) 'amount': amount,
      if (percentage != null) 'percentage': percentage,
      if (shares != null) 'shares': shares,
      if (isSettled != null) 'is_settled': isSettled,
      if (hlcTimestamp != null) 'hlc_timestamp': hlcTimestamp,
      if (rowid != null) 'rowid': rowid,
    });
  }

  ExpenseSplitsCompanion copyWith({
    Value<String>? id,
    Value<String>? expenseId,
    Value<String>? userId,
    Value<double>? amount,
    Value<double?>? percentage,
    Value<int?>? shares,
    Value<bool>? isSettled,
    Value<String>? hlcTimestamp,
    Value<int>? rowid,
  }) {
    return ExpenseSplitsCompanion(
      id: id ?? this.id,
      expenseId: expenseId ?? this.expenseId,
      userId: userId ?? this.userId,
      amount: amount ?? this.amount,
      percentage: percentage ?? this.percentage,
      shares: shares ?? this.shares,
      isSettled: isSettled ?? this.isSettled,
      hlcTimestamp: hlcTimestamp ?? this.hlcTimestamp,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (expenseId.present) {
      map['expense_id'] = Variable<String>(expenseId.value);
    }
    if (userId.present) {
      map['user_id'] = Variable<String>(userId.value);
    }
    if (amount.present) {
      map['amount'] = Variable<double>(amount.value);
    }
    if (percentage.present) {
      map['percentage'] = Variable<double>(percentage.value);
    }
    if (shares.present) {
      map['shares'] = Variable<int>(shares.value);
    }
    if (isSettled.present) {
      map['is_settled'] = Variable<bool>(isSettled.value);
    }
    if (hlcTimestamp.present) {
      map['hlc_timestamp'] = Variable<String>(hlcTimestamp.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ExpenseSplitsCompanion(')
          ..write('id: $id, ')
          ..write('expenseId: $expenseId, ')
          ..write('userId: $userId, ')
          ..write('amount: $amount, ')
          ..write('percentage: $percentage, ')
          ..write('shares: $shares, ')
          ..write('isSettled: $isSettled, ')
          ..write('hlcTimestamp: $hlcTimestamp, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $SettlementsTable extends Settlements
    with TableInfo<$SettlementsTable, Settlement> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $SettlementsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _tripIdMeta = const VerificationMeta('tripId');
  @override
  late final GeneratedColumn<String> tripId = GeneratedColumn<String>(
    'trip_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _payerIdMeta = const VerificationMeta(
    'payerId',
  );
  @override
  late final GeneratedColumn<String> payerId = GeneratedColumn<String>(
    'payer_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _payeeIdMeta = const VerificationMeta(
    'payeeId',
  );
  @override
  late final GeneratedColumn<String> payeeId = GeneratedColumn<String>(
    'payee_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _amountMeta = const VerificationMeta('amount');
  @override
  late final GeneratedColumn<double> amount = GeneratedColumn<double>(
    'amount',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _currencyMeta = const VerificationMeta(
    'currency',
  );
  @override
  late final GeneratedColumn<String> currency = GeneratedColumn<String>(
    'currency',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('BDT'),
  );
  static const VerificationMeta _settledAtMeta = const VerificationMeta(
    'settledAt',
  );
  @override
  late final GeneratedColumn<int> settledAt = GeneratedColumn<int>(
    'settled_at',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _notesMeta = const VerificationMeta('notes');
  @override
  late final GeneratedColumn<String> notes = GeneratedColumn<String>(
    'notes',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _isDeletedMeta = const VerificationMeta(
    'isDeleted',
  );
  @override
  late final GeneratedColumn<bool> isDeleted = GeneratedColumn<bool>(
    'is_deleted',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_deleted" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  static const VerificationMeta _hlcTimestampMeta = const VerificationMeta(
    'hlcTimestamp',
  );
  @override
  late final GeneratedColumn<String> hlcTimestamp = GeneratedColumn<String>(
    'hlc_timestamp',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
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
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'settlements';
  @override
  VerificationContext validateIntegrity(
    Insertable<Settlement> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('trip_id')) {
      context.handle(
        _tripIdMeta,
        tripId.isAcceptableOrUnknown(data['trip_id']!, _tripIdMeta),
      );
    } else if (isInserting) {
      context.missing(_tripIdMeta);
    }
    if (data.containsKey('payer_id')) {
      context.handle(
        _payerIdMeta,
        payerId.isAcceptableOrUnknown(data['payer_id']!, _payerIdMeta),
      );
    } else if (isInserting) {
      context.missing(_payerIdMeta);
    }
    if (data.containsKey('payee_id')) {
      context.handle(
        _payeeIdMeta,
        payeeId.isAcceptableOrUnknown(data['payee_id']!, _payeeIdMeta),
      );
    } else if (isInserting) {
      context.missing(_payeeIdMeta);
    }
    if (data.containsKey('amount')) {
      context.handle(
        _amountMeta,
        amount.isAcceptableOrUnknown(data['amount']!, _amountMeta),
      );
    } else if (isInserting) {
      context.missing(_amountMeta);
    }
    if (data.containsKey('currency')) {
      context.handle(
        _currencyMeta,
        currency.isAcceptableOrUnknown(data['currency']!, _currencyMeta),
      );
    }
    if (data.containsKey('settled_at')) {
      context.handle(
        _settledAtMeta,
        settledAt.isAcceptableOrUnknown(data['settled_at']!, _settledAtMeta),
      );
    } else if (isInserting) {
      context.missing(_settledAtMeta);
    }
    if (data.containsKey('notes')) {
      context.handle(
        _notesMeta,
        notes.isAcceptableOrUnknown(data['notes']!, _notesMeta),
      );
    }
    if (data.containsKey('is_deleted')) {
      context.handle(
        _isDeletedMeta,
        isDeleted.isAcceptableOrUnknown(data['is_deleted']!, _isDeletedMeta),
      );
    }
    if (data.containsKey('hlc_timestamp')) {
      context.handle(
        _hlcTimestampMeta,
        hlcTimestamp.isAcceptableOrUnknown(
          data['hlc_timestamp']!,
          _hlcTimestampMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_hlcTimestampMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Settlement map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Settlement(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      tripId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}trip_id'],
      )!,
      payerId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}payer_id'],
      )!,
      payeeId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}payee_id'],
      )!,
      amount: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}amount'],
      )!,
      currency: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}currency'],
      )!,
      settledAt: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}settled_at'],
      )!,
      notes: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}notes'],
      ),
      isDeleted: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_deleted'],
      )!,
      hlcTimestamp: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}hlc_timestamp'],
      )!,
    );
  }

  @override
  $SettlementsTable createAlias(String alias) {
    return $SettlementsTable(attachedDatabase, alias);
  }
}

class Settlement extends DataClass implements Insertable<Settlement> {
  final String id;
  final String tripId;
  final String payerId;
  final String payeeId;
  final double amount;
  final String currency;
  final int settledAt;
  final String? notes;
  final bool isDeleted;
  final String hlcTimestamp;
  const Settlement({
    required this.id,
    required this.tripId,
    required this.payerId,
    required this.payeeId,
    required this.amount,
    required this.currency,
    required this.settledAt,
    this.notes,
    required this.isDeleted,
    required this.hlcTimestamp,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['trip_id'] = Variable<String>(tripId);
    map['payer_id'] = Variable<String>(payerId);
    map['payee_id'] = Variable<String>(payeeId);
    map['amount'] = Variable<double>(amount);
    map['currency'] = Variable<String>(currency);
    map['settled_at'] = Variable<int>(settledAt);
    if (!nullToAbsent || notes != null) {
      map['notes'] = Variable<String>(notes);
    }
    map['is_deleted'] = Variable<bool>(isDeleted);
    map['hlc_timestamp'] = Variable<String>(hlcTimestamp);
    return map;
  }

  SettlementsCompanion toCompanion(bool nullToAbsent) {
    return SettlementsCompanion(
      id: Value(id),
      tripId: Value(tripId),
      payerId: Value(payerId),
      payeeId: Value(payeeId),
      amount: Value(amount),
      currency: Value(currency),
      settledAt: Value(settledAt),
      notes: notes == null && nullToAbsent
          ? const Value.absent()
          : Value(notes),
      isDeleted: Value(isDeleted),
      hlcTimestamp: Value(hlcTimestamp),
    );
  }

  factory Settlement.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Settlement(
      id: serializer.fromJson<String>(json['id']),
      tripId: serializer.fromJson<String>(json['tripId']),
      payerId: serializer.fromJson<String>(json['payerId']),
      payeeId: serializer.fromJson<String>(json['payeeId']),
      amount: serializer.fromJson<double>(json['amount']),
      currency: serializer.fromJson<String>(json['currency']),
      settledAt: serializer.fromJson<int>(json['settledAt']),
      notes: serializer.fromJson<String?>(json['notes']),
      isDeleted: serializer.fromJson<bool>(json['isDeleted']),
      hlcTimestamp: serializer.fromJson<String>(json['hlcTimestamp']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'tripId': serializer.toJson<String>(tripId),
      'payerId': serializer.toJson<String>(payerId),
      'payeeId': serializer.toJson<String>(payeeId),
      'amount': serializer.toJson<double>(amount),
      'currency': serializer.toJson<String>(currency),
      'settledAt': serializer.toJson<int>(settledAt),
      'notes': serializer.toJson<String?>(notes),
      'isDeleted': serializer.toJson<bool>(isDeleted),
      'hlcTimestamp': serializer.toJson<String>(hlcTimestamp),
    };
  }

  Settlement copyWith({
    String? id,
    String? tripId,
    String? payerId,
    String? payeeId,
    double? amount,
    String? currency,
    int? settledAt,
    Value<String?> notes = const Value.absent(),
    bool? isDeleted,
    String? hlcTimestamp,
  }) => Settlement(
    id: id ?? this.id,
    tripId: tripId ?? this.tripId,
    payerId: payerId ?? this.payerId,
    payeeId: payeeId ?? this.payeeId,
    amount: amount ?? this.amount,
    currency: currency ?? this.currency,
    settledAt: settledAt ?? this.settledAt,
    notes: notes.present ? notes.value : this.notes,
    isDeleted: isDeleted ?? this.isDeleted,
    hlcTimestamp: hlcTimestamp ?? this.hlcTimestamp,
  );
  Settlement copyWithCompanion(SettlementsCompanion data) {
    return Settlement(
      id: data.id.present ? data.id.value : this.id,
      tripId: data.tripId.present ? data.tripId.value : this.tripId,
      payerId: data.payerId.present ? data.payerId.value : this.payerId,
      payeeId: data.payeeId.present ? data.payeeId.value : this.payeeId,
      amount: data.amount.present ? data.amount.value : this.amount,
      currency: data.currency.present ? data.currency.value : this.currency,
      settledAt: data.settledAt.present ? data.settledAt.value : this.settledAt,
      notes: data.notes.present ? data.notes.value : this.notes,
      isDeleted: data.isDeleted.present ? data.isDeleted.value : this.isDeleted,
      hlcTimestamp: data.hlcTimestamp.present
          ? data.hlcTimestamp.value
          : this.hlcTimestamp,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Settlement(')
          ..write('id: $id, ')
          ..write('tripId: $tripId, ')
          ..write('payerId: $payerId, ')
          ..write('payeeId: $payeeId, ')
          ..write('amount: $amount, ')
          ..write('currency: $currency, ')
          ..write('settledAt: $settledAt, ')
          ..write('notes: $notes, ')
          ..write('isDeleted: $isDeleted, ')
          ..write('hlcTimestamp: $hlcTimestamp')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
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
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Settlement &&
          other.id == this.id &&
          other.tripId == this.tripId &&
          other.payerId == this.payerId &&
          other.payeeId == this.payeeId &&
          other.amount == this.amount &&
          other.currency == this.currency &&
          other.settledAt == this.settledAt &&
          other.notes == this.notes &&
          other.isDeleted == this.isDeleted &&
          other.hlcTimestamp == this.hlcTimestamp);
}

class SettlementsCompanion extends UpdateCompanion<Settlement> {
  final Value<String> id;
  final Value<String> tripId;
  final Value<String> payerId;
  final Value<String> payeeId;
  final Value<double> amount;
  final Value<String> currency;
  final Value<int> settledAt;
  final Value<String?> notes;
  final Value<bool> isDeleted;
  final Value<String> hlcTimestamp;
  final Value<int> rowid;
  const SettlementsCompanion({
    this.id = const Value.absent(),
    this.tripId = const Value.absent(),
    this.payerId = const Value.absent(),
    this.payeeId = const Value.absent(),
    this.amount = const Value.absent(),
    this.currency = const Value.absent(),
    this.settledAt = const Value.absent(),
    this.notes = const Value.absent(),
    this.isDeleted = const Value.absent(),
    this.hlcTimestamp = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  SettlementsCompanion.insert({
    required String id,
    required String tripId,
    required String payerId,
    required String payeeId,
    required double amount,
    this.currency = const Value.absent(),
    required int settledAt,
    this.notes = const Value.absent(),
    this.isDeleted = const Value.absent(),
    required String hlcTimestamp,
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       tripId = Value(tripId),
       payerId = Value(payerId),
       payeeId = Value(payeeId),
       amount = Value(amount),
       settledAt = Value(settledAt),
       hlcTimestamp = Value(hlcTimestamp);
  static Insertable<Settlement> custom({
    Expression<String>? id,
    Expression<String>? tripId,
    Expression<String>? payerId,
    Expression<String>? payeeId,
    Expression<double>? amount,
    Expression<String>? currency,
    Expression<int>? settledAt,
    Expression<String>? notes,
    Expression<bool>? isDeleted,
    Expression<String>? hlcTimestamp,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (tripId != null) 'trip_id': tripId,
      if (payerId != null) 'payer_id': payerId,
      if (payeeId != null) 'payee_id': payeeId,
      if (amount != null) 'amount': amount,
      if (currency != null) 'currency': currency,
      if (settledAt != null) 'settled_at': settledAt,
      if (notes != null) 'notes': notes,
      if (isDeleted != null) 'is_deleted': isDeleted,
      if (hlcTimestamp != null) 'hlc_timestamp': hlcTimestamp,
      if (rowid != null) 'rowid': rowid,
    });
  }

  SettlementsCompanion copyWith({
    Value<String>? id,
    Value<String>? tripId,
    Value<String>? payerId,
    Value<String>? payeeId,
    Value<double>? amount,
    Value<String>? currency,
    Value<int>? settledAt,
    Value<String?>? notes,
    Value<bool>? isDeleted,
    Value<String>? hlcTimestamp,
    Value<int>? rowid,
  }) {
    return SettlementsCompanion(
      id: id ?? this.id,
      tripId: tripId ?? this.tripId,
      payerId: payerId ?? this.payerId,
      payeeId: payeeId ?? this.payeeId,
      amount: amount ?? this.amount,
      currency: currency ?? this.currency,
      settledAt: settledAt ?? this.settledAt,
      notes: notes ?? this.notes,
      isDeleted: isDeleted ?? this.isDeleted,
      hlcTimestamp: hlcTimestamp ?? this.hlcTimestamp,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (tripId.present) {
      map['trip_id'] = Variable<String>(tripId.value);
    }
    if (payerId.present) {
      map['payer_id'] = Variable<String>(payerId.value);
    }
    if (payeeId.present) {
      map['payee_id'] = Variable<String>(payeeId.value);
    }
    if (amount.present) {
      map['amount'] = Variable<double>(amount.value);
    }
    if (currency.present) {
      map['currency'] = Variable<String>(currency.value);
    }
    if (settledAt.present) {
      map['settled_at'] = Variable<int>(settledAt.value);
    }
    if (notes.present) {
      map['notes'] = Variable<String>(notes.value);
    }
    if (isDeleted.present) {
      map['is_deleted'] = Variable<bool>(isDeleted.value);
    }
    if (hlcTimestamp.present) {
      map['hlc_timestamp'] = Variable<String>(hlcTimestamp.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('SettlementsCompanion(')
          ..write('id: $id, ')
          ..write('tripId: $tripId, ')
          ..write('payerId: $payerId, ')
          ..write('payeeId: $payeeId, ')
          ..write('amount: $amount, ')
          ..write('currency: $currency, ')
          ..write('settledAt: $settledAt, ')
          ..write('notes: $notes, ')
          ..write('isDeleted: $isDeleted, ')
          ..write('hlcTimestamp: $hlcTimestamp, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $MessagesTable extends Messages with TableInfo<$MessagesTable, Message> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $MessagesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _tripIdMeta = const VerificationMeta('tripId');
  @override
  late final GeneratedColumn<String> tripId = GeneratedColumn<String>(
    'trip_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _senderIdMeta = const VerificationMeta(
    'senderId',
  );
  @override
  late final GeneratedColumn<String> senderId = GeneratedColumn<String>(
    'sender_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _contentMeta = const VerificationMeta(
    'content',
  );
  @override
  late final GeneratedColumn<String> content = GeneratedColumn<String>(
    'content',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _messageTypeMeta = const VerificationMeta(
    'messageType',
  );
  @override
  late final GeneratedColumn<String> messageType = GeneratedColumn<String>(
    'message_type',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _imagePathMeta = const VerificationMeta(
    'imagePath',
  );
  @override
  late final GeneratedColumn<String> imagePath = GeneratedColumn<String>(
    'image_path',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _imageThumbnailPathMeta =
      const VerificationMeta('imageThumbnailPath');
  @override
  late final GeneratedColumn<String> imageThumbnailPath =
      GeneratedColumn<String>(
        'image_thumbnail_path',
        aliasedName,
        true,
        type: DriftSqlType.string,
        requiredDuringInsert: false,
      );
  static const VerificationMeta _replyToIdMeta = const VerificationMeta(
    'replyToId',
  );
  @override
  late final GeneratedColumn<String> replyToId = GeneratedColumn<String>(
    'reply_to_id',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _sentAtMeta = const VerificationMeta('sentAt');
  @override
  late final GeneratedColumn<int> sentAt = GeneratedColumn<int>(
    'sent_at',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _isDeletedMeta = const VerificationMeta(
    'isDeleted',
  );
  @override
  late final GeneratedColumn<bool> isDeleted = GeneratedColumn<bool>(
    'is_deleted',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_deleted" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  static const VerificationMeta _hlcTimestampMeta = const VerificationMeta(
    'hlcTimestamp',
  );
  @override
  late final GeneratedColumn<String> hlcTimestamp = GeneratedColumn<String>(
    'hlc_timestamp',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
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
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'messages';
  @override
  VerificationContext validateIntegrity(
    Insertable<Message> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('trip_id')) {
      context.handle(
        _tripIdMeta,
        tripId.isAcceptableOrUnknown(data['trip_id']!, _tripIdMeta),
      );
    } else if (isInserting) {
      context.missing(_tripIdMeta);
    }
    if (data.containsKey('sender_id')) {
      context.handle(
        _senderIdMeta,
        senderId.isAcceptableOrUnknown(data['sender_id']!, _senderIdMeta),
      );
    } else if (isInserting) {
      context.missing(_senderIdMeta);
    }
    if (data.containsKey('content')) {
      context.handle(
        _contentMeta,
        content.isAcceptableOrUnknown(data['content']!, _contentMeta),
      );
    }
    if (data.containsKey('message_type')) {
      context.handle(
        _messageTypeMeta,
        messageType.isAcceptableOrUnknown(
          data['message_type']!,
          _messageTypeMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_messageTypeMeta);
    }
    if (data.containsKey('image_path')) {
      context.handle(
        _imagePathMeta,
        imagePath.isAcceptableOrUnknown(data['image_path']!, _imagePathMeta),
      );
    }
    if (data.containsKey('image_thumbnail_path')) {
      context.handle(
        _imageThumbnailPathMeta,
        imageThumbnailPath.isAcceptableOrUnknown(
          data['image_thumbnail_path']!,
          _imageThumbnailPathMeta,
        ),
      );
    }
    if (data.containsKey('reply_to_id')) {
      context.handle(
        _replyToIdMeta,
        replyToId.isAcceptableOrUnknown(data['reply_to_id']!, _replyToIdMeta),
      );
    }
    if (data.containsKey('sent_at')) {
      context.handle(
        _sentAtMeta,
        sentAt.isAcceptableOrUnknown(data['sent_at']!, _sentAtMeta),
      );
    } else if (isInserting) {
      context.missing(_sentAtMeta);
    }
    if (data.containsKey('is_deleted')) {
      context.handle(
        _isDeletedMeta,
        isDeleted.isAcceptableOrUnknown(data['is_deleted']!, _isDeletedMeta),
      );
    }
    if (data.containsKey('hlc_timestamp')) {
      context.handle(
        _hlcTimestampMeta,
        hlcTimestamp.isAcceptableOrUnknown(
          data['hlc_timestamp']!,
          _hlcTimestampMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_hlcTimestampMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Message map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Message(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      tripId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}trip_id'],
      )!,
      senderId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}sender_id'],
      )!,
      content: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}content'],
      ),
      messageType: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}message_type'],
      )!,
      imagePath: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}image_path'],
      ),
      imageThumbnailPath: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}image_thumbnail_path'],
      ),
      replyToId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}reply_to_id'],
      ),
      sentAt: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}sent_at'],
      )!,
      isDeleted: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_deleted'],
      )!,
      hlcTimestamp: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}hlc_timestamp'],
      )!,
    );
  }

  @override
  $MessagesTable createAlias(String alias) {
    return $MessagesTable(attachedDatabase, alias);
  }
}

class Message extends DataClass implements Insertable<Message> {
  final String id;
  final String tripId;
  final String senderId;
  final String? content;
  final String messageType;
  final String? imagePath;
  final String? imageThumbnailPath;
  final String? replyToId;
  final int sentAt;
  final bool isDeleted;
  final String hlcTimestamp;
  const Message({
    required this.id,
    required this.tripId,
    required this.senderId,
    this.content,
    required this.messageType,
    this.imagePath,
    this.imageThumbnailPath,
    this.replyToId,
    required this.sentAt,
    required this.isDeleted,
    required this.hlcTimestamp,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['trip_id'] = Variable<String>(tripId);
    map['sender_id'] = Variable<String>(senderId);
    if (!nullToAbsent || content != null) {
      map['content'] = Variable<String>(content);
    }
    map['message_type'] = Variable<String>(messageType);
    if (!nullToAbsent || imagePath != null) {
      map['image_path'] = Variable<String>(imagePath);
    }
    if (!nullToAbsent || imageThumbnailPath != null) {
      map['image_thumbnail_path'] = Variable<String>(imageThumbnailPath);
    }
    if (!nullToAbsent || replyToId != null) {
      map['reply_to_id'] = Variable<String>(replyToId);
    }
    map['sent_at'] = Variable<int>(sentAt);
    map['is_deleted'] = Variable<bool>(isDeleted);
    map['hlc_timestamp'] = Variable<String>(hlcTimestamp);
    return map;
  }

  MessagesCompanion toCompanion(bool nullToAbsent) {
    return MessagesCompanion(
      id: Value(id),
      tripId: Value(tripId),
      senderId: Value(senderId),
      content: content == null && nullToAbsent
          ? const Value.absent()
          : Value(content),
      messageType: Value(messageType),
      imagePath: imagePath == null && nullToAbsent
          ? const Value.absent()
          : Value(imagePath),
      imageThumbnailPath: imageThumbnailPath == null && nullToAbsent
          ? const Value.absent()
          : Value(imageThumbnailPath),
      replyToId: replyToId == null && nullToAbsent
          ? const Value.absent()
          : Value(replyToId),
      sentAt: Value(sentAt),
      isDeleted: Value(isDeleted),
      hlcTimestamp: Value(hlcTimestamp),
    );
  }

  factory Message.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Message(
      id: serializer.fromJson<String>(json['id']),
      tripId: serializer.fromJson<String>(json['tripId']),
      senderId: serializer.fromJson<String>(json['senderId']),
      content: serializer.fromJson<String?>(json['content']),
      messageType: serializer.fromJson<String>(json['messageType']),
      imagePath: serializer.fromJson<String?>(json['imagePath']),
      imageThumbnailPath: serializer.fromJson<String?>(
        json['imageThumbnailPath'],
      ),
      replyToId: serializer.fromJson<String?>(json['replyToId']),
      sentAt: serializer.fromJson<int>(json['sentAt']),
      isDeleted: serializer.fromJson<bool>(json['isDeleted']),
      hlcTimestamp: serializer.fromJson<String>(json['hlcTimestamp']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'tripId': serializer.toJson<String>(tripId),
      'senderId': serializer.toJson<String>(senderId),
      'content': serializer.toJson<String?>(content),
      'messageType': serializer.toJson<String>(messageType),
      'imagePath': serializer.toJson<String?>(imagePath),
      'imageThumbnailPath': serializer.toJson<String?>(imageThumbnailPath),
      'replyToId': serializer.toJson<String?>(replyToId),
      'sentAt': serializer.toJson<int>(sentAt),
      'isDeleted': serializer.toJson<bool>(isDeleted),
      'hlcTimestamp': serializer.toJson<String>(hlcTimestamp),
    };
  }

  Message copyWith({
    String? id,
    String? tripId,
    String? senderId,
    Value<String?> content = const Value.absent(),
    String? messageType,
    Value<String?> imagePath = const Value.absent(),
    Value<String?> imageThumbnailPath = const Value.absent(),
    Value<String?> replyToId = const Value.absent(),
    int? sentAt,
    bool? isDeleted,
    String? hlcTimestamp,
  }) => Message(
    id: id ?? this.id,
    tripId: tripId ?? this.tripId,
    senderId: senderId ?? this.senderId,
    content: content.present ? content.value : this.content,
    messageType: messageType ?? this.messageType,
    imagePath: imagePath.present ? imagePath.value : this.imagePath,
    imageThumbnailPath: imageThumbnailPath.present
        ? imageThumbnailPath.value
        : this.imageThumbnailPath,
    replyToId: replyToId.present ? replyToId.value : this.replyToId,
    sentAt: sentAt ?? this.sentAt,
    isDeleted: isDeleted ?? this.isDeleted,
    hlcTimestamp: hlcTimestamp ?? this.hlcTimestamp,
  );
  Message copyWithCompanion(MessagesCompanion data) {
    return Message(
      id: data.id.present ? data.id.value : this.id,
      tripId: data.tripId.present ? data.tripId.value : this.tripId,
      senderId: data.senderId.present ? data.senderId.value : this.senderId,
      content: data.content.present ? data.content.value : this.content,
      messageType: data.messageType.present
          ? data.messageType.value
          : this.messageType,
      imagePath: data.imagePath.present ? data.imagePath.value : this.imagePath,
      imageThumbnailPath: data.imageThumbnailPath.present
          ? data.imageThumbnailPath.value
          : this.imageThumbnailPath,
      replyToId: data.replyToId.present ? data.replyToId.value : this.replyToId,
      sentAt: data.sentAt.present ? data.sentAt.value : this.sentAt,
      isDeleted: data.isDeleted.present ? data.isDeleted.value : this.isDeleted,
      hlcTimestamp: data.hlcTimestamp.present
          ? data.hlcTimestamp.value
          : this.hlcTimestamp,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Message(')
          ..write('id: $id, ')
          ..write('tripId: $tripId, ')
          ..write('senderId: $senderId, ')
          ..write('content: $content, ')
          ..write('messageType: $messageType, ')
          ..write('imagePath: $imagePath, ')
          ..write('imageThumbnailPath: $imageThumbnailPath, ')
          ..write('replyToId: $replyToId, ')
          ..write('sentAt: $sentAt, ')
          ..write('isDeleted: $isDeleted, ')
          ..write('hlcTimestamp: $hlcTimestamp')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
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
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Message &&
          other.id == this.id &&
          other.tripId == this.tripId &&
          other.senderId == this.senderId &&
          other.content == this.content &&
          other.messageType == this.messageType &&
          other.imagePath == this.imagePath &&
          other.imageThumbnailPath == this.imageThumbnailPath &&
          other.replyToId == this.replyToId &&
          other.sentAt == this.sentAt &&
          other.isDeleted == this.isDeleted &&
          other.hlcTimestamp == this.hlcTimestamp);
}

class MessagesCompanion extends UpdateCompanion<Message> {
  final Value<String> id;
  final Value<String> tripId;
  final Value<String> senderId;
  final Value<String?> content;
  final Value<String> messageType;
  final Value<String?> imagePath;
  final Value<String?> imageThumbnailPath;
  final Value<String?> replyToId;
  final Value<int> sentAt;
  final Value<bool> isDeleted;
  final Value<String> hlcTimestamp;
  final Value<int> rowid;
  const MessagesCompanion({
    this.id = const Value.absent(),
    this.tripId = const Value.absent(),
    this.senderId = const Value.absent(),
    this.content = const Value.absent(),
    this.messageType = const Value.absent(),
    this.imagePath = const Value.absent(),
    this.imageThumbnailPath = const Value.absent(),
    this.replyToId = const Value.absent(),
    this.sentAt = const Value.absent(),
    this.isDeleted = const Value.absent(),
    this.hlcTimestamp = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  MessagesCompanion.insert({
    required String id,
    required String tripId,
    required String senderId,
    this.content = const Value.absent(),
    required String messageType,
    this.imagePath = const Value.absent(),
    this.imageThumbnailPath = const Value.absent(),
    this.replyToId = const Value.absent(),
    required int sentAt,
    this.isDeleted = const Value.absent(),
    required String hlcTimestamp,
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       tripId = Value(tripId),
       senderId = Value(senderId),
       messageType = Value(messageType),
       sentAt = Value(sentAt),
       hlcTimestamp = Value(hlcTimestamp);
  static Insertable<Message> custom({
    Expression<String>? id,
    Expression<String>? tripId,
    Expression<String>? senderId,
    Expression<String>? content,
    Expression<String>? messageType,
    Expression<String>? imagePath,
    Expression<String>? imageThumbnailPath,
    Expression<String>? replyToId,
    Expression<int>? sentAt,
    Expression<bool>? isDeleted,
    Expression<String>? hlcTimestamp,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (tripId != null) 'trip_id': tripId,
      if (senderId != null) 'sender_id': senderId,
      if (content != null) 'content': content,
      if (messageType != null) 'message_type': messageType,
      if (imagePath != null) 'image_path': imagePath,
      if (imageThumbnailPath != null)
        'image_thumbnail_path': imageThumbnailPath,
      if (replyToId != null) 'reply_to_id': replyToId,
      if (sentAt != null) 'sent_at': sentAt,
      if (isDeleted != null) 'is_deleted': isDeleted,
      if (hlcTimestamp != null) 'hlc_timestamp': hlcTimestamp,
      if (rowid != null) 'rowid': rowid,
    });
  }

  MessagesCompanion copyWith({
    Value<String>? id,
    Value<String>? tripId,
    Value<String>? senderId,
    Value<String?>? content,
    Value<String>? messageType,
    Value<String?>? imagePath,
    Value<String?>? imageThumbnailPath,
    Value<String?>? replyToId,
    Value<int>? sentAt,
    Value<bool>? isDeleted,
    Value<String>? hlcTimestamp,
    Value<int>? rowid,
  }) {
    return MessagesCompanion(
      id: id ?? this.id,
      tripId: tripId ?? this.tripId,
      senderId: senderId ?? this.senderId,
      content: content ?? this.content,
      messageType: messageType ?? this.messageType,
      imagePath: imagePath ?? this.imagePath,
      imageThumbnailPath: imageThumbnailPath ?? this.imageThumbnailPath,
      replyToId: replyToId ?? this.replyToId,
      sentAt: sentAt ?? this.sentAt,
      isDeleted: isDeleted ?? this.isDeleted,
      hlcTimestamp: hlcTimestamp ?? this.hlcTimestamp,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (tripId.present) {
      map['trip_id'] = Variable<String>(tripId.value);
    }
    if (senderId.present) {
      map['sender_id'] = Variable<String>(senderId.value);
    }
    if (content.present) {
      map['content'] = Variable<String>(content.value);
    }
    if (messageType.present) {
      map['message_type'] = Variable<String>(messageType.value);
    }
    if (imagePath.present) {
      map['image_path'] = Variable<String>(imagePath.value);
    }
    if (imageThumbnailPath.present) {
      map['image_thumbnail_path'] = Variable<String>(imageThumbnailPath.value);
    }
    if (replyToId.present) {
      map['reply_to_id'] = Variable<String>(replyToId.value);
    }
    if (sentAt.present) {
      map['sent_at'] = Variable<int>(sentAt.value);
    }
    if (isDeleted.present) {
      map['is_deleted'] = Variable<bool>(isDeleted.value);
    }
    if (hlcTimestamp.present) {
      map['hlc_timestamp'] = Variable<String>(hlcTimestamp.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('MessagesCompanion(')
          ..write('id: $id, ')
          ..write('tripId: $tripId, ')
          ..write('senderId: $senderId, ')
          ..write('content: $content, ')
          ..write('messageType: $messageType, ')
          ..write('imagePath: $imagePath, ')
          ..write('imageThumbnailPath: $imageThumbnailPath, ')
          ..write('replyToId: $replyToId, ')
          ..write('sentAt: $sentAt, ')
          ..write('isDeleted: $isDeleted, ')
          ..write('hlcTimestamp: $hlcTimestamp, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $BudgetPoolsTable extends BudgetPools
    with TableInfo<$BudgetPoolsTable, BudgetPool> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $BudgetPoolsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _tripIdMeta = const VerificationMeta('tripId');
  @override
  late final GeneratedColumn<String> tripId = GeneratedColumn<String>(
    'trip_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
    'name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _targetAmountMeta = const VerificationMeta(
    'targetAmount',
  );
  @override
  late final GeneratedColumn<double> targetAmount = GeneratedColumn<double>(
    'target_amount',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _currencyMeta = const VerificationMeta(
    'currency',
  );
  @override
  late final GeneratedColumn<String> currency = GeneratedColumn<String>(
    'currency',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('BDT'),
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<int> createdAt = GeneratedColumn<int>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _hlcTimestampMeta = const VerificationMeta(
    'hlcTimestamp',
  );
  @override
  late final GeneratedColumn<String> hlcTimestamp = GeneratedColumn<String>(
    'hlc_timestamp',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    tripId,
    name,
    targetAmount,
    currency,
    createdAt,
    hlcTimestamp,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'budget_pools';
  @override
  VerificationContext validateIntegrity(
    Insertable<BudgetPool> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('trip_id')) {
      context.handle(
        _tripIdMeta,
        tripId.isAcceptableOrUnknown(data['trip_id']!, _tripIdMeta),
      );
    } else if (isInserting) {
      context.missing(_tripIdMeta);
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('target_amount')) {
      context.handle(
        _targetAmountMeta,
        targetAmount.isAcceptableOrUnknown(
          data['target_amount']!,
          _targetAmountMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_targetAmountMeta);
    }
    if (data.containsKey('currency')) {
      context.handle(
        _currencyMeta,
        currency.isAcceptableOrUnknown(data['currency']!, _currencyMeta),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    if (data.containsKey('hlc_timestamp')) {
      context.handle(
        _hlcTimestampMeta,
        hlcTimestamp.isAcceptableOrUnknown(
          data['hlc_timestamp']!,
          _hlcTimestampMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_hlcTimestampMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  BudgetPool map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return BudgetPool(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      tripId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}trip_id'],
      )!,
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      targetAmount: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}target_amount'],
      )!,
      currency: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}currency'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}created_at'],
      )!,
      hlcTimestamp: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}hlc_timestamp'],
      )!,
    );
  }

  @override
  $BudgetPoolsTable createAlias(String alias) {
    return $BudgetPoolsTable(attachedDatabase, alias);
  }
}

class BudgetPool extends DataClass implements Insertable<BudgetPool> {
  final String id;
  final String tripId;
  final String name;
  final double targetAmount;
  final String currency;
  final int createdAt;
  final String hlcTimestamp;
  const BudgetPool({
    required this.id,
    required this.tripId,
    required this.name,
    required this.targetAmount,
    required this.currency,
    required this.createdAt,
    required this.hlcTimestamp,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['trip_id'] = Variable<String>(tripId);
    map['name'] = Variable<String>(name);
    map['target_amount'] = Variable<double>(targetAmount);
    map['currency'] = Variable<String>(currency);
    map['created_at'] = Variable<int>(createdAt);
    map['hlc_timestamp'] = Variable<String>(hlcTimestamp);
    return map;
  }

  BudgetPoolsCompanion toCompanion(bool nullToAbsent) {
    return BudgetPoolsCompanion(
      id: Value(id),
      tripId: Value(tripId),
      name: Value(name),
      targetAmount: Value(targetAmount),
      currency: Value(currency),
      createdAt: Value(createdAt),
      hlcTimestamp: Value(hlcTimestamp),
    );
  }

  factory BudgetPool.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return BudgetPool(
      id: serializer.fromJson<String>(json['id']),
      tripId: serializer.fromJson<String>(json['tripId']),
      name: serializer.fromJson<String>(json['name']),
      targetAmount: serializer.fromJson<double>(json['targetAmount']),
      currency: serializer.fromJson<String>(json['currency']),
      createdAt: serializer.fromJson<int>(json['createdAt']),
      hlcTimestamp: serializer.fromJson<String>(json['hlcTimestamp']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'tripId': serializer.toJson<String>(tripId),
      'name': serializer.toJson<String>(name),
      'targetAmount': serializer.toJson<double>(targetAmount),
      'currency': serializer.toJson<String>(currency),
      'createdAt': serializer.toJson<int>(createdAt),
      'hlcTimestamp': serializer.toJson<String>(hlcTimestamp),
    };
  }

  BudgetPool copyWith({
    String? id,
    String? tripId,
    String? name,
    double? targetAmount,
    String? currency,
    int? createdAt,
    String? hlcTimestamp,
  }) => BudgetPool(
    id: id ?? this.id,
    tripId: tripId ?? this.tripId,
    name: name ?? this.name,
    targetAmount: targetAmount ?? this.targetAmount,
    currency: currency ?? this.currency,
    createdAt: createdAt ?? this.createdAt,
    hlcTimestamp: hlcTimestamp ?? this.hlcTimestamp,
  );
  BudgetPool copyWithCompanion(BudgetPoolsCompanion data) {
    return BudgetPool(
      id: data.id.present ? data.id.value : this.id,
      tripId: data.tripId.present ? data.tripId.value : this.tripId,
      name: data.name.present ? data.name.value : this.name,
      targetAmount: data.targetAmount.present
          ? data.targetAmount.value
          : this.targetAmount,
      currency: data.currency.present ? data.currency.value : this.currency,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      hlcTimestamp: data.hlcTimestamp.present
          ? data.hlcTimestamp.value
          : this.hlcTimestamp,
    );
  }

  @override
  String toString() {
    return (StringBuffer('BudgetPool(')
          ..write('id: $id, ')
          ..write('tripId: $tripId, ')
          ..write('name: $name, ')
          ..write('targetAmount: $targetAmount, ')
          ..write('currency: $currency, ')
          ..write('createdAt: $createdAt, ')
          ..write('hlcTimestamp: $hlcTimestamp')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    tripId,
    name,
    targetAmount,
    currency,
    createdAt,
    hlcTimestamp,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is BudgetPool &&
          other.id == this.id &&
          other.tripId == this.tripId &&
          other.name == this.name &&
          other.targetAmount == this.targetAmount &&
          other.currency == this.currency &&
          other.createdAt == this.createdAt &&
          other.hlcTimestamp == this.hlcTimestamp);
}

class BudgetPoolsCompanion extends UpdateCompanion<BudgetPool> {
  final Value<String> id;
  final Value<String> tripId;
  final Value<String> name;
  final Value<double> targetAmount;
  final Value<String> currency;
  final Value<int> createdAt;
  final Value<String> hlcTimestamp;
  final Value<int> rowid;
  const BudgetPoolsCompanion({
    this.id = const Value.absent(),
    this.tripId = const Value.absent(),
    this.name = const Value.absent(),
    this.targetAmount = const Value.absent(),
    this.currency = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.hlcTimestamp = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  BudgetPoolsCompanion.insert({
    required String id,
    required String tripId,
    required String name,
    required double targetAmount,
    this.currency = const Value.absent(),
    required int createdAt,
    required String hlcTimestamp,
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       tripId = Value(tripId),
       name = Value(name),
       targetAmount = Value(targetAmount),
       createdAt = Value(createdAt),
       hlcTimestamp = Value(hlcTimestamp);
  static Insertable<BudgetPool> custom({
    Expression<String>? id,
    Expression<String>? tripId,
    Expression<String>? name,
    Expression<double>? targetAmount,
    Expression<String>? currency,
    Expression<int>? createdAt,
    Expression<String>? hlcTimestamp,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (tripId != null) 'trip_id': tripId,
      if (name != null) 'name': name,
      if (targetAmount != null) 'target_amount': targetAmount,
      if (currency != null) 'currency': currency,
      if (createdAt != null) 'created_at': createdAt,
      if (hlcTimestamp != null) 'hlc_timestamp': hlcTimestamp,
      if (rowid != null) 'rowid': rowid,
    });
  }

  BudgetPoolsCompanion copyWith({
    Value<String>? id,
    Value<String>? tripId,
    Value<String>? name,
    Value<double>? targetAmount,
    Value<String>? currency,
    Value<int>? createdAt,
    Value<String>? hlcTimestamp,
    Value<int>? rowid,
  }) {
    return BudgetPoolsCompanion(
      id: id ?? this.id,
      tripId: tripId ?? this.tripId,
      name: name ?? this.name,
      targetAmount: targetAmount ?? this.targetAmount,
      currency: currency ?? this.currency,
      createdAt: createdAt ?? this.createdAt,
      hlcTimestamp: hlcTimestamp ?? this.hlcTimestamp,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (tripId.present) {
      map['trip_id'] = Variable<String>(tripId.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (targetAmount.present) {
      map['target_amount'] = Variable<double>(targetAmount.value);
    }
    if (currency.present) {
      map['currency'] = Variable<String>(currency.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<int>(createdAt.value);
    }
    if (hlcTimestamp.present) {
      map['hlc_timestamp'] = Variable<String>(hlcTimestamp.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('BudgetPoolsCompanion(')
          ..write('id: $id, ')
          ..write('tripId: $tripId, ')
          ..write('name: $name, ')
          ..write('targetAmount: $targetAmount, ')
          ..write('currency: $currency, ')
          ..write('createdAt: $createdAt, ')
          ..write('hlcTimestamp: $hlcTimestamp, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $BudgetContributionsTable extends BudgetContributions
    with TableInfo<$BudgetContributionsTable, BudgetContribution> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $BudgetContributionsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _poolIdMeta = const VerificationMeta('poolId');
  @override
  late final GeneratedColumn<String> poolId = GeneratedColumn<String>(
    'pool_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _userIdMeta = const VerificationMeta('userId');
  @override
  late final GeneratedColumn<String> userId = GeneratedColumn<String>(
    'user_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _amountMeta = const VerificationMeta('amount');
  @override
  late final GeneratedColumn<double> amount = GeneratedColumn<double>(
    'amount',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _contributedAtMeta = const VerificationMeta(
    'contributedAt',
  );
  @override
  late final GeneratedColumn<int> contributedAt = GeneratedColumn<int>(
    'contributed_at',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _hlcTimestampMeta = const VerificationMeta(
    'hlcTimestamp',
  );
  @override
  late final GeneratedColumn<String> hlcTimestamp = GeneratedColumn<String>(
    'hlc_timestamp',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    poolId,
    userId,
    amount,
    contributedAt,
    hlcTimestamp,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'budget_contributions';
  @override
  VerificationContext validateIntegrity(
    Insertable<BudgetContribution> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('pool_id')) {
      context.handle(
        _poolIdMeta,
        poolId.isAcceptableOrUnknown(data['pool_id']!, _poolIdMeta),
      );
    } else if (isInserting) {
      context.missing(_poolIdMeta);
    }
    if (data.containsKey('user_id')) {
      context.handle(
        _userIdMeta,
        userId.isAcceptableOrUnknown(data['user_id']!, _userIdMeta),
      );
    } else if (isInserting) {
      context.missing(_userIdMeta);
    }
    if (data.containsKey('amount')) {
      context.handle(
        _amountMeta,
        amount.isAcceptableOrUnknown(data['amount']!, _amountMeta),
      );
    } else if (isInserting) {
      context.missing(_amountMeta);
    }
    if (data.containsKey('contributed_at')) {
      context.handle(
        _contributedAtMeta,
        contributedAt.isAcceptableOrUnknown(
          data['contributed_at']!,
          _contributedAtMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_contributedAtMeta);
    }
    if (data.containsKey('hlc_timestamp')) {
      context.handle(
        _hlcTimestampMeta,
        hlcTimestamp.isAcceptableOrUnknown(
          data['hlc_timestamp']!,
          _hlcTimestampMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_hlcTimestampMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  BudgetContribution map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return BudgetContribution(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      poolId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}pool_id'],
      )!,
      userId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}user_id'],
      )!,
      amount: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}amount'],
      )!,
      contributedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}contributed_at'],
      )!,
      hlcTimestamp: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}hlc_timestamp'],
      )!,
    );
  }

  @override
  $BudgetContributionsTable createAlias(String alias) {
    return $BudgetContributionsTable(attachedDatabase, alias);
  }
}

class BudgetContribution extends DataClass
    implements Insertable<BudgetContribution> {
  final String id;
  final String poolId;
  final String userId;
  final double amount;
  final int contributedAt;
  final String hlcTimestamp;
  const BudgetContribution({
    required this.id,
    required this.poolId,
    required this.userId,
    required this.amount,
    required this.contributedAt,
    required this.hlcTimestamp,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['pool_id'] = Variable<String>(poolId);
    map['user_id'] = Variable<String>(userId);
    map['amount'] = Variable<double>(amount);
    map['contributed_at'] = Variable<int>(contributedAt);
    map['hlc_timestamp'] = Variable<String>(hlcTimestamp);
    return map;
  }

  BudgetContributionsCompanion toCompanion(bool nullToAbsent) {
    return BudgetContributionsCompanion(
      id: Value(id),
      poolId: Value(poolId),
      userId: Value(userId),
      amount: Value(amount),
      contributedAt: Value(contributedAt),
      hlcTimestamp: Value(hlcTimestamp),
    );
  }

  factory BudgetContribution.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return BudgetContribution(
      id: serializer.fromJson<String>(json['id']),
      poolId: serializer.fromJson<String>(json['poolId']),
      userId: serializer.fromJson<String>(json['userId']),
      amount: serializer.fromJson<double>(json['amount']),
      contributedAt: serializer.fromJson<int>(json['contributedAt']),
      hlcTimestamp: serializer.fromJson<String>(json['hlcTimestamp']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'poolId': serializer.toJson<String>(poolId),
      'userId': serializer.toJson<String>(userId),
      'amount': serializer.toJson<double>(amount),
      'contributedAt': serializer.toJson<int>(contributedAt),
      'hlcTimestamp': serializer.toJson<String>(hlcTimestamp),
    };
  }

  BudgetContribution copyWith({
    String? id,
    String? poolId,
    String? userId,
    double? amount,
    int? contributedAt,
    String? hlcTimestamp,
  }) => BudgetContribution(
    id: id ?? this.id,
    poolId: poolId ?? this.poolId,
    userId: userId ?? this.userId,
    amount: amount ?? this.amount,
    contributedAt: contributedAt ?? this.contributedAt,
    hlcTimestamp: hlcTimestamp ?? this.hlcTimestamp,
  );
  BudgetContribution copyWithCompanion(BudgetContributionsCompanion data) {
    return BudgetContribution(
      id: data.id.present ? data.id.value : this.id,
      poolId: data.poolId.present ? data.poolId.value : this.poolId,
      userId: data.userId.present ? data.userId.value : this.userId,
      amount: data.amount.present ? data.amount.value : this.amount,
      contributedAt: data.contributedAt.present
          ? data.contributedAt.value
          : this.contributedAt,
      hlcTimestamp: data.hlcTimestamp.present
          ? data.hlcTimestamp.value
          : this.hlcTimestamp,
    );
  }

  @override
  String toString() {
    return (StringBuffer('BudgetContribution(')
          ..write('id: $id, ')
          ..write('poolId: $poolId, ')
          ..write('userId: $userId, ')
          ..write('amount: $amount, ')
          ..write('contributedAt: $contributedAt, ')
          ..write('hlcTimestamp: $hlcTimestamp')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, poolId, userId, amount, contributedAt, hlcTimestamp);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is BudgetContribution &&
          other.id == this.id &&
          other.poolId == this.poolId &&
          other.userId == this.userId &&
          other.amount == this.amount &&
          other.contributedAt == this.contributedAt &&
          other.hlcTimestamp == this.hlcTimestamp);
}

class BudgetContributionsCompanion extends UpdateCompanion<BudgetContribution> {
  final Value<String> id;
  final Value<String> poolId;
  final Value<String> userId;
  final Value<double> amount;
  final Value<int> contributedAt;
  final Value<String> hlcTimestamp;
  final Value<int> rowid;
  const BudgetContributionsCompanion({
    this.id = const Value.absent(),
    this.poolId = const Value.absent(),
    this.userId = const Value.absent(),
    this.amount = const Value.absent(),
    this.contributedAt = const Value.absent(),
    this.hlcTimestamp = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  BudgetContributionsCompanion.insert({
    required String id,
    required String poolId,
    required String userId,
    required double amount,
    required int contributedAt,
    required String hlcTimestamp,
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       poolId = Value(poolId),
       userId = Value(userId),
       amount = Value(amount),
       contributedAt = Value(contributedAt),
       hlcTimestamp = Value(hlcTimestamp);
  static Insertable<BudgetContribution> custom({
    Expression<String>? id,
    Expression<String>? poolId,
    Expression<String>? userId,
    Expression<double>? amount,
    Expression<int>? contributedAt,
    Expression<String>? hlcTimestamp,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (poolId != null) 'pool_id': poolId,
      if (userId != null) 'user_id': userId,
      if (amount != null) 'amount': amount,
      if (contributedAt != null) 'contributed_at': contributedAt,
      if (hlcTimestamp != null) 'hlc_timestamp': hlcTimestamp,
      if (rowid != null) 'rowid': rowid,
    });
  }

  BudgetContributionsCompanion copyWith({
    Value<String>? id,
    Value<String>? poolId,
    Value<String>? userId,
    Value<double>? amount,
    Value<int>? contributedAt,
    Value<String>? hlcTimestamp,
    Value<int>? rowid,
  }) {
    return BudgetContributionsCompanion(
      id: id ?? this.id,
      poolId: poolId ?? this.poolId,
      userId: userId ?? this.userId,
      amount: amount ?? this.amount,
      contributedAt: contributedAt ?? this.contributedAt,
      hlcTimestamp: hlcTimestamp ?? this.hlcTimestamp,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (poolId.present) {
      map['pool_id'] = Variable<String>(poolId.value);
    }
    if (userId.present) {
      map['user_id'] = Variable<String>(userId.value);
    }
    if (amount.present) {
      map['amount'] = Variable<double>(amount.value);
    }
    if (contributedAt.present) {
      map['contributed_at'] = Variable<int>(contributedAt.value);
    }
    if (hlcTimestamp.present) {
      map['hlc_timestamp'] = Variable<String>(hlcTimestamp.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('BudgetContributionsCompanion(')
          ..write('id: $id, ')
          ..write('poolId: $poolId, ')
          ..write('userId: $userId, ')
          ..write('amount: $amount, ')
          ..write('contributedAt: $contributedAt, ')
          ..write('hlcTimestamp: $hlcTimestamp, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $SyncQueueTable extends SyncQueue
    with TableInfo<$SyncQueueTable, SyncQueueData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $SyncQueueTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _syncTableNameMeta = const VerificationMeta(
    'syncTableName',
  );
  @override
  late final GeneratedColumn<String> syncTableName = GeneratedColumn<String>(
    'sync_table_name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _recordIdMeta = const VerificationMeta(
    'recordId',
  );
  @override
  late final GeneratedColumn<String> recordId = GeneratedColumn<String>(
    'record_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _operationMeta = const VerificationMeta(
    'operation',
  );
  @override
  late final GeneratedColumn<String> operation = GeneratedColumn<String>(
    'operation',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _payloadMeta = const VerificationMeta(
    'payload',
  );
  @override
  late final GeneratedColumn<String> payload = GeneratedColumn<String>(
    'payload',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _hlcTimestampMeta = const VerificationMeta(
    'hlcTimestamp',
  );
  @override
  late final GeneratedColumn<String> hlcTimestamp = GeneratedColumn<String>(
    'hlc_timestamp',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _syncedMeta = const VerificationMeta('synced');
  @override
  late final GeneratedColumn<bool> synced = GeneratedColumn<bool>(
    'synced',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("synced" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<int> createdAt = GeneratedColumn<int>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    syncTableName,
    recordId,
    operation,
    payload,
    hlcTimestamp,
    synced,
    createdAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'sync_queue';
  @override
  VerificationContext validateIntegrity(
    Insertable<SyncQueueData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('sync_table_name')) {
      context.handle(
        _syncTableNameMeta,
        syncTableName.isAcceptableOrUnknown(
          data['sync_table_name']!,
          _syncTableNameMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_syncTableNameMeta);
    }
    if (data.containsKey('record_id')) {
      context.handle(
        _recordIdMeta,
        recordId.isAcceptableOrUnknown(data['record_id']!, _recordIdMeta),
      );
    } else if (isInserting) {
      context.missing(_recordIdMeta);
    }
    if (data.containsKey('operation')) {
      context.handle(
        _operationMeta,
        operation.isAcceptableOrUnknown(data['operation']!, _operationMeta),
      );
    } else if (isInserting) {
      context.missing(_operationMeta);
    }
    if (data.containsKey('payload')) {
      context.handle(
        _payloadMeta,
        payload.isAcceptableOrUnknown(data['payload']!, _payloadMeta),
      );
    } else if (isInserting) {
      context.missing(_payloadMeta);
    }
    if (data.containsKey('hlc_timestamp')) {
      context.handle(
        _hlcTimestampMeta,
        hlcTimestamp.isAcceptableOrUnknown(
          data['hlc_timestamp']!,
          _hlcTimestampMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_hlcTimestampMeta);
    }
    if (data.containsKey('synced')) {
      context.handle(
        _syncedMeta,
        synced.isAcceptableOrUnknown(data['synced']!, _syncedMeta),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  SyncQueueData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return SyncQueueData(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      syncTableName: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}sync_table_name'],
      )!,
      recordId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}record_id'],
      )!,
      operation: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}operation'],
      )!,
      payload: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}payload'],
      )!,
      hlcTimestamp: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}hlc_timestamp'],
      )!,
      synced: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}synced'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}created_at'],
      )!,
    );
  }

  @override
  $SyncQueueTable createAlias(String alias) {
    return $SyncQueueTable(attachedDatabase, alias);
  }
}

class SyncQueueData extends DataClass implements Insertable<SyncQueueData> {
  final int id;
  final String syncTableName;
  final String recordId;
  final String operation;
  final String payload;
  final String hlcTimestamp;
  final bool synced;
  final int createdAt;
  const SyncQueueData({
    required this.id,
    required this.syncTableName,
    required this.recordId,
    required this.operation,
    required this.payload,
    required this.hlcTimestamp,
    required this.synced,
    required this.createdAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['sync_table_name'] = Variable<String>(syncTableName);
    map['record_id'] = Variable<String>(recordId);
    map['operation'] = Variable<String>(operation);
    map['payload'] = Variable<String>(payload);
    map['hlc_timestamp'] = Variable<String>(hlcTimestamp);
    map['synced'] = Variable<bool>(synced);
    map['created_at'] = Variable<int>(createdAt);
    return map;
  }

  SyncQueueCompanion toCompanion(bool nullToAbsent) {
    return SyncQueueCompanion(
      id: Value(id),
      syncTableName: Value(syncTableName),
      recordId: Value(recordId),
      operation: Value(operation),
      payload: Value(payload),
      hlcTimestamp: Value(hlcTimestamp),
      synced: Value(synced),
      createdAt: Value(createdAt),
    );
  }

  factory SyncQueueData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return SyncQueueData(
      id: serializer.fromJson<int>(json['id']),
      syncTableName: serializer.fromJson<String>(json['syncTableName']),
      recordId: serializer.fromJson<String>(json['recordId']),
      operation: serializer.fromJson<String>(json['operation']),
      payload: serializer.fromJson<String>(json['payload']),
      hlcTimestamp: serializer.fromJson<String>(json['hlcTimestamp']),
      synced: serializer.fromJson<bool>(json['synced']),
      createdAt: serializer.fromJson<int>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'syncTableName': serializer.toJson<String>(syncTableName),
      'recordId': serializer.toJson<String>(recordId),
      'operation': serializer.toJson<String>(operation),
      'payload': serializer.toJson<String>(payload),
      'hlcTimestamp': serializer.toJson<String>(hlcTimestamp),
      'synced': serializer.toJson<bool>(synced),
      'createdAt': serializer.toJson<int>(createdAt),
    };
  }

  SyncQueueData copyWith({
    int? id,
    String? syncTableName,
    String? recordId,
    String? operation,
    String? payload,
    String? hlcTimestamp,
    bool? synced,
    int? createdAt,
  }) => SyncQueueData(
    id: id ?? this.id,
    syncTableName: syncTableName ?? this.syncTableName,
    recordId: recordId ?? this.recordId,
    operation: operation ?? this.operation,
    payload: payload ?? this.payload,
    hlcTimestamp: hlcTimestamp ?? this.hlcTimestamp,
    synced: synced ?? this.synced,
    createdAt: createdAt ?? this.createdAt,
  );
  SyncQueueData copyWithCompanion(SyncQueueCompanion data) {
    return SyncQueueData(
      id: data.id.present ? data.id.value : this.id,
      syncTableName: data.syncTableName.present
          ? data.syncTableName.value
          : this.syncTableName,
      recordId: data.recordId.present ? data.recordId.value : this.recordId,
      operation: data.operation.present ? data.operation.value : this.operation,
      payload: data.payload.present ? data.payload.value : this.payload,
      hlcTimestamp: data.hlcTimestamp.present
          ? data.hlcTimestamp.value
          : this.hlcTimestamp,
      synced: data.synced.present ? data.synced.value : this.synced,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('SyncQueueData(')
          ..write('id: $id, ')
          ..write('syncTableName: $syncTableName, ')
          ..write('recordId: $recordId, ')
          ..write('operation: $operation, ')
          ..write('payload: $payload, ')
          ..write('hlcTimestamp: $hlcTimestamp, ')
          ..write('synced: $synced, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    syncTableName,
    recordId,
    operation,
    payload,
    hlcTimestamp,
    synced,
    createdAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is SyncQueueData &&
          other.id == this.id &&
          other.syncTableName == this.syncTableName &&
          other.recordId == this.recordId &&
          other.operation == this.operation &&
          other.payload == this.payload &&
          other.hlcTimestamp == this.hlcTimestamp &&
          other.synced == this.synced &&
          other.createdAt == this.createdAt);
}

class SyncQueueCompanion extends UpdateCompanion<SyncQueueData> {
  final Value<int> id;
  final Value<String> syncTableName;
  final Value<String> recordId;
  final Value<String> operation;
  final Value<String> payload;
  final Value<String> hlcTimestamp;
  final Value<bool> synced;
  final Value<int> createdAt;
  const SyncQueueCompanion({
    this.id = const Value.absent(),
    this.syncTableName = const Value.absent(),
    this.recordId = const Value.absent(),
    this.operation = const Value.absent(),
    this.payload = const Value.absent(),
    this.hlcTimestamp = const Value.absent(),
    this.synced = const Value.absent(),
    this.createdAt = const Value.absent(),
  });
  SyncQueueCompanion.insert({
    this.id = const Value.absent(),
    required String syncTableName,
    required String recordId,
    required String operation,
    required String payload,
    required String hlcTimestamp,
    this.synced = const Value.absent(),
    required int createdAt,
  }) : syncTableName = Value(syncTableName),
       recordId = Value(recordId),
       operation = Value(operation),
       payload = Value(payload),
       hlcTimestamp = Value(hlcTimestamp),
       createdAt = Value(createdAt);
  static Insertable<SyncQueueData> custom({
    Expression<int>? id,
    Expression<String>? syncTableName,
    Expression<String>? recordId,
    Expression<String>? operation,
    Expression<String>? payload,
    Expression<String>? hlcTimestamp,
    Expression<bool>? synced,
    Expression<int>? createdAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (syncTableName != null) 'sync_table_name': syncTableName,
      if (recordId != null) 'record_id': recordId,
      if (operation != null) 'operation': operation,
      if (payload != null) 'payload': payload,
      if (hlcTimestamp != null) 'hlc_timestamp': hlcTimestamp,
      if (synced != null) 'synced': synced,
      if (createdAt != null) 'created_at': createdAt,
    });
  }

  SyncQueueCompanion copyWith({
    Value<int>? id,
    Value<String>? syncTableName,
    Value<String>? recordId,
    Value<String>? operation,
    Value<String>? payload,
    Value<String>? hlcTimestamp,
    Value<bool>? synced,
    Value<int>? createdAt,
  }) {
    return SyncQueueCompanion(
      id: id ?? this.id,
      syncTableName: syncTableName ?? this.syncTableName,
      recordId: recordId ?? this.recordId,
      operation: operation ?? this.operation,
      payload: payload ?? this.payload,
      hlcTimestamp: hlcTimestamp ?? this.hlcTimestamp,
      synced: synced ?? this.synced,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (syncTableName.present) {
      map['sync_table_name'] = Variable<String>(syncTableName.value);
    }
    if (recordId.present) {
      map['record_id'] = Variable<String>(recordId.value);
    }
    if (operation.present) {
      map['operation'] = Variable<String>(operation.value);
    }
    if (payload.present) {
      map['payload'] = Variable<String>(payload.value);
    }
    if (hlcTimestamp.present) {
      map['hlc_timestamp'] = Variable<String>(hlcTimestamp.value);
    }
    if (synced.present) {
      map['synced'] = Variable<bool>(synced.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<int>(createdAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('SyncQueueCompanion(')
          ..write('id: $id, ')
          ..write('syncTableName: $syncTableName, ')
          ..write('recordId: $recordId, ')
          ..write('operation: $operation, ')
          ..write('payload: $payload, ')
          ..write('hlcTimestamp: $hlcTimestamp, ')
          ..write('synced: $synced, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }
}

class $PeerSyncStateTable extends PeerSyncState
    with TableInfo<$PeerSyncStateTable, PeerSyncStateData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $PeerSyncStateTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _peerDeviceIdMeta = const VerificationMeta(
    'peerDeviceId',
  );
  @override
  late final GeneratedColumn<String> peerDeviceId = GeneratedColumn<String>(
    'peer_device_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _syncTableNameMeta = const VerificationMeta(
    'syncTableName',
  );
  @override
  late final GeneratedColumn<String> syncTableName = GeneratedColumn<String>(
    'sync_table_name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _lastSyncedHlcMeta = const VerificationMeta(
    'lastSyncedHlc',
  );
  @override
  late final GeneratedColumn<String> lastSyncedHlc = GeneratedColumn<String>(
    'last_synced_hlc',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _lastSyncAtMeta = const VerificationMeta(
    'lastSyncAt',
  );
  @override
  late final GeneratedColumn<int> lastSyncAt = GeneratedColumn<int>(
    'last_sync_at',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    peerDeviceId,
    syncTableName,
    lastSyncedHlc,
    lastSyncAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'peer_sync_state';
  @override
  VerificationContext validateIntegrity(
    Insertable<PeerSyncStateData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('peer_device_id')) {
      context.handle(
        _peerDeviceIdMeta,
        peerDeviceId.isAcceptableOrUnknown(
          data['peer_device_id']!,
          _peerDeviceIdMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_peerDeviceIdMeta);
    }
    if (data.containsKey('sync_table_name')) {
      context.handle(
        _syncTableNameMeta,
        syncTableName.isAcceptableOrUnknown(
          data['sync_table_name']!,
          _syncTableNameMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_syncTableNameMeta);
    }
    if (data.containsKey('last_synced_hlc')) {
      context.handle(
        _lastSyncedHlcMeta,
        lastSyncedHlc.isAcceptableOrUnknown(
          data['last_synced_hlc']!,
          _lastSyncedHlcMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_lastSyncedHlcMeta);
    }
    if (data.containsKey('last_sync_at')) {
      context.handle(
        _lastSyncAtMeta,
        lastSyncAt.isAcceptableOrUnknown(
          data['last_sync_at']!,
          _lastSyncAtMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_lastSyncAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {peerDeviceId, syncTableName};
  @override
  PeerSyncStateData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return PeerSyncStateData(
      peerDeviceId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}peer_device_id'],
      )!,
      syncTableName: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}sync_table_name'],
      )!,
      lastSyncedHlc: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}last_synced_hlc'],
      )!,
      lastSyncAt: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}last_sync_at'],
      )!,
    );
  }

  @override
  $PeerSyncStateTable createAlias(String alias) {
    return $PeerSyncStateTable(attachedDatabase, alias);
  }
}

class PeerSyncStateData extends DataClass
    implements Insertable<PeerSyncStateData> {
  final String peerDeviceId;
  final String syncTableName;
  final String lastSyncedHlc;
  final int lastSyncAt;
  const PeerSyncStateData({
    required this.peerDeviceId,
    required this.syncTableName,
    required this.lastSyncedHlc,
    required this.lastSyncAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['peer_device_id'] = Variable<String>(peerDeviceId);
    map['sync_table_name'] = Variable<String>(syncTableName);
    map['last_synced_hlc'] = Variable<String>(lastSyncedHlc);
    map['last_sync_at'] = Variable<int>(lastSyncAt);
    return map;
  }

  PeerSyncStateCompanion toCompanion(bool nullToAbsent) {
    return PeerSyncStateCompanion(
      peerDeviceId: Value(peerDeviceId),
      syncTableName: Value(syncTableName),
      lastSyncedHlc: Value(lastSyncedHlc),
      lastSyncAt: Value(lastSyncAt),
    );
  }

  factory PeerSyncStateData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return PeerSyncStateData(
      peerDeviceId: serializer.fromJson<String>(json['peerDeviceId']),
      syncTableName: serializer.fromJson<String>(json['syncTableName']),
      lastSyncedHlc: serializer.fromJson<String>(json['lastSyncedHlc']),
      lastSyncAt: serializer.fromJson<int>(json['lastSyncAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'peerDeviceId': serializer.toJson<String>(peerDeviceId),
      'syncTableName': serializer.toJson<String>(syncTableName),
      'lastSyncedHlc': serializer.toJson<String>(lastSyncedHlc),
      'lastSyncAt': serializer.toJson<int>(lastSyncAt),
    };
  }

  PeerSyncStateData copyWith({
    String? peerDeviceId,
    String? syncTableName,
    String? lastSyncedHlc,
    int? lastSyncAt,
  }) => PeerSyncStateData(
    peerDeviceId: peerDeviceId ?? this.peerDeviceId,
    syncTableName: syncTableName ?? this.syncTableName,
    lastSyncedHlc: lastSyncedHlc ?? this.lastSyncedHlc,
    lastSyncAt: lastSyncAt ?? this.lastSyncAt,
  );
  PeerSyncStateData copyWithCompanion(PeerSyncStateCompanion data) {
    return PeerSyncStateData(
      peerDeviceId: data.peerDeviceId.present
          ? data.peerDeviceId.value
          : this.peerDeviceId,
      syncTableName: data.syncTableName.present
          ? data.syncTableName.value
          : this.syncTableName,
      lastSyncedHlc: data.lastSyncedHlc.present
          ? data.lastSyncedHlc.value
          : this.lastSyncedHlc,
      lastSyncAt: data.lastSyncAt.present
          ? data.lastSyncAt.value
          : this.lastSyncAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('PeerSyncStateData(')
          ..write('peerDeviceId: $peerDeviceId, ')
          ..write('syncTableName: $syncTableName, ')
          ..write('lastSyncedHlc: $lastSyncedHlc, ')
          ..write('lastSyncAt: $lastSyncAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(peerDeviceId, syncTableName, lastSyncedHlc, lastSyncAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is PeerSyncStateData &&
          other.peerDeviceId == this.peerDeviceId &&
          other.syncTableName == this.syncTableName &&
          other.lastSyncedHlc == this.lastSyncedHlc &&
          other.lastSyncAt == this.lastSyncAt);
}

class PeerSyncStateCompanion extends UpdateCompanion<PeerSyncStateData> {
  final Value<String> peerDeviceId;
  final Value<String> syncTableName;
  final Value<String> lastSyncedHlc;
  final Value<int> lastSyncAt;
  final Value<int> rowid;
  const PeerSyncStateCompanion({
    this.peerDeviceId = const Value.absent(),
    this.syncTableName = const Value.absent(),
    this.lastSyncedHlc = const Value.absent(),
    this.lastSyncAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  PeerSyncStateCompanion.insert({
    required String peerDeviceId,
    required String syncTableName,
    required String lastSyncedHlc,
    required int lastSyncAt,
    this.rowid = const Value.absent(),
  }) : peerDeviceId = Value(peerDeviceId),
       syncTableName = Value(syncTableName),
       lastSyncedHlc = Value(lastSyncedHlc),
       lastSyncAt = Value(lastSyncAt);
  static Insertable<PeerSyncStateData> custom({
    Expression<String>? peerDeviceId,
    Expression<String>? syncTableName,
    Expression<String>? lastSyncedHlc,
    Expression<int>? lastSyncAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (peerDeviceId != null) 'peer_device_id': peerDeviceId,
      if (syncTableName != null) 'sync_table_name': syncTableName,
      if (lastSyncedHlc != null) 'last_synced_hlc': lastSyncedHlc,
      if (lastSyncAt != null) 'last_sync_at': lastSyncAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  PeerSyncStateCompanion copyWith({
    Value<String>? peerDeviceId,
    Value<String>? syncTableName,
    Value<String>? lastSyncedHlc,
    Value<int>? lastSyncAt,
    Value<int>? rowid,
  }) {
    return PeerSyncStateCompanion(
      peerDeviceId: peerDeviceId ?? this.peerDeviceId,
      syncTableName: syncTableName ?? this.syncTableName,
      lastSyncedHlc: lastSyncedHlc ?? this.lastSyncedHlc,
      lastSyncAt: lastSyncAt ?? this.lastSyncAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (peerDeviceId.present) {
      map['peer_device_id'] = Variable<String>(peerDeviceId.value);
    }
    if (syncTableName.present) {
      map['sync_table_name'] = Variable<String>(syncTableName.value);
    }
    if (lastSyncedHlc.present) {
      map['last_synced_hlc'] = Variable<String>(lastSyncedHlc.value);
    }
    if (lastSyncAt.present) {
      map['last_sync_at'] = Variable<int>(lastSyncAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('PeerSyncStateCompanion(')
          ..write('peerDeviceId: $peerDeviceId, ')
          ..write('syncTableName: $syncTableName, ')
          ..write('lastSyncedHlc: $lastSyncedHlc, ')
          ..write('lastSyncAt: $lastSyncAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $UsersTable users = $UsersTable(this);
  late final $TripsTable trips = $TripsTable(this);
  late final $TripMembersTable tripMembers = $TripMembersTable(this);
  late final $ExpensesTable expenses = $ExpensesTable(this);
  late final $ExpenseSplitsTable expenseSplits = $ExpenseSplitsTable(this);
  late final $SettlementsTable settlements = $SettlementsTable(this);
  late final $MessagesTable messages = $MessagesTable(this);
  late final $BudgetPoolsTable budgetPools = $BudgetPoolsTable(this);
  late final $BudgetContributionsTable budgetContributions =
      $BudgetContributionsTable(this);
  late final $SyncQueueTable syncQueue = $SyncQueueTable(this);
  late final $PeerSyncStateTable peerSyncState = $PeerSyncStateTable(this);
  late final TripDao tripDao = TripDao(this as AppDatabase);
  late final ExpenseDao expenseDao = ExpenseDao(this as AppDatabase);
  late final ChatDao chatDao = ChatDao(this as AppDatabase);
  late final SyncDao syncDao = SyncDao(this as AppDatabase);
  late final UserDao userDao = UserDao(this as AppDatabase);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
    users,
    trips,
    tripMembers,
    expenses,
    expenseSplits,
    settlements,
    messages,
    budgetPools,
    budgetContributions,
    syncQueue,
    peerSyncState,
  ];
}

typedef $$UsersTableCreateCompanionBuilder =
    UsersCompanion Function({
      required String id,
      required String displayName,
      Value<String?> avatarPath,
      required String deviceId,
      Value<String?> phoneNumber,
      required int createdAt,
      required String hlcTimestamp,
      Value<int> rowid,
    });
typedef $$UsersTableUpdateCompanionBuilder =
    UsersCompanion Function({
      Value<String> id,
      Value<String> displayName,
      Value<String?> avatarPath,
      Value<String> deviceId,
      Value<String?> phoneNumber,
      Value<int> createdAt,
      Value<String> hlcTimestamp,
      Value<int> rowid,
    });

class $$UsersTableFilterComposer extends Composer<_$AppDatabase, $UsersTable> {
  $$UsersTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get displayName => $composableBuilder(
    column: $table.displayName,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get avatarPath => $composableBuilder(
    column: $table.avatarPath,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get deviceId => $composableBuilder(
    column: $table.deviceId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get phoneNumber => $composableBuilder(
    column: $table.phoneNumber,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get hlcTimestamp => $composableBuilder(
    column: $table.hlcTimestamp,
    builder: (column) => ColumnFilters(column),
  );
}

class $$UsersTableOrderingComposer
    extends Composer<_$AppDatabase, $UsersTable> {
  $$UsersTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get displayName => $composableBuilder(
    column: $table.displayName,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get avatarPath => $composableBuilder(
    column: $table.avatarPath,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get deviceId => $composableBuilder(
    column: $table.deviceId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get phoneNumber => $composableBuilder(
    column: $table.phoneNumber,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get hlcTimestamp => $composableBuilder(
    column: $table.hlcTimestamp,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$UsersTableAnnotationComposer
    extends Composer<_$AppDatabase, $UsersTable> {
  $$UsersTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get displayName => $composableBuilder(
    column: $table.displayName,
    builder: (column) => column,
  );

  GeneratedColumn<String> get avatarPath => $composableBuilder(
    column: $table.avatarPath,
    builder: (column) => column,
  );

  GeneratedColumn<String> get deviceId =>
      $composableBuilder(column: $table.deviceId, builder: (column) => column);

  GeneratedColumn<String> get phoneNumber => $composableBuilder(
    column: $table.phoneNumber,
    builder: (column) => column,
  );

  GeneratedColumn<int> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<String> get hlcTimestamp => $composableBuilder(
    column: $table.hlcTimestamp,
    builder: (column) => column,
  );
}

class $$UsersTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $UsersTable,
          User,
          $$UsersTableFilterComposer,
          $$UsersTableOrderingComposer,
          $$UsersTableAnnotationComposer,
          $$UsersTableCreateCompanionBuilder,
          $$UsersTableUpdateCompanionBuilder,
          (User, BaseReferences<_$AppDatabase, $UsersTable, User>),
          User,
          PrefetchHooks Function()
        > {
  $$UsersTableTableManager(_$AppDatabase db, $UsersTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$UsersTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$UsersTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$UsersTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> displayName = const Value.absent(),
                Value<String?> avatarPath = const Value.absent(),
                Value<String> deviceId = const Value.absent(),
                Value<String?> phoneNumber = const Value.absent(),
                Value<int> createdAt = const Value.absent(),
                Value<String> hlcTimestamp = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => UsersCompanion(
                id: id,
                displayName: displayName,
                avatarPath: avatarPath,
                deviceId: deviceId,
                phoneNumber: phoneNumber,
                createdAt: createdAt,
                hlcTimestamp: hlcTimestamp,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String displayName,
                Value<String?> avatarPath = const Value.absent(),
                required String deviceId,
                Value<String?> phoneNumber = const Value.absent(),
                required int createdAt,
                required String hlcTimestamp,
                Value<int> rowid = const Value.absent(),
              }) => UsersCompanion.insert(
                id: id,
                displayName: displayName,
                avatarPath: avatarPath,
                deviceId: deviceId,
                phoneNumber: phoneNumber,
                createdAt: createdAt,
                hlcTimestamp: hlcTimestamp,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$UsersTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $UsersTable,
      User,
      $$UsersTableFilterComposer,
      $$UsersTableOrderingComposer,
      $$UsersTableAnnotationComposer,
      $$UsersTableCreateCompanionBuilder,
      $$UsersTableUpdateCompanionBuilder,
      (User, BaseReferences<_$AppDatabase, $UsersTable, User>),
      User,
      PrefetchHooks Function()
    >;
typedef $$TripsTableCreateCompanionBuilder =
    TripsCompanion Function({
      required String id,
      required String name,
      Value<String?> description,
      Value<String?> coverImagePath,
      Value<String> baseCurrency,
      required String createdBy,
      Value<int?> startDate,
      Value<int?> endDate,
      Value<bool> isArchived,
      required int createdAt,
      required int updatedAt,
      required String hlcTimestamp,
      Value<int> rowid,
    });
typedef $$TripsTableUpdateCompanionBuilder =
    TripsCompanion Function({
      Value<String> id,
      Value<String> name,
      Value<String?> description,
      Value<String?> coverImagePath,
      Value<String> baseCurrency,
      Value<String> createdBy,
      Value<int?> startDate,
      Value<int?> endDate,
      Value<bool> isArchived,
      Value<int> createdAt,
      Value<int> updatedAt,
      Value<String> hlcTimestamp,
      Value<int> rowid,
    });

class $$TripsTableFilterComposer extends Composer<_$AppDatabase, $TripsTable> {
  $$TripsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get coverImagePath => $composableBuilder(
    column: $table.coverImagePath,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get baseCurrency => $composableBuilder(
    column: $table.baseCurrency,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get createdBy => $composableBuilder(
    column: $table.createdBy,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get startDate => $composableBuilder(
    column: $table.startDate,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get endDate => $composableBuilder(
    column: $table.endDate,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isArchived => $composableBuilder(
    column: $table.isArchived,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get hlcTimestamp => $composableBuilder(
    column: $table.hlcTimestamp,
    builder: (column) => ColumnFilters(column),
  );
}

class $$TripsTableOrderingComposer
    extends Composer<_$AppDatabase, $TripsTable> {
  $$TripsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get coverImagePath => $composableBuilder(
    column: $table.coverImagePath,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get baseCurrency => $composableBuilder(
    column: $table.baseCurrency,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get createdBy => $composableBuilder(
    column: $table.createdBy,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get startDate => $composableBuilder(
    column: $table.startDate,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get endDate => $composableBuilder(
    column: $table.endDate,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isArchived => $composableBuilder(
    column: $table.isArchived,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get hlcTimestamp => $composableBuilder(
    column: $table.hlcTimestamp,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$TripsTableAnnotationComposer
    extends Composer<_$AppDatabase, $TripsTable> {
  $$TripsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => column,
  );

  GeneratedColumn<String> get coverImagePath => $composableBuilder(
    column: $table.coverImagePath,
    builder: (column) => column,
  );

  GeneratedColumn<String> get baseCurrency => $composableBuilder(
    column: $table.baseCurrency,
    builder: (column) => column,
  );

  GeneratedColumn<String> get createdBy =>
      $composableBuilder(column: $table.createdBy, builder: (column) => column);

  GeneratedColumn<int> get startDate =>
      $composableBuilder(column: $table.startDate, builder: (column) => column);

  GeneratedColumn<int> get endDate =>
      $composableBuilder(column: $table.endDate, builder: (column) => column);

  GeneratedColumn<bool> get isArchived => $composableBuilder(
    column: $table.isArchived,
    builder: (column) => column,
  );

  GeneratedColumn<int> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<int> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  GeneratedColumn<String> get hlcTimestamp => $composableBuilder(
    column: $table.hlcTimestamp,
    builder: (column) => column,
  );
}

class $$TripsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $TripsTable,
          Trip,
          $$TripsTableFilterComposer,
          $$TripsTableOrderingComposer,
          $$TripsTableAnnotationComposer,
          $$TripsTableCreateCompanionBuilder,
          $$TripsTableUpdateCompanionBuilder,
          (Trip, BaseReferences<_$AppDatabase, $TripsTable, Trip>),
          Trip,
          PrefetchHooks Function()
        > {
  $$TripsTableTableManager(_$AppDatabase db, $TripsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$TripsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$TripsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$TripsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<String?> description = const Value.absent(),
                Value<String?> coverImagePath = const Value.absent(),
                Value<String> baseCurrency = const Value.absent(),
                Value<String> createdBy = const Value.absent(),
                Value<int?> startDate = const Value.absent(),
                Value<int?> endDate = const Value.absent(),
                Value<bool> isArchived = const Value.absent(),
                Value<int> createdAt = const Value.absent(),
                Value<int> updatedAt = const Value.absent(),
                Value<String> hlcTimestamp = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => TripsCompanion(
                id: id,
                name: name,
                description: description,
                coverImagePath: coverImagePath,
                baseCurrency: baseCurrency,
                createdBy: createdBy,
                startDate: startDate,
                endDate: endDate,
                isArchived: isArchived,
                createdAt: createdAt,
                updatedAt: updatedAt,
                hlcTimestamp: hlcTimestamp,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String name,
                Value<String?> description = const Value.absent(),
                Value<String?> coverImagePath = const Value.absent(),
                Value<String> baseCurrency = const Value.absent(),
                required String createdBy,
                Value<int?> startDate = const Value.absent(),
                Value<int?> endDate = const Value.absent(),
                Value<bool> isArchived = const Value.absent(),
                required int createdAt,
                required int updatedAt,
                required String hlcTimestamp,
                Value<int> rowid = const Value.absent(),
              }) => TripsCompanion.insert(
                id: id,
                name: name,
                description: description,
                coverImagePath: coverImagePath,
                baseCurrency: baseCurrency,
                createdBy: createdBy,
                startDate: startDate,
                endDate: endDate,
                isArchived: isArchived,
                createdAt: createdAt,
                updatedAt: updatedAt,
                hlcTimestamp: hlcTimestamp,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$TripsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $TripsTable,
      Trip,
      $$TripsTableFilterComposer,
      $$TripsTableOrderingComposer,
      $$TripsTableAnnotationComposer,
      $$TripsTableCreateCompanionBuilder,
      $$TripsTableUpdateCompanionBuilder,
      (Trip, BaseReferences<_$AppDatabase, $TripsTable, Trip>),
      Trip,
      PrefetchHooks Function()
    >;
typedef $$TripMembersTableCreateCompanionBuilder =
    TripMembersCompanion Function({
      required String tripId,
      required String userId,
      Value<String> role,
      required int joinedAt,
      Value<int> rowid,
    });
typedef $$TripMembersTableUpdateCompanionBuilder =
    TripMembersCompanion Function({
      Value<String> tripId,
      Value<String> userId,
      Value<String> role,
      Value<int> joinedAt,
      Value<int> rowid,
    });

class $$TripMembersTableFilterComposer
    extends Composer<_$AppDatabase, $TripMembersTable> {
  $$TripMembersTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get tripId => $composableBuilder(
    column: $table.tripId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get userId => $composableBuilder(
    column: $table.userId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get role => $composableBuilder(
    column: $table.role,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get joinedAt => $composableBuilder(
    column: $table.joinedAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$TripMembersTableOrderingComposer
    extends Composer<_$AppDatabase, $TripMembersTable> {
  $$TripMembersTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get tripId => $composableBuilder(
    column: $table.tripId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get userId => $composableBuilder(
    column: $table.userId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get role => $composableBuilder(
    column: $table.role,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get joinedAt => $composableBuilder(
    column: $table.joinedAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$TripMembersTableAnnotationComposer
    extends Composer<_$AppDatabase, $TripMembersTable> {
  $$TripMembersTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get tripId =>
      $composableBuilder(column: $table.tripId, builder: (column) => column);

  GeneratedColumn<String> get userId =>
      $composableBuilder(column: $table.userId, builder: (column) => column);

  GeneratedColumn<String> get role =>
      $composableBuilder(column: $table.role, builder: (column) => column);

  GeneratedColumn<int> get joinedAt =>
      $composableBuilder(column: $table.joinedAt, builder: (column) => column);
}

class $$TripMembersTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $TripMembersTable,
          TripMember,
          $$TripMembersTableFilterComposer,
          $$TripMembersTableOrderingComposer,
          $$TripMembersTableAnnotationComposer,
          $$TripMembersTableCreateCompanionBuilder,
          $$TripMembersTableUpdateCompanionBuilder,
          (
            TripMember,
            BaseReferences<_$AppDatabase, $TripMembersTable, TripMember>,
          ),
          TripMember,
          PrefetchHooks Function()
        > {
  $$TripMembersTableTableManager(_$AppDatabase db, $TripMembersTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$TripMembersTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$TripMembersTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$TripMembersTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> tripId = const Value.absent(),
                Value<String> userId = const Value.absent(),
                Value<String> role = const Value.absent(),
                Value<int> joinedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => TripMembersCompanion(
                tripId: tripId,
                userId: userId,
                role: role,
                joinedAt: joinedAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String tripId,
                required String userId,
                Value<String> role = const Value.absent(),
                required int joinedAt,
                Value<int> rowid = const Value.absent(),
              }) => TripMembersCompanion.insert(
                tripId: tripId,
                userId: userId,
                role: role,
                joinedAt: joinedAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$TripMembersTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $TripMembersTable,
      TripMember,
      $$TripMembersTableFilterComposer,
      $$TripMembersTableOrderingComposer,
      $$TripMembersTableAnnotationComposer,
      $$TripMembersTableCreateCompanionBuilder,
      $$TripMembersTableUpdateCompanionBuilder,
      (
        TripMember,
        BaseReferences<_$AppDatabase, $TripMembersTable, TripMember>,
      ),
      TripMember,
      PrefetchHooks Function()
    >;
typedef $$ExpensesTableCreateCompanionBuilder =
    ExpensesCompanion Function({
      required String id,
      required String tripId,
      required String paidBy,
      required String title,
      required double amount,
      Value<String> currency,
      required String category,
      required String splitType,
      Value<String?> receiptImagePath,
      Value<String?> notes,
      required int expenseDate,
      required int createdAt,
      required int updatedAt,
      Value<bool> isDeleted,
      required String hlcTimestamp,
      Value<int> rowid,
    });
typedef $$ExpensesTableUpdateCompanionBuilder =
    ExpensesCompanion Function({
      Value<String> id,
      Value<String> tripId,
      Value<String> paidBy,
      Value<String> title,
      Value<double> amount,
      Value<String> currency,
      Value<String> category,
      Value<String> splitType,
      Value<String?> receiptImagePath,
      Value<String?> notes,
      Value<int> expenseDate,
      Value<int> createdAt,
      Value<int> updatedAt,
      Value<bool> isDeleted,
      Value<String> hlcTimestamp,
      Value<int> rowid,
    });

class $$ExpensesTableFilterComposer
    extends Composer<_$AppDatabase, $ExpensesTable> {
  $$ExpensesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get tripId => $composableBuilder(
    column: $table.tripId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get paidBy => $composableBuilder(
    column: $table.paidBy,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get title => $composableBuilder(
    column: $table.title,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get amount => $composableBuilder(
    column: $table.amount,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get currency => $composableBuilder(
    column: $table.currency,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get category => $composableBuilder(
    column: $table.category,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get splitType => $composableBuilder(
    column: $table.splitType,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get receiptImagePath => $composableBuilder(
    column: $table.receiptImagePath,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get notes => $composableBuilder(
    column: $table.notes,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get expenseDate => $composableBuilder(
    column: $table.expenseDate,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isDeleted => $composableBuilder(
    column: $table.isDeleted,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get hlcTimestamp => $composableBuilder(
    column: $table.hlcTimestamp,
    builder: (column) => ColumnFilters(column),
  );
}

class $$ExpensesTableOrderingComposer
    extends Composer<_$AppDatabase, $ExpensesTable> {
  $$ExpensesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get tripId => $composableBuilder(
    column: $table.tripId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get paidBy => $composableBuilder(
    column: $table.paidBy,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get title => $composableBuilder(
    column: $table.title,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get amount => $composableBuilder(
    column: $table.amount,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get currency => $composableBuilder(
    column: $table.currency,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get category => $composableBuilder(
    column: $table.category,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get splitType => $composableBuilder(
    column: $table.splitType,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get receiptImagePath => $composableBuilder(
    column: $table.receiptImagePath,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get notes => $composableBuilder(
    column: $table.notes,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get expenseDate => $composableBuilder(
    column: $table.expenseDate,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isDeleted => $composableBuilder(
    column: $table.isDeleted,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get hlcTimestamp => $composableBuilder(
    column: $table.hlcTimestamp,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$ExpensesTableAnnotationComposer
    extends Composer<_$AppDatabase, $ExpensesTable> {
  $$ExpensesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get tripId =>
      $composableBuilder(column: $table.tripId, builder: (column) => column);

  GeneratedColumn<String> get paidBy =>
      $composableBuilder(column: $table.paidBy, builder: (column) => column);

  GeneratedColumn<String> get title =>
      $composableBuilder(column: $table.title, builder: (column) => column);

  GeneratedColumn<double> get amount =>
      $composableBuilder(column: $table.amount, builder: (column) => column);

  GeneratedColumn<String> get currency =>
      $composableBuilder(column: $table.currency, builder: (column) => column);

  GeneratedColumn<String> get category =>
      $composableBuilder(column: $table.category, builder: (column) => column);

  GeneratedColumn<String> get splitType =>
      $composableBuilder(column: $table.splitType, builder: (column) => column);

  GeneratedColumn<String> get receiptImagePath => $composableBuilder(
    column: $table.receiptImagePath,
    builder: (column) => column,
  );

  GeneratedColumn<String> get notes =>
      $composableBuilder(column: $table.notes, builder: (column) => column);

  GeneratedColumn<int> get expenseDate => $composableBuilder(
    column: $table.expenseDate,
    builder: (column) => column,
  );

  GeneratedColumn<int> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<int> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  GeneratedColumn<bool> get isDeleted =>
      $composableBuilder(column: $table.isDeleted, builder: (column) => column);

  GeneratedColumn<String> get hlcTimestamp => $composableBuilder(
    column: $table.hlcTimestamp,
    builder: (column) => column,
  );
}

class $$ExpensesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $ExpensesTable,
          Expense,
          $$ExpensesTableFilterComposer,
          $$ExpensesTableOrderingComposer,
          $$ExpensesTableAnnotationComposer,
          $$ExpensesTableCreateCompanionBuilder,
          $$ExpensesTableUpdateCompanionBuilder,
          (Expense, BaseReferences<_$AppDatabase, $ExpensesTable, Expense>),
          Expense,
          PrefetchHooks Function()
        > {
  $$ExpensesTableTableManager(_$AppDatabase db, $ExpensesTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$ExpensesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$ExpensesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$ExpensesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> tripId = const Value.absent(),
                Value<String> paidBy = const Value.absent(),
                Value<String> title = const Value.absent(),
                Value<double> amount = const Value.absent(),
                Value<String> currency = const Value.absent(),
                Value<String> category = const Value.absent(),
                Value<String> splitType = const Value.absent(),
                Value<String?> receiptImagePath = const Value.absent(),
                Value<String?> notes = const Value.absent(),
                Value<int> expenseDate = const Value.absent(),
                Value<int> createdAt = const Value.absent(),
                Value<int> updatedAt = const Value.absent(),
                Value<bool> isDeleted = const Value.absent(),
                Value<String> hlcTimestamp = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => ExpensesCompanion(
                id: id,
                tripId: tripId,
                paidBy: paidBy,
                title: title,
                amount: amount,
                currency: currency,
                category: category,
                splitType: splitType,
                receiptImagePath: receiptImagePath,
                notes: notes,
                expenseDate: expenseDate,
                createdAt: createdAt,
                updatedAt: updatedAt,
                isDeleted: isDeleted,
                hlcTimestamp: hlcTimestamp,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String tripId,
                required String paidBy,
                required String title,
                required double amount,
                Value<String> currency = const Value.absent(),
                required String category,
                required String splitType,
                Value<String?> receiptImagePath = const Value.absent(),
                Value<String?> notes = const Value.absent(),
                required int expenseDate,
                required int createdAt,
                required int updatedAt,
                Value<bool> isDeleted = const Value.absent(),
                required String hlcTimestamp,
                Value<int> rowid = const Value.absent(),
              }) => ExpensesCompanion.insert(
                id: id,
                tripId: tripId,
                paidBy: paidBy,
                title: title,
                amount: amount,
                currency: currency,
                category: category,
                splitType: splitType,
                receiptImagePath: receiptImagePath,
                notes: notes,
                expenseDate: expenseDate,
                createdAt: createdAt,
                updatedAt: updatedAt,
                isDeleted: isDeleted,
                hlcTimestamp: hlcTimestamp,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$ExpensesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $ExpensesTable,
      Expense,
      $$ExpensesTableFilterComposer,
      $$ExpensesTableOrderingComposer,
      $$ExpensesTableAnnotationComposer,
      $$ExpensesTableCreateCompanionBuilder,
      $$ExpensesTableUpdateCompanionBuilder,
      (Expense, BaseReferences<_$AppDatabase, $ExpensesTable, Expense>),
      Expense,
      PrefetchHooks Function()
    >;
typedef $$ExpenseSplitsTableCreateCompanionBuilder =
    ExpenseSplitsCompanion Function({
      required String id,
      required String expenseId,
      required String userId,
      required double amount,
      Value<double?> percentage,
      Value<int?> shares,
      Value<bool> isSettled,
      required String hlcTimestamp,
      Value<int> rowid,
    });
typedef $$ExpenseSplitsTableUpdateCompanionBuilder =
    ExpenseSplitsCompanion Function({
      Value<String> id,
      Value<String> expenseId,
      Value<String> userId,
      Value<double> amount,
      Value<double?> percentage,
      Value<int?> shares,
      Value<bool> isSettled,
      Value<String> hlcTimestamp,
      Value<int> rowid,
    });

class $$ExpenseSplitsTableFilterComposer
    extends Composer<_$AppDatabase, $ExpenseSplitsTable> {
  $$ExpenseSplitsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get expenseId => $composableBuilder(
    column: $table.expenseId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get userId => $composableBuilder(
    column: $table.userId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get amount => $composableBuilder(
    column: $table.amount,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get percentage => $composableBuilder(
    column: $table.percentage,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get shares => $composableBuilder(
    column: $table.shares,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isSettled => $composableBuilder(
    column: $table.isSettled,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get hlcTimestamp => $composableBuilder(
    column: $table.hlcTimestamp,
    builder: (column) => ColumnFilters(column),
  );
}

class $$ExpenseSplitsTableOrderingComposer
    extends Composer<_$AppDatabase, $ExpenseSplitsTable> {
  $$ExpenseSplitsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get expenseId => $composableBuilder(
    column: $table.expenseId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get userId => $composableBuilder(
    column: $table.userId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get amount => $composableBuilder(
    column: $table.amount,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get percentage => $composableBuilder(
    column: $table.percentage,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get shares => $composableBuilder(
    column: $table.shares,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isSettled => $composableBuilder(
    column: $table.isSettled,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get hlcTimestamp => $composableBuilder(
    column: $table.hlcTimestamp,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$ExpenseSplitsTableAnnotationComposer
    extends Composer<_$AppDatabase, $ExpenseSplitsTable> {
  $$ExpenseSplitsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get expenseId =>
      $composableBuilder(column: $table.expenseId, builder: (column) => column);

  GeneratedColumn<String> get userId =>
      $composableBuilder(column: $table.userId, builder: (column) => column);

  GeneratedColumn<double> get amount =>
      $composableBuilder(column: $table.amount, builder: (column) => column);

  GeneratedColumn<double> get percentage => $composableBuilder(
    column: $table.percentage,
    builder: (column) => column,
  );

  GeneratedColumn<int> get shares =>
      $composableBuilder(column: $table.shares, builder: (column) => column);

  GeneratedColumn<bool> get isSettled =>
      $composableBuilder(column: $table.isSettled, builder: (column) => column);

  GeneratedColumn<String> get hlcTimestamp => $composableBuilder(
    column: $table.hlcTimestamp,
    builder: (column) => column,
  );
}

class $$ExpenseSplitsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $ExpenseSplitsTable,
          ExpenseSplit,
          $$ExpenseSplitsTableFilterComposer,
          $$ExpenseSplitsTableOrderingComposer,
          $$ExpenseSplitsTableAnnotationComposer,
          $$ExpenseSplitsTableCreateCompanionBuilder,
          $$ExpenseSplitsTableUpdateCompanionBuilder,
          (
            ExpenseSplit,
            BaseReferences<_$AppDatabase, $ExpenseSplitsTable, ExpenseSplit>,
          ),
          ExpenseSplit,
          PrefetchHooks Function()
        > {
  $$ExpenseSplitsTableTableManager(_$AppDatabase db, $ExpenseSplitsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$ExpenseSplitsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$ExpenseSplitsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$ExpenseSplitsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> expenseId = const Value.absent(),
                Value<String> userId = const Value.absent(),
                Value<double> amount = const Value.absent(),
                Value<double?> percentage = const Value.absent(),
                Value<int?> shares = const Value.absent(),
                Value<bool> isSettled = const Value.absent(),
                Value<String> hlcTimestamp = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => ExpenseSplitsCompanion(
                id: id,
                expenseId: expenseId,
                userId: userId,
                amount: amount,
                percentage: percentage,
                shares: shares,
                isSettled: isSettled,
                hlcTimestamp: hlcTimestamp,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String expenseId,
                required String userId,
                required double amount,
                Value<double?> percentage = const Value.absent(),
                Value<int?> shares = const Value.absent(),
                Value<bool> isSettled = const Value.absent(),
                required String hlcTimestamp,
                Value<int> rowid = const Value.absent(),
              }) => ExpenseSplitsCompanion.insert(
                id: id,
                expenseId: expenseId,
                userId: userId,
                amount: amount,
                percentage: percentage,
                shares: shares,
                isSettled: isSettled,
                hlcTimestamp: hlcTimestamp,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$ExpenseSplitsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $ExpenseSplitsTable,
      ExpenseSplit,
      $$ExpenseSplitsTableFilterComposer,
      $$ExpenseSplitsTableOrderingComposer,
      $$ExpenseSplitsTableAnnotationComposer,
      $$ExpenseSplitsTableCreateCompanionBuilder,
      $$ExpenseSplitsTableUpdateCompanionBuilder,
      (
        ExpenseSplit,
        BaseReferences<_$AppDatabase, $ExpenseSplitsTable, ExpenseSplit>,
      ),
      ExpenseSplit,
      PrefetchHooks Function()
    >;
typedef $$SettlementsTableCreateCompanionBuilder =
    SettlementsCompanion Function({
      required String id,
      required String tripId,
      required String payerId,
      required String payeeId,
      required double amount,
      Value<String> currency,
      required int settledAt,
      Value<String?> notes,
      Value<bool> isDeleted,
      required String hlcTimestamp,
      Value<int> rowid,
    });
typedef $$SettlementsTableUpdateCompanionBuilder =
    SettlementsCompanion Function({
      Value<String> id,
      Value<String> tripId,
      Value<String> payerId,
      Value<String> payeeId,
      Value<double> amount,
      Value<String> currency,
      Value<int> settledAt,
      Value<String?> notes,
      Value<bool> isDeleted,
      Value<String> hlcTimestamp,
      Value<int> rowid,
    });

class $$SettlementsTableFilterComposer
    extends Composer<_$AppDatabase, $SettlementsTable> {
  $$SettlementsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get tripId => $composableBuilder(
    column: $table.tripId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get payerId => $composableBuilder(
    column: $table.payerId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get payeeId => $composableBuilder(
    column: $table.payeeId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get amount => $composableBuilder(
    column: $table.amount,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get currency => $composableBuilder(
    column: $table.currency,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get settledAt => $composableBuilder(
    column: $table.settledAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get notes => $composableBuilder(
    column: $table.notes,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isDeleted => $composableBuilder(
    column: $table.isDeleted,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get hlcTimestamp => $composableBuilder(
    column: $table.hlcTimestamp,
    builder: (column) => ColumnFilters(column),
  );
}

class $$SettlementsTableOrderingComposer
    extends Composer<_$AppDatabase, $SettlementsTable> {
  $$SettlementsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get tripId => $composableBuilder(
    column: $table.tripId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get payerId => $composableBuilder(
    column: $table.payerId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get payeeId => $composableBuilder(
    column: $table.payeeId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get amount => $composableBuilder(
    column: $table.amount,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get currency => $composableBuilder(
    column: $table.currency,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get settledAt => $composableBuilder(
    column: $table.settledAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get notes => $composableBuilder(
    column: $table.notes,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isDeleted => $composableBuilder(
    column: $table.isDeleted,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get hlcTimestamp => $composableBuilder(
    column: $table.hlcTimestamp,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$SettlementsTableAnnotationComposer
    extends Composer<_$AppDatabase, $SettlementsTable> {
  $$SettlementsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get tripId =>
      $composableBuilder(column: $table.tripId, builder: (column) => column);

  GeneratedColumn<String> get payerId =>
      $composableBuilder(column: $table.payerId, builder: (column) => column);

  GeneratedColumn<String> get payeeId =>
      $composableBuilder(column: $table.payeeId, builder: (column) => column);

  GeneratedColumn<double> get amount =>
      $composableBuilder(column: $table.amount, builder: (column) => column);

  GeneratedColumn<String> get currency =>
      $composableBuilder(column: $table.currency, builder: (column) => column);

  GeneratedColumn<int> get settledAt =>
      $composableBuilder(column: $table.settledAt, builder: (column) => column);

  GeneratedColumn<String> get notes =>
      $composableBuilder(column: $table.notes, builder: (column) => column);

  GeneratedColumn<bool> get isDeleted =>
      $composableBuilder(column: $table.isDeleted, builder: (column) => column);

  GeneratedColumn<String> get hlcTimestamp => $composableBuilder(
    column: $table.hlcTimestamp,
    builder: (column) => column,
  );
}

class $$SettlementsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $SettlementsTable,
          Settlement,
          $$SettlementsTableFilterComposer,
          $$SettlementsTableOrderingComposer,
          $$SettlementsTableAnnotationComposer,
          $$SettlementsTableCreateCompanionBuilder,
          $$SettlementsTableUpdateCompanionBuilder,
          (
            Settlement,
            BaseReferences<_$AppDatabase, $SettlementsTable, Settlement>,
          ),
          Settlement,
          PrefetchHooks Function()
        > {
  $$SettlementsTableTableManager(_$AppDatabase db, $SettlementsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$SettlementsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$SettlementsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$SettlementsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> tripId = const Value.absent(),
                Value<String> payerId = const Value.absent(),
                Value<String> payeeId = const Value.absent(),
                Value<double> amount = const Value.absent(),
                Value<String> currency = const Value.absent(),
                Value<int> settledAt = const Value.absent(),
                Value<String?> notes = const Value.absent(),
                Value<bool> isDeleted = const Value.absent(),
                Value<String> hlcTimestamp = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => SettlementsCompanion(
                id: id,
                tripId: tripId,
                payerId: payerId,
                payeeId: payeeId,
                amount: amount,
                currency: currency,
                settledAt: settledAt,
                notes: notes,
                isDeleted: isDeleted,
                hlcTimestamp: hlcTimestamp,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String tripId,
                required String payerId,
                required String payeeId,
                required double amount,
                Value<String> currency = const Value.absent(),
                required int settledAt,
                Value<String?> notes = const Value.absent(),
                Value<bool> isDeleted = const Value.absent(),
                required String hlcTimestamp,
                Value<int> rowid = const Value.absent(),
              }) => SettlementsCompanion.insert(
                id: id,
                tripId: tripId,
                payerId: payerId,
                payeeId: payeeId,
                amount: amount,
                currency: currency,
                settledAt: settledAt,
                notes: notes,
                isDeleted: isDeleted,
                hlcTimestamp: hlcTimestamp,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$SettlementsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $SettlementsTable,
      Settlement,
      $$SettlementsTableFilterComposer,
      $$SettlementsTableOrderingComposer,
      $$SettlementsTableAnnotationComposer,
      $$SettlementsTableCreateCompanionBuilder,
      $$SettlementsTableUpdateCompanionBuilder,
      (
        Settlement,
        BaseReferences<_$AppDatabase, $SettlementsTable, Settlement>,
      ),
      Settlement,
      PrefetchHooks Function()
    >;
typedef $$MessagesTableCreateCompanionBuilder =
    MessagesCompanion Function({
      required String id,
      required String tripId,
      required String senderId,
      Value<String?> content,
      required String messageType,
      Value<String?> imagePath,
      Value<String?> imageThumbnailPath,
      Value<String?> replyToId,
      required int sentAt,
      Value<bool> isDeleted,
      required String hlcTimestamp,
      Value<int> rowid,
    });
typedef $$MessagesTableUpdateCompanionBuilder =
    MessagesCompanion Function({
      Value<String> id,
      Value<String> tripId,
      Value<String> senderId,
      Value<String?> content,
      Value<String> messageType,
      Value<String?> imagePath,
      Value<String?> imageThumbnailPath,
      Value<String?> replyToId,
      Value<int> sentAt,
      Value<bool> isDeleted,
      Value<String> hlcTimestamp,
      Value<int> rowid,
    });

class $$MessagesTableFilterComposer
    extends Composer<_$AppDatabase, $MessagesTable> {
  $$MessagesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get tripId => $composableBuilder(
    column: $table.tripId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get senderId => $composableBuilder(
    column: $table.senderId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get content => $composableBuilder(
    column: $table.content,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get messageType => $composableBuilder(
    column: $table.messageType,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get imagePath => $composableBuilder(
    column: $table.imagePath,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get imageThumbnailPath => $composableBuilder(
    column: $table.imageThumbnailPath,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get replyToId => $composableBuilder(
    column: $table.replyToId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get sentAt => $composableBuilder(
    column: $table.sentAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isDeleted => $composableBuilder(
    column: $table.isDeleted,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get hlcTimestamp => $composableBuilder(
    column: $table.hlcTimestamp,
    builder: (column) => ColumnFilters(column),
  );
}

class $$MessagesTableOrderingComposer
    extends Composer<_$AppDatabase, $MessagesTable> {
  $$MessagesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get tripId => $composableBuilder(
    column: $table.tripId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get senderId => $composableBuilder(
    column: $table.senderId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get content => $composableBuilder(
    column: $table.content,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get messageType => $composableBuilder(
    column: $table.messageType,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get imagePath => $composableBuilder(
    column: $table.imagePath,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get imageThumbnailPath => $composableBuilder(
    column: $table.imageThumbnailPath,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get replyToId => $composableBuilder(
    column: $table.replyToId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get sentAt => $composableBuilder(
    column: $table.sentAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isDeleted => $composableBuilder(
    column: $table.isDeleted,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get hlcTimestamp => $composableBuilder(
    column: $table.hlcTimestamp,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$MessagesTableAnnotationComposer
    extends Composer<_$AppDatabase, $MessagesTable> {
  $$MessagesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get tripId =>
      $composableBuilder(column: $table.tripId, builder: (column) => column);

  GeneratedColumn<String> get senderId =>
      $composableBuilder(column: $table.senderId, builder: (column) => column);

  GeneratedColumn<String> get content =>
      $composableBuilder(column: $table.content, builder: (column) => column);

  GeneratedColumn<String> get messageType => $composableBuilder(
    column: $table.messageType,
    builder: (column) => column,
  );

  GeneratedColumn<String> get imagePath =>
      $composableBuilder(column: $table.imagePath, builder: (column) => column);

  GeneratedColumn<String> get imageThumbnailPath => $composableBuilder(
    column: $table.imageThumbnailPath,
    builder: (column) => column,
  );

  GeneratedColumn<String> get replyToId =>
      $composableBuilder(column: $table.replyToId, builder: (column) => column);

  GeneratedColumn<int> get sentAt =>
      $composableBuilder(column: $table.sentAt, builder: (column) => column);

  GeneratedColumn<bool> get isDeleted =>
      $composableBuilder(column: $table.isDeleted, builder: (column) => column);

  GeneratedColumn<String> get hlcTimestamp => $composableBuilder(
    column: $table.hlcTimestamp,
    builder: (column) => column,
  );
}

class $$MessagesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $MessagesTable,
          Message,
          $$MessagesTableFilterComposer,
          $$MessagesTableOrderingComposer,
          $$MessagesTableAnnotationComposer,
          $$MessagesTableCreateCompanionBuilder,
          $$MessagesTableUpdateCompanionBuilder,
          (Message, BaseReferences<_$AppDatabase, $MessagesTable, Message>),
          Message,
          PrefetchHooks Function()
        > {
  $$MessagesTableTableManager(_$AppDatabase db, $MessagesTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$MessagesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$MessagesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$MessagesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> tripId = const Value.absent(),
                Value<String> senderId = const Value.absent(),
                Value<String?> content = const Value.absent(),
                Value<String> messageType = const Value.absent(),
                Value<String?> imagePath = const Value.absent(),
                Value<String?> imageThumbnailPath = const Value.absent(),
                Value<String?> replyToId = const Value.absent(),
                Value<int> sentAt = const Value.absent(),
                Value<bool> isDeleted = const Value.absent(),
                Value<String> hlcTimestamp = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => MessagesCompanion(
                id: id,
                tripId: tripId,
                senderId: senderId,
                content: content,
                messageType: messageType,
                imagePath: imagePath,
                imageThumbnailPath: imageThumbnailPath,
                replyToId: replyToId,
                sentAt: sentAt,
                isDeleted: isDeleted,
                hlcTimestamp: hlcTimestamp,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String tripId,
                required String senderId,
                Value<String?> content = const Value.absent(),
                required String messageType,
                Value<String?> imagePath = const Value.absent(),
                Value<String?> imageThumbnailPath = const Value.absent(),
                Value<String?> replyToId = const Value.absent(),
                required int sentAt,
                Value<bool> isDeleted = const Value.absent(),
                required String hlcTimestamp,
                Value<int> rowid = const Value.absent(),
              }) => MessagesCompanion.insert(
                id: id,
                tripId: tripId,
                senderId: senderId,
                content: content,
                messageType: messageType,
                imagePath: imagePath,
                imageThumbnailPath: imageThumbnailPath,
                replyToId: replyToId,
                sentAt: sentAt,
                isDeleted: isDeleted,
                hlcTimestamp: hlcTimestamp,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$MessagesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $MessagesTable,
      Message,
      $$MessagesTableFilterComposer,
      $$MessagesTableOrderingComposer,
      $$MessagesTableAnnotationComposer,
      $$MessagesTableCreateCompanionBuilder,
      $$MessagesTableUpdateCompanionBuilder,
      (Message, BaseReferences<_$AppDatabase, $MessagesTable, Message>),
      Message,
      PrefetchHooks Function()
    >;
typedef $$BudgetPoolsTableCreateCompanionBuilder =
    BudgetPoolsCompanion Function({
      required String id,
      required String tripId,
      required String name,
      required double targetAmount,
      Value<String> currency,
      required int createdAt,
      required String hlcTimestamp,
      Value<int> rowid,
    });
typedef $$BudgetPoolsTableUpdateCompanionBuilder =
    BudgetPoolsCompanion Function({
      Value<String> id,
      Value<String> tripId,
      Value<String> name,
      Value<double> targetAmount,
      Value<String> currency,
      Value<int> createdAt,
      Value<String> hlcTimestamp,
      Value<int> rowid,
    });

class $$BudgetPoolsTableFilterComposer
    extends Composer<_$AppDatabase, $BudgetPoolsTable> {
  $$BudgetPoolsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get tripId => $composableBuilder(
    column: $table.tripId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get targetAmount => $composableBuilder(
    column: $table.targetAmount,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get currency => $composableBuilder(
    column: $table.currency,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get hlcTimestamp => $composableBuilder(
    column: $table.hlcTimestamp,
    builder: (column) => ColumnFilters(column),
  );
}

class $$BudgetPoolsTableOrderingComposer
    extends Composer<_$AppDatabase, $BudgetPoolsTable> {
  $$BudgetPoolsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get tripId => $composableBuilder(
    column: $table.tripId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get targetAmount => $composableBuilder(
    column: $table.targetAmount,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get currency => $composableBuilder(
    column: $table.currency,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get hlcTimestamp => $composableBuilder(
    column: $table.hlcTimestamp,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$BudgetPoolsTableAnnotationComposer
    extends Composer<_$AppDatabase, $BudgetPoolsTable> {
  $$BudgetPoolsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get tripId =>
      $composableBuilder(column: $table.tripId, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<double> get targetAmount => $composableBuilder(
    column: $table.targetAmount,
    builder: (column) => column,
  );

  GeneratedColumn<String> get currency =>
      $composableBuilder(column: $table.currency, builder: (column) => column);

  GeneratedColumn<int> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<String> get hlcTimestamp => $composableBuilder(
    column: $table.hlcTimestamp,
    builder: (column) => column,
  );
}

class $$BudgetPoolsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $BudgetPoolsTable,
          BudgetPool,
          $$BudgetPoolsTableFilterComposer,
          $$BudgetPoolsTableOrderingComposer,
          $$BudgetPoolsTableAnnotationComposer,
          $$BudgetPoolsTableCreateCompanionBuilder,
          $$BudgetPoolsTableUpdateCompanionBuilder,
          (
            BudgetPool,
            BaseReferences<_$AppDatabase, $BudgetPoolsTable, BudgetPool>,
          ),
          BudgetPool,
          PrefetchHooks Function()
        > {
  $$BudgetPoolsTableTableManager(_$AppDatabase db, $BudgetPoolsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$BudgetPoolsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$BudgetPoolsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$BudgetPoolsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> tripId = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<double> targetAmount = const Value.absent(),
                Value<String> currency = const Value.absent(),
                Value<int> createdAt = const Value.absent(),
                Value<String> hlcTimestamp = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => BudgetPoolsCompanion(
                id: id,
                tripId: tripId,
                name: name,
                targetAmount: targetAmount,
                currency: currency,
                createdAt: createdAt,
                hlcTimestamp: hlcTimestamp,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String tripId,
                required String name,
                required double targetAmount,
                Value<String> currency = const Value.absent(),
                required int createdAt,
                required String hlcTimestamp,
                Value<int> rowid = const Value.absent(),
              }) => BudgetPoolsCompanion.insert(
                id: id,
                tripId: tripId,
                name: name,
                targetAmount: targetAmount,
                currency: currency,
                createdAt: createdAt,
                hlcTimestamp: hlcTimestamp,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$BudgetPoolsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $BudgetPoolsTable,
      BudgetPool,
      $$BudgetPoolsTableFilterComposer,
      $$BudgetPoolsTableOrderingComposer,
      $$BudgetPoolsTableAnnotationComposer,
      $$BudgetPoolsTableCreateCompanionBuilder,
      $$BudgetPoolsTableUpdateCompanionBuilder,
      (
        BudgetPool,
        BaseReferences<_$AppDatabase, $BudgetPoolsTable, BudgetPool>,
      ),
      BudgetPool,
      PrefetchHooks Function()
    >;
typedef $$BudgetContributionsTableCreateCompanionBuilder =
    BudgetContributionsCompanion Function({
      required String id,
      required String poolId,
      required String userId,
      required double amount,
      required int contributedAt,
      required String hlcTimestamp,
      Value<int> rowid,
    });
typedef $$BudgetContributionsTableUpdateCompanionBuilder =
    BudgetContributionsCompanion Function({
      Value<String> id,
      Value<String> poolId,
      Value<String> userId,
      Value<double> amount,
      Value<int> contributedAt,
      Value<String> hlcTimestamp,
      Value<int> rowid,
    });

class $$BudgetContributionsTableFilterComposer
    extends Composer<_$AppDatabase, $BudgetContributionsTable> {
  $$BudgetContributionsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get poolId => $composableBuilder(
    column: $table.poolId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get userId => $composableBuilder(
    column: $table.userId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get amount => $composableBuilder(
    column: $table.amount,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get contributedAt => $composableBuilder(
    column: $table.contributedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get hlcTimestamp => $composableBuilder(
    column: $table.hlcTimestamp,
    builder: (column) => ColumnFilters(column),
  );
}

class $$BudgetContributionsTableOrderingComposer
    extends Composer<_$AppDatabase, $BudgetContributionsTable> {
  $$BudgetContributionsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get poolId => $composableBuilder(
    column: $table.poolId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get userId => $composableBuilder(
    column: $table.userId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get amount => $composableBuilder(
    column: $table.amount,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get contributedAt => $composableBuilder(
    column: $table.contributedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get hlcTimestamp => $composableBuilder(
    column: $table.hlcTimestamp,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$BudgetContributionsTableAnnotationComposer
    extends Composer<_$AppDatabase, $BudgetContributionsTable> {
  $$BudgetContributionsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get poolId =>
      $composableBuilder(column: $table.poolId, builder: (column) => column);

  GeneratedColumn<String> get userId =>
      $composableBuilder(column: $table.userId, builder: (column) => column);

  GeneratedColumn<double> get amount =>
      $composableBuilder(column: $table.amount, builder: (column) => column);

  GeneratedColumn<int> get contributedAt => $composableBuilder(
    column: $table.contributedAt,
    builder: (column) => column,
  );

  GeneratedColumn<String> get hlcTimestamp => $composableBuilder(
    column: $table.hlcTimestamp,
    builder: (column) => column,
  );
}

class $$BudgetContributionsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $BudgetContributionsTable,
          BudgetContribution,
          $$BudgetContributionsTableFilterComposer,
          $$BudgetContributionsTableOrderingComposer,
          $$BudgetContributionsTableAnnotationComposer,
          $$BudgetContributionsTableCreateCompanionBuilder,
          $$BudgetContributionsTableUpdateCompanionBuilder,
          (
            BudgetContribution,
            BaseReferences<
              _$AppDatabase,
              $BudgetContributionsTable,
              BudgetContribution
            >,
          ),
          BudgetContribution,
          PrefetchHooks Function()
        > {
  $$BudgetContributionsTableTableManager(
    _$AppDatabase db,
    $BudgetContributionsTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$BudgetContributionsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$BudgetContributionsTableOrderingComposer(
                $db: db,
                $table: table,
              ),
          createComputedFieldComposer: () =>
              $$BudgetContributionsTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> poolId = const Value.absent(),
                Value<String> userId = const Value.absent(),
                Value<double> amount = const Value.absent(),
                Value<int> contributedAt = const Value.absent(),
                Value<String> hlcTimestamp = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => BudgetContributionsCompanion(
                id: id,
                poolId: poolId,
                userId: userId,
                amount: amount,
                contributedAt: contributedAt,
                hlcTimestamp: hlcTimestamp,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String poolId,
                required String userId,
                required double amount,
                required int contributedAt,
                required String hlcTimestamp,
                Value<int> rowid = const Value.absent(),
              }) => BudgetContributionsCompanion.insert(
                id: id,
                poolId: poolId,
                userId: userId,
                amount: amount,
                contributedAt: contributedAt,
                hlcTimestamp: hlcTimestamp,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$BudgetContributionsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $BudgetContributionsTable,
      BudgetContribution,
      $$BudgetContributionsTableFilterComposer,
      $$BudgetContributionsTableOrderingComposer,
      $$BudgetContributionsTableAnnotationComposer,
      $$BudgetContributionsTableCreateCompanionBuilder,
      $$BudgetContributionsTableUpdateCompanionBuilder,
      (
        BudgetContribution,
        BaseReferences<
          _$AppDatabase,
          $BudgetContributionsTable,
          BudgetContribution
        >,
      ),
      BudgetContribution,
      PrefetchHooks Function()
    >;
typedef $$SyncQueueTableCreateCompanionBuilder =
    SyncQueueCompanion Function({
      Value<int> id,
      required String syncTableName,
      required String recordId,
      required String operation,
      required String payload,
      required String hlcTimestamp,
      Value<bool> synced,
      required int createdAt,
    });
typedef $$SyncQueueTableUpdateCompanionBuilder =
    SyncQueueCompanion Function({
      Value<int> id,
      Value<String> syncTableName,
      Value<String> recordId,
      Value<String> operation,
      Value<String> payload,
      Value<String> hlcTimestamp,
      Value<bool> synced,
      Value<int> createdAt,
    });

class $$SyncQueueTableFilterComposer
    extends Composer<_$AppDatabase, $SyncQueueTable> {
  $$SyncQueueTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get syncTableName => $composableBuilder(
    column: $table.syncTableName,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get recordId => $composableBuilder(
    column: $table.recordId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get operation => $composableBuilder(
    column: $table.operation,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get payload => $composableBuilder(
    column: $table.payload,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get hlcTimestamp => $composableBuilder(
    column: $table.hlcTimestamp,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get synced => $composableBuilder(
    column: $table.synced,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$SyncQueueTableOrderingComposer
    extends Composer<_$AppDatabase, $SyncQueueTable> {
  $$SyncQueueTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get syncTableName => $composableBuilder(
    column: $table.syncTableName,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get recordId => $composableBuilder(
    column: $table.recordId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get operation => $composableBuilder(
    column: $table.operation,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get payload => $composableBuilder(
    column: $table.payload,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get hlcTimestamp => $composableBuilder(
    column: $table.hlcTimestamp,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get synced => $composableBuilder(
    column: $table.synced,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$SyncQueueTableAnnotationComposer
    extends Composer<_$AppDatabase, $SyncQueueTable> {
  $$SyncQueueTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get syncTableName => $composableBuilder(
    column: $table.syncTableName,
    builder: (column) => column,
  );

  GeneratedColumn<String> get recordId =>
      $composableBuilder(column: $table.recordId, builder: (column) => column);

  GeneratedColumn<String> get operation =>
      $composableBuilder(column: $table.operation, builder: (column) => column);

  GeneratedColumn<String> get payload =>
      $composableBuilder(column: $table.payload, builder: (column) => column);

  GeneratedColumn<String> get hlcTimestamp => $composableBuilder(
    column: $table.hlcTimestamp,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get synced =>
      $composableBuilder(column: $table.synced, builder: (column) => column);

  GeneratedColumn<int> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);
}

class $$SyncQueueTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $SyncQueueTable,
          SyncQueueData,
          $$SyncQueueTableFilterComposer,
          $$SyncQueueTableOrderingComposer,
          $$SyncQueueTableAnnotationComposer,
          $$SyncQueueTableCreateCompanionBuilder,
          $$SyncQueueTableUpdateCompanionBuilder,
          (
            SyncQueueData,
            BaseReferences<_$AppDatabase, $SyncQueueTable, SyncQueueData>,
          ),
          SyncQueueData,
          PrefetchHooks Function()
        > {
  $$SyncQueueTableTableManager(_$AppDatabase db, $SyncQueueTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$SyncQueueTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$SyncQueueTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$SyncQueueTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> syncTableName = const Value.absent(),
                Value<String> recordId = const Value.absent(),
                Value<String> operation = const Value.absent(),
                Value<String> payload = const Value.absent(),
                Value<String> hlcTimestamp = const Value.absent(),
                Value<bool> synced = const Value.absent(),
                Value<int> createdAt = const Value.absent(),
              }) => SyncQueueCompanion(
                id: id,
                syncTableName: syncTableName,
                recordId: recordId,
                operation: operation,
                payload: payload,
                hlcTimestamp: hlcTimestamp,
                synced: synced,
                createdAt: createdAt,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String syncTableName,
                required String recordId,
                required String operation,
                required String payload,
                required String hlcTimestamp,
                Value<bool> synced = const Value.absent(),
                required int createdAt,
              }) => SyncQueueCompanion.insert(
                id: id,
                syncTableName: syncTableName,
                recordId: recordId,
                operation: operation,
                payload: payload,
                hlcTimestamp: hlcTimestamp,
                synced: synced,
                createdAt: createdAt,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$SyncQueueTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $SyncQueueTable,
      SyncQueueData,
      $$SyncQueueTableFilterComposer,
      $$SyncQueueTableOrderingComposer,
      $$SyncQueueTableAnnotationComposer,
      $$SyncQueueTableCreateCompanionBuilder,
      $$SyncQueueTableUpdateCompanionBuilder,
      (
        SyncQueueData,
        BaseReferences<_$AppDatabase, $SyncQueueTable, SyncQueueData>,
      ),
      SyncQueueData,
      PrefetchHooks Function()
    >;
typedef $$PeerSyncStateTableCreateCompanionBuilder =
    PeerSyncStateCompanion Function({
      required String peerDeviceId,
      required String syncTableName,
      required String lastSyncedHlc,
      required int lastSyncAt,
      Value<int> rowid,
    });
typedef $$PeerSyncStateTableUpdateCompanionBuilder =
    PeerSyncStateCompanion Function({
      Value<String> peerDeviceId,
      Value<String> syncTableName,
      Value<String> lastSyncedHlc,
      Value<int> lastSyncAt,
      Value<int> rowid,
    });

class $$PeerSyncStateTableFilterComposer
    extends Composer<_$AppDatabase, $PeerSyncStateTable> {
  $$PeerSyncStateTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get peerDeviceId => $composableBuilder(
    column: $table.peerDeviceId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get syncTableName => $composableBuilder(
    column: $table.syncTableName,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get lastSyncedHlc => $composableBuilder(
    column: $table.lastSyncedHlc,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get lastSyncAt => $composableBuilder(
    column: $table.lastSyncAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$PeerSyncStateTableOrderingComposer
    extends Composer<_$AppDatabase, $PeerSyncStateTable> {
  $$PeerSyncStateTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get peerDeviceId => $composableBuilder(
    column: $table.peerDeviceId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get syncTableName => $composableBuilder(
    column: $table.syncTableName,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get lastSyncedHlc => $composableBuilder(
    column: $table.lastSyncedHlc,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get lastSyncAt => $composableBuilder(
    column: $table.lastSyncAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$PeerSyncStateTableAnnotationComposer
    extends Composer<_$AppDatabase, $PeerSyncStateTable> {
  $$PeerSyncStateTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get peerDeviceId => $composableBuilder(
    column: $table.peerDeviceId,
    builder: (column) => column,
  );

  GeneratedColumn<String> get syncTableName => $composableBuilder(
    column: $table.syncTableName,
    builder: (column) => column,
  );

  GeneratedColumn<String> get lastSyncedHlc => $composableBuilder(
    column: $table.lastSyncedHlc,
    builder: (column) => column,
  );

  GeneratedColumn<int> get lastSyncAt => $composableBuilder(
    column: $table.lastSyncAt,
    builder: (column) => column,
  );
}

class $$PeerSyncStateTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $PeerSyncStateTable,
          PeerSyncStateData,
          $$PeerSyncStateTableFilterComposer,
          $$PeerSyncStateTableOrderingComposer,
          $$PeerSyncStateTableAnnotationComposer,
          $$PeerSyncStateTableCreateCompanionBuilder,
          $$PeerSyncStateTableUpdateCompanionBuilder,
          (
            PeerSyncStateData,
            BaseReferences<
              _$AppDatabase,
              $PeerSyncStateTable,
              PeerSyncStateData
            >,
          ),
          PeerSyncStateData,
          PrefetchHooks Function()
        > {
  $$PeerSyncStateTableTableManager(_$AppDatabase db, $PeerSyncStateTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$PeerSyncStateTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$PeerSyncStateTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$PeerSyncStateTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> peerDeviceId = const Value.absent(),
                Value<String> syncTableName = const Value.absent(),
                Value<String> lastSyncedHlc = const Value.absent(),
                Value<int> lastSyncAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => PeerSyncStateCompanion(
                peerDeviceId: peerDeviceId,
                syncTableName: syncTableName,
                lastSyncedHlc: lastSyncedHlc,
                lastSyncAt: lastSyncAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String peerDeviceId,
                required String syncTableName,
                required String lastSyncedHlc,
                required int lastSyncAt,
                Value<int> rowid = const Value.absent(),
              }) => PeerSyncStateCompanion.insert(
                peerDeviceId: peerDeviceId,
                syncTableName: syncTableName,
                lastSyncedHlc: lastSyncedHlc,
                lastSyncAt: lastSyncAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$PeerSyncStateTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $PeerSyncStateTable,
      PeerSyncStateData,
      $$PeerSyncStateTableFilterComposer,
      $$PeerSyncStateTableOrderingComposer,
      $$PeerSyncStateTableAnnotationComposer,
      $$PeerSyncStateTableCreateCompanionBuilder,
      $$PeerSyncStateTableUpdateCompanionBuilder,
      (
        PeerSyncStateData,
        BaseReferences<_$AppDatabase, $PeerSyncStateTable, PeerSyncStateData>,
      ),
      PeerSyncStateData,
      PrefetchHooks Function()
    >;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$UsersTableTableManager get users =>
      $$UsersTableTableManager(_db, _db.users);
  $$TripsTableTableManager get trips =>
      $$TripsTableTableManager(_db, _db.trips);
  $$TripMembersTableTableManager get tripMembers =>
      $$TripMembersTableTableManager(_db, _db.tripMembers);
  $$ExpensesTableTableManager get expenses =>
      $$ExpensesTableTableManager(_db, _db.expenses);
  $$ExpenseSplitsTableTableManager get expenseSplits =>
      $$ExpenseSplitsTableTableManager(_db, _db.expenseSplits);
  $$SettlementsTableTableManager get settlements =>
      $$SettlementsTableTableManager(_db, _db.settlements);
  $$MessagesTableTableManager get messages =>
      $$MessagesTableTableManager(_db, _db.messages);
  $$BudgetPoolsTableTableManager get budgetPools =>
      $$BudgetPoolsTableTableManager(_db, _db.budgetPools);
  $$BudgetContributionsTableTableManager get budgetContributions =>
      $$BudgetContributionsTableTableManager(_db, _db.budgetContributions);
  $$SyncQueueTableTableManager get syncQueue =>
      $$SyncQueueTableTableManager(_db, _db.syncQueue);
  $$PeerSyncStateTableTableManager get peerSyncState =>
      $$PeerSyncStateTableTableManager(_db, _db.peerSyncState);
}
