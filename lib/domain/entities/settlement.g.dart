// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'settlement.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$SettlementImpl _$$SettlementImplFromJson(Map<String, dynamic> json) =>
    _$SettlementImpl(
      id: json['id'] as String,
      tripId: json['tripId'] as String,
      payerId: json['payerId'] as String,
      payeeId: json['payeeId'] as String,
      amount: (json['amount'] as num).toDouble(),
      currency: json['currency'] as String? ?? 'BDT',
      settledAt: DateTime.parse(json['settledAt'] as String),
      notes: json['notes'] as String?,
      isDeleted: json['isDeleted'] as bool? ?? false,
      hlcTimestamp: json['hlcTimestamp'] as String,
    );

Map<String, dynamic> _$$SettlementImplToJson(_$SettlementImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'tripId': instance.tripId,
      'payerId': instance.payerId,
      'payeeId': instance.payeeId,
      'amount': instance.amount,
      'currency': instance.currency,
      'settledAt': instance.settledAt.toIso8601String(),
      'notes': instance.notes,
      'isDeleted': instance.isDeleted,
      'hlcTimestamp': instance.hlcTimestamp,
    };
