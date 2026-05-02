import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

import 'package:tiptap_tour/core/utils/currency_formatter.dart';
import 'package:tiptap_tour/presentation/theme/app_animations.dart';
import 'package:tiptap_tour/presentation/theme/app_colors.dart';

class BalanceBar extends StatelessWidget {
  final String userName;
  final double amount;
  final double maxAmount;
  final String currency;

  const BalanceBar({
    super.key,
    required this.userName,
    required this.amount,
    required this.maxAmount,
    this.currency = 'BDT',
  });

  @override
  Widget build(BuildContext context) {
    final isPositive = amount >= 0;
    final barColor = isPositive ? AppColors.success : AppColors.error;
    final surfaceColor = barColor.withAlpha(25);
    final fraction = maxAmount > 0 ? (amount.abs() / maxAmount).clamp(0.0, 1.0) : 0.0;
    final textTheme = Theme.of(context).textTheme;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                userName,
                style: textTheme.bodyMedium?.copyWith(
                  fontWeight: FontWeight.w500,
                ),
              ),
              Text(
                '${isPositive ? '+' : '-'}${CurrencyFormatter.format(amount.abs(), currency: currency)}',
                style: textTheme.bodyMedium?.copyWith(
                  color: barColor,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          const SizedBox(height: 6),
          Container(
            height: 8,
            decoration: BoxDecoration(
              color: surfaceColor,
              borderRadius: BorderRadius.circular(4),
            ),
            child: Align(
              alignment: Alignment.centerLeft,
              child: FractionallySizedBox(
                widthFactor: fraction,
                child: Container(
                  decoration: BoxDecoration(
                    color: barColor,
                    borderRadius: BorderRadius.circular(4),
                  ),
                ),
              )
                  .animate()
                  .scaleX(
                    begin: 0,
                    end: 1,
                    duration: AppAnimations.slow,
                    curve: AppAnimations.snappy,
                    alignment: Alignment.centerLeft,
                  ),
            ),
          ),
        ],
      ),
    );
  }
}
