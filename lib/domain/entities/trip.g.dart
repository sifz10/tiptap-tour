// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'trip.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$TripImpl _$$TripImplFromJson(Map<String, dynamic> json) => _$TripImpl(
  id: json['id'] as String,
  name: json['name'] as String,
  description: json['description'] as String?,
  coverImagePath: json['coverImagePath'] as String?,
  baseCurrency: json['baseCurrency'] as String? ?? 'BDT',
  createdBy: json['createdBy'] as String,
  startDate: json['startDate'] == null
      ? null
      : DateTime.parse(json['startDate'] as String),
  endDate: json['endDate'] == null
      ? null
      : DateTime.parse(json['endDate'] as String),
  isArchived: json['isArchived'] as bool? ?? false,
  createdAt: DateTime.parse(json['createdAt'] as String),
  updatedAt: DateTime.parse(json['updatedAt'] as String),
  hlcTimestamp: json['hlcTimestamp'] as String,
);

Map<String, dynamic> _$$TripImplToJson(_$TripImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'description': instance.description,
      'coverImagePath': instance.coverImagePath,
      'baseCurrency': instance.baseCurrency,
      'createdBy': instance.createdBy,
      'startDate': instance.startDate?.toIso8601String(),
      'endDate': instance.endDate?.toIso8601String(),
      'isArchived': instance.isArchived,
      'createdAt': instance.createdAt.toIso8601String(),
      'updatedAt': instance.updatedAt.toIso8601String(),
      'hlcTimestamp': instance.hlcTimestamp,
    };
