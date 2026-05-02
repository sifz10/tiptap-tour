import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'package:tiptap_tour/core/constants/category_constants.dart';
import 'package:tiptap_tour/core/utils/currency_formatter.dart';
import 'package:tiptap_tour/presentation/widgets/glass_card.dart';

class ExpenseTile extends StatelessWidget {
  final String title;
  final double amount;
  final String paidByName;
  final ExpenseCategory category;
  final DateTime date;
  final String currency;
  final VoidCallback? onTap;

  const ExpenseTile({
    super.key,
    required this.title,
    required this.amount,
    required this.paidByName,
    required this.category,
    required this.date,
    this.currency = 'BDT',
    this.onTap,
  });

  String _relativeDate() {
    final now = DateTime.now();
    final diff = now.difference(date);

    if (diff.inDays == 0) return 'Today';
    if (diff.inDays == 1) return 'Yesterday';
    if (diff.inDays < 7) return '${diff.inDays}d ago';
    return DateFormat('MMM d').format(date);
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final categoryColor = category.color;

    return GlassCard(
      onTap: onTap,
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
      child: Row(
        children: [
          Container(
            width: 44,
            height: 44,
            decoration: BoxDecoration(
              color: categoryColor.withAlpha(25),
              shape: BoxShape.circle,
            ),
            child: Icon(
              category.icon,
              color: categoryColor,
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
                  style: textTheme.titleSmall,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 2),
                Text(
                  'Paid by $paidByName',
                  style: textTheme.bodySmall,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
          const SizedBox(width: 8),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                CurrencyFormatter.format(amount, currency: currency),
                style: textTheme.titleSmall?.copyWith(
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(height: 2),
              Text(
                _relativeDate(),
                style: textTheme.bodySmall?.copyWith(fontSize: 11),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
