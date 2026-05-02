import 'package:flutter/material.dart';

import 'package:tiptap_tour/core/utils/currency_formatter.dart';
import 'package:tiptap_tour/presentation/theme/app_animations.dart';
import 'package:tiptap_tour/presentation/theme/app_colors.dart';
import 'package:tiptap_tour/presentation/theme/app_typography.dart';

class AnimatedAmountDisplay extends StatelessWidget {
  final double amount;
  final String currency;
  final TextStyle? style;
  final bool showSign;

  const AnimatedAmountDisplay({
    super.key,
    required this.amount,
    this.currency = 'BDT',
    this.style,
    this.showSign = false,
  });

  Color _colorForAmount(BuildContext context) {
    if (amount > 0) return AppColors.success;
    if (amount < 0) return AppColors.error;
    return Theme.of(context).colorScheme.primary;
  }

  String _formattedText() {
    final formatted = CurrencyFormatter.format(amount.abs(), currency: currency);
    if (!showSign || amount == 0) return formatted;
    return amount > 0 ? '+$formatted' : '-$formatted';
  }

  @override
  Widget build(BuildContext context) {
    final color = _colorForAmount(context);
    final effectiveStyle = style ?? AppTypography.currencyDisplay(color: color);

    return AnimatedSwitcher(
      duration: AppAnimations.normal,
      switchInCurve: AppAnimations.snappy,
      switchOutCurve: AppAnimations.smooth,
      transitionBuilder: (child, animation) {
        return FadeTransition(
          opacity: animation,
          child: SlideTransition(
            position: Tween<Offset>(
              begin: const Offset(0, 0.2),
              end: Offset.zero,
            ).animate(animation),
            child: child,
          ),
        );
      },
      child: Text(
        _formattedText(),
        key: ValueKey(amount),
        style: effectiveStyle.copyWith(color: color),
      ),
    );
  }
}
