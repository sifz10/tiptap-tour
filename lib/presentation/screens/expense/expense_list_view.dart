import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tiptap_tour/application/providers/expense_providers.dart';
import 'package:tiptap_tour/core/constants/category_constants.dart';
import 'package:tiptap_tour/core/utils/currency_formatter.dart';
import 'package:tiptap_tour/presentation/theme/app_animations.dart';
import 'package:tiptap_tour/presentation/theme/glass_theme.dart';
import 'package:tiptap_tour/presentation/screens/expense/add_expense_sheet.dart';
import 'package:tiptap_tour/presentation/widgets/empty_state.dart';

class ExpenseListView extends ConsumerWidget {
  final String tripId;
  final String currency;

  const ExpenseListView({
    super.key,
    required this.tripId,
    required this.currency,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final expensesAsync = ref.watch(expensesByTripProvider(tripId));

    return Stack(
      children: [
        expensesAsync.when(
          data: (expenses) {
            if (expenses.isEmpty) {
              return EmptyState(
                icon: Icons.receipt_long_rounded,
                title: 'No expenses yet',
                subtitle: 'Tap + to add your first expense',
                actionLabel: 'Add Expense',
                onAction: () => _showAddExpense(context),
              );
            }
            return ListView.builder(
              padding: const EdgeInsets.fromLTRB(16, 12, 16, 100),
              itemCount: expenses.length,
              itemBuilder: (context, index) {
                final expense = expenses[index];
                final category = ExpenseCategory.values.firstWhere(
                  (c) => c.name == expense.category,
                  orElse: () => ExpenseCategory.other,
                );

                return Padding(
                  padding: const EdgeInsets.only(bottom: 10),
                  child: _ExpenseCard(
                    title: expense.title,
                    amount: expense.amount,
                    currency: expense.currency,
                    category: category,
                    date: DateTime.fromMillisecondsSinceEpoch(
                        expense.expenseDate),
                    notes: expense.notes,
                    onTap: () {},
                  )
                      .animate()
                      .fadeIn(
                        duration: AppAnimations.normal,
                        delay: AppAnimations.staggerFor(index),
                      )
                      .slideX(
                        begin: 0.03,
                        duration: AppAnimations.normal,
                        delay: AppAnimations.staggerFor(index),
                        curve: AppAnimations.springLike,
                      ),
                );
              },
            );
          },
          loading: () => const Center(child: CircularProgressIndicator()),
          error: (error, _) => Center(child: Text('Error: $error')),
        ),
        Positioned(
          bottom: 24,
          right: 16,
          child: FloatingActionButton.extended(
            heroTag: 'add_expense',
            onPressed: () => _showAddExpense(context),
            icon: const Icon(Icons.add_rounded),
            label: const Text('Add Expense'),
          ),
        ),
      ],
    );
  }

  void _showAddExpense(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      useSafeArea: true,
      backgroundColor: Colors.transparent,
      builder: (_) => AddExpenseSheet(tripId: tripId, currency: currency),
    );
  }
}

class _ExpenseCard extends StatelessWidget {
  final String title;
  final double amount;
  final String currency;
  final ExpenseCategory category;
  final DateTime date;
  final String? notes;
  final VoidCallback? onTap;

  const _ExpenseCard({
    required this.title,
    required this.amount,
    required this.currency,
    required this.category,
    required this.date,
    this.notes,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final brightness = Theme.of(context).brightness;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: GlassTheme.glass(
          brightness: brightness,
          radius: GlassTheme.borderRadiusSmall,
        ),
        padding: const EdgeInsets.all(14),
        child: Row(
          children: [
            Container(
              width: 44,
              height: 44,
              decoration: BoxDecoration(
                color: category.color.withValues(alpha: 0.12),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(
                category.icon,
                color: category.color,
                size: 22,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: Theme.of(context).textTheme.titleSmall?.copyWith(
                          fontWeight: FontWeight.w600,
                        ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 2),
                  Text(
                    category.displayName,
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: Theme.of(context)
                              .colorScheme
                              .onSurface
                              .withValues(alpha: 0.5),
                        ),
                  ),
                ],
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  CurrencyFormatter.format(amount, currency: currency),
                  style: Theme.of(context).textTheme.titleSmall?.copyWith(
                        fontWeight: FontWeight.w700,
                        color: Theme.of(context).colorScheme.primary,
                      ),
                ),
                const SizedBox(height: 2),
                Text(
                  _relativeDate(date),
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: Theme.of(context)
                            .colorScheme
                            .onSurface
                            .withValues(alpha: 0.4),
                        fontSize: 11,
                      ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  String _relativeDate(DateTime d) {
    final now = DateTime.now();
    final diff = now.difference(d);
    if (diff.inDays == 0) return 'Today';
    if (diff.inDays == 1) return 'Yesterday';
    if (diff.inDays < 7) return '${diff.inDays}d ago';
    final months = [
      'Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun',
      'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'
    ];
    return '${months[d.month - 1]} ${d.day}';
  }
}
