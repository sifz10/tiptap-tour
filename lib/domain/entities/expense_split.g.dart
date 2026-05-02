// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'expense_split.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ExpenseSplitImpl _$$ExpenseSplitImplFromJson(Map<String, dynamic> json) =>
    _$ExpenseSplitImpl(
      id: json['id'] as String,
      expenseId: json['expenseId'] as String,
      userId: json['userId'] as String,
      amount: (json['amount'] as num).toDouble(),
      percentage: (json['percentage'] as num?)?.toDouble(),
      shares: (json['shares'] as num?)?.toInt(),
      isSettled: json['isSettled'] as bool? ?? false,
      hlcTimestamp: json['hlcTimestamp'] as String,
    );

Map<String, dynamic> _$$ExpenseSplitImplToJson(_$ExpenseSplitImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'expenseId': instance.expenseId,
      'userId': instance.userId,
      'amount': instance.amount,
      'percentage': instance.percentage,
      'shares': instance.shares,
      'isSettled': instance.isSettled,
      'hlcTimestamp': instance.hlcTimestamp,
    };
