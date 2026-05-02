import 'package:flutter/material.dart';

import 'package:tiptap_tour/core/constants/category_constants.dart';
import 'package:tiptap_tour/presentation/theme/app_animations.dart';

class CategoryChip extends StatelessWidget {
  final ExpenseCategory category;
  final bool isSelected;
  final VoidCallback? onTap;

  const CategoryChip({
    super.key,
    required this.category,
    this.isSelected = false,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final categoryColor = category.color;
    final bgColor = isSelected
        ? categoryColor
        : categoryColor.withAlpha(25);
    final fgColor = isSelected
        ? Colors.white
        : categoryColor;

    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: AppAnimations.fast,
        curve: AppAnimations.snappy,
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        decoration: BoxDecoration(
          color: bgColor,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: isSelected
                ? categoryColor
                : categoryColor.withAlpha(51),
            width: 1,
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              category.icon,
              size: 16,
              color: fgColor,
            ),
            const SizedBox(width: 6),
            AnimatedDefaultTextStyle(
              duration: AppAnimations.fast,
              style: TextStyle(
                color: fgColor,
                fontSize: 13,
                fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
              ),
              child: Text(category.displayName),
            ),
          ],
        ),
      ),
    );
  }
}
