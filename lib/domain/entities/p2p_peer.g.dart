// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'p2p_peer.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$P2PPeerImpl _$$P2PPeerImplFromJson(Map<String, dynamic> json) =>
    _$P2PPeerImpl(
      deviceId: json['deviceId'] as String,
      displayName: json['displayName'] as String,
      platform: json['platform'] as String?,
      lastSeen: DateTime.parse(json['lastSeen'] as String),
      isConnected: json['isConnected'] as bool? ?? false,
    );

Map<String, dynamic> _$$P2PPeerImplToJson(_$P2PPeerImpl instance) =>
    <String, dynamic>{
      'deviceId': instance.deviceId,
      'displayName': instance.displayName,
      'platform': instance.platform,
      'lastSeen': instance.lastSeen.toIso8601String(),
      'isConnected': instance.isConnected,
    };
