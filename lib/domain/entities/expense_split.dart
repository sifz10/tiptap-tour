import 'package:freezed_annotation/freezed_annotation.dart';

part 'expense_split.freezed.dart';
part 'expense_split.g.dart';

@freezed
class ExpenseSplit with _$ExpenseSplit {
  const factory ExpenseSplit({
    required String id,
    required String expenseId,
    required String userId,
    required double amount,
    double? percentage,
    int? shares,
    @Default(false) bool isSettled,
    required String hlcTimestamp,
  }) = _ExpenseSplit;

  factory ExpenseSplit.fromJson(Map<String, dynamic> json) => _$ExpenseSplitFromJson(json);
}
