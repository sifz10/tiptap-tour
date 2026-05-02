import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tiptap_tour/application/providers/database_provider.dart';

class SummaryData {
  final double totalSpent;
  final int expenseCount;
  final int tripCount;
  final Map<String, double> categoryTotals;
  final Map<String, double> tripTotals;
  final Map<String, String> tripNames;

  const SummaryData({
    required this.totalSpent,
    required this.expenseCount,
    required this.tripCount,
    required this.categoryTotals,
    required this.tripTotals,
    required this.tripNames,
  });
}

final summaryDataProvider = FutureProvider<SummaryData>((ref) async {
  final db = ref.watch(databaseProvider);

  final expenses = await db.expenseDao.getAllExpenses();
  final trips = await db.tripDao.getActiveTrips();

  double totalSpent = 0;
  final categoryTotals = <String, double>{};
  final tripTotals = <String, double>{};

  for (final expense in expenses) {
    totalSpent += expense.amount;
    categoryTotals[expense.category] =
        (categoryTotals[expense.category] ?? 0) + expense.amount;
    tripTotals[expense.tripId] =
        (tripTotals[expense.tripId] ?? 0) + expense.amount;
  }

  final tripNames = <String, String>{};
  for (final trip in trips) {
    tripNames[trip.id] = trip.name;
  }

  return SummaryData(
    totalSpent: totalSpent,
    expenseCount: expenses.length,
    tripCount: trips.length,
    categoryTotals: categoryTotals,
    tripTotals: tripTotals,
    tripNames: tripNames,
  );
});
