import 'package:tiptap_tour/domain/entities/expense.dart';
import 'package:tiptap_tour/domain/entities/expense_split.dart';

abstract interface class ExpenseRepository {
  Future<List<Expense>> getExpensesByTrip(String tripId);
  Future<Expense?> getExpenseById(String id);
  Future<void> createExpense(Expense expense, List<ExpenseSplit> splits);
  Future<void> updateExpense(Expense expense, List<ExpenseSplit> splits);
  Future<void> deleteExpense(String id);
  Future<Map<String, double>> getBalancesByTrip(String tripId);
  Stream<List<Expense>> watchExpensesByTrip(String tripId);
}
