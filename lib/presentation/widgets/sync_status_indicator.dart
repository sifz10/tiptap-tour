import 'package:flutter/material.dart';

import 'package:tiptap_tour/presentation/theme/app_animations.dart';
import 'package:tiptap_tour/presentation/theme/app_colors.dart';

class SyncStatusIndicator extends StatelessWidget {
  final bool isSynced;
  final int pendingCount;

  const SyncStatusIndicator({
    super.key,
    required this.isSynced,
    this.pendingCount = 0,
  });

  @override
  Widget build(BuildContext context) {
    final color = isSynced ? AppColors.success : AppColors.warning;
    final label = isSynced
        ? 'All synced'
        : '$pendingCount change${pendingCount == 1 ? '' : 's'} pending';

    return Tooltip(
      message: label,
      child: AnimatedContainer(
        duration: AppAnimations.normal,
        curve: AppAnimations.snappy,
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        decoration: BoxDecoration(
          color: color.withAlpha(25),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            AnimatedContainer(
              duration: AppAnimations.normal,
              width: 8,
              height: 8,
              decoration: BoxDecoration(
                color: color,
                shape: BoxShape.circle,
              ),
            ),
            if (!isSynced && pendingCount > 0) ...[
              const SizedBox(width: 4),
              Text(
                '$pendingCount',
                style: TextStyle(
                  color: color,
                  fontSize: 11,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
