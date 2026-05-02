// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$AppUserImpl _$$AppUserImplFromJson(Map<String, dynamic> json) =>
    _$AppUserImpl(
      id: json['id'] as String,
      displayName: json['displayName'] as String,
      avatarPath: json['avatarPath'] as String?,
      deviceId: json['deviceId'] as String,
      phoneNumber: json['phoneNumber'] as String?,
      createdAt: DateTime.parse(json['createdAt'] as String),
      hlcTimestamp: json['hlcTimestamp'] as String,
    );

Map<String, dynamic> _$$AppUserImplToJson(_$AppUserImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'displayName': instance.displayName,
      'avatarPath': instance.avatarPath,
      'deviceId': instance.deviceId,
      'phoneNumber': instance.phoneNumber,
      'createdAt': instance.createdAt.toIso8601String(),
      'hlcTimestamp': instance.hlcTimestamp,
    };
