// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'expense.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ExpenseImpl _$$ExpenseImplFromJson(Map<String, dynamic> json) =>
    _$ExpenseImpl(
      id: json['id'] as String,
      tripId: json['tripId'] as String,
      paidBy: json['paidBy'] as String,
      title: json['title'] as String,
      amount: (json['amount'] as num).toDouble(),
      currency: json['currency'] as String? ?? 'BDT',
      category: json['category'] as String,
      splitType: $enumDecode(_$SplitTypeEnumMap, json['splitType']),
      receiptImagePath: json['receiptImagePath'] as String?,
      notes: json['notes'] as String?,
      expenseDate: DateTime.parse(json['expenseDate'] as String),
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
      isDeleted: json['isDeleted'] as bool? ?? false,
      hlcTimestamp: json['hlcTimestamp'] as String,
    );

Map<String, dynamic> _$$ExpenseImplToJson(_$ExpenseImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'tripId': instance.tripId,
      'paidBy': instance.paidBy,
      'title': instance.title,
      'amount': instance.amount,
      'currency': instance.currency,
      'category': instance.category,
      'splitType': _$SplitTypeEnumMap[instance.splitType]!,
      'receiptImagePath': instance.receiptImagePath,
      'notes': instance.notes,
      'expenseDate': instance.expenseDate.toIso8601String(),
      'createdAt': instance.createdAt.toIso8601String(),
      'updatedAt': instance.updatedAt.toIso8601String(),
      'isDeleted': instance.isDeleted,
      'hlcTimestamp': instance.hlcTimestamp,
    };

const _$SplitTypeEnumMap = {
  SplitType.equal: 'equal',
  SplitType.exact: 'exact',
  SplitType.percentage: 'percentage',
  SplitType.shares: 'shares',
};
