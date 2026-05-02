import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:tiptap_tour/domain/enums/split_type.dart';

part 'expense.freezed.dart';
part 'expense.g.dart';

@freezed
class Expense with _$Expense {
  const factory Expense({
    required String id,
    required String tripId,
    required String paidBy,
    required String title,
    required double amount,
    @Default('BDT') String currency,
    required String category,
    required SplitType splitType,
    String? receiptImagePath,
    String? notes,
    required DateTime expenseDate,
    required DateTime createdAt,
    required DateTime updatedAt,
    @Default(false) bool isDeleted,
    required String hlcTimestamp,
  }) = _Expense;

  factory Expense.fromJson(Map<String, dynamic> json) => _$ExpenseFromJson(json);
}
