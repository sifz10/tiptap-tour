import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

import 'package:tiptap_tour/presentation/theme/app_animations.dart';
import 'package:tiptap_tour/presentation/theme/app_colors.dart';
import 'package:tiptap_tour/presentation/theme/glass_theme.dart';

class EmptyState extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final String? actionLabel;
  final VoidCallback? onAction;

  const EmptyState({
    super.key,
    required this.icon,
    required this.title,
    required this.subtitle,
    this.actionLabel,
    this.onAction,
  });

  @override
  Widget build(BuildContext context) {
    final brightness = Theme.of(context).brightness;
    final colorScheme = Theme.of(context).colorScheme;

    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 32),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 36),
          decoration: GlassTheme.glass(
            brightness: brightness,
            radius: GlassTheme.borderRadiusLarge,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Stack(
                alignment: Alignment.center,
                children: [
                  Container(
                    width: 100,
                    height: 100,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      gradient: RadialGradient(
                        colors: [
                          AppColors.primary.withAlpha(20),
                          AppColors.primary.withAlpha(5),
                          Colors.transparent,
                        ],
                        stops: const [0.3, 0.6, 1.0],
                      ),
                    ),
                  ),
                  Container(
                    width: 72,
                    height: 72,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: AppColors.primary.withAlpha(30),
                        width: 1.5,
                      ),
                    ),
                  ),
                  Container(
                    width: 56,
                    height: 56,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          AppColors.primary.withAlpha(30),
                          AppColors.gradientEnd.withAlpha(20),
                        ],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      icon,
                      size: 28,
                      color: AppColors.primary,
                    ),
                  ),
                ],
              )
                  .animate()
                  .scale(
                    begin: const Offset(0.6, 0.6),
                    duration: AppAnimations.slow,
                    curve: AppAnimations.entrance,
                  ),
              const SizedBox(height: 24),
              Text(
                title,
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.w700,
                      letterSpacing: -0.3,
                    ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 8),
              Text(
                subtitle,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: colorScheme.onSurface.withValues(alpha: 0.5),
                      height: 1.4,
                    ),
                textAlign: TextAlign.center,
              ),
              if (actionLabel != null && onAction != null) ...[
                const SizedBox(height: 28),
                Container(
                  decoration: BoxDecoration(
                    gradient: AppColors.primaryGradient,
                    borderRadius: BorderRadius.circular(14),
                    boxShadow: [
                      BoxShadow(
                        color: AppColors.primary.withAlpha(60),
                        blurRadius: 16,
                        offset: const Offset(0, 6),
                      ),
                    ],
                  ),
                  child: Material(
                    color: Colors.transparent,
                    child: InkWell(
                      onTap: onAction,
                      borderRadius: BorderRadius.circular(14),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 28,
                          vertical: 14,
                        ),
                        child: Text(
                          actionLabel!,
                          style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w600,
                            fontSize: 14,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    )
        .animate()
        .fadeIn(
          duration: AppAnimations.slow,
          curve: AppAnimations.smooth,
        )
        .slideY(
          begin: AppAnimations.slideUpOffset,
          end: 0,
          duration: AppAnimations.slow,
          curve: AppAnimations.snappy,
        );
  }
}
