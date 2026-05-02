import 'dart:ui';

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tiptap_tour/application/providers/summary_providers.dart';
import 'package:tiptap_tour/core/constants/category_constants.dart';
import 'package:tiptap_tour/core/utils/currency_formatter.dart';
import 'package:tiptap_tour/presentation/theme/app_animations.dart';
import 'package:tiptap_tour/presentation/theme/app_colors.dart';
import 'package:tiptap_tour/presentation/theme/glass_theme.dart';
import 'package:tiptap_tour/presentation/widgets/empty_state.dart';
import 'package:tiptap_tour/presentation/widgets/error_state.dart';

class SummaryScreen extends ConsumerWidget {
  const SummaryScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final summaryAsync = ref.watch(summaryDataProvider);
    final brightness = Theme.of(context).brightness;

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          _buildAppBar(context, brightness),
          SliverPadding(
            padding: const EdgeInsets.fromLTRB(16, 8, 16, 100),
            sliver: summaryAsync.when(
              data: (data) {
                if (data.expenseCount == 0) {
                  return const SliverFillRemaining(
                    child: EmptyState(
                      icon: Icons.insights_rounded,
                      title: 'No Data Yet',
                      subtitle:
                          'Add expenses to your trips\nto see spending analytics',
                    ),
                  );
                }
                return SliverList.list(
                  children: [
                    _OverviewCards(data: data)
                        .animate()
                        .fadeIn(duration: AppAnimations.normal)
                        .slideY(
                          begin: 0.05,
                          duration: AppAnimations.normal,
                          curve: AppAnimations.springLike,
                        ),
                    const SizedBox(height: 20),
                    _CategoryChart(data: data)
                        .animate()
                        .fadeIn(
                          duration: AppAnimations.normal,
                          delay: AppAnimations.staggerFor(1),
                        )
                        .slideY(
                          begin: 0.05,
                          duration: AppAnimations.normal,
                          delay: AppAnimations.staggerFor(1),
                          curve: AppAnimations.springLike,
                        ),
                    const SizedBox(height: 20),
                    _TripBreakdown(data: data)
                        .animate()
                        .fadeIn(
                          duration: AppAnimations.normal,
                          delay: AppAnimations.staggerFor(2),
                        )
                        .slideY(
                          begin: 0.05,
                          duration: AppAnimations.normal,
                          delay: AppAnimations.staggerFor(2),
                          curve: AppAnimations.springLike,
                        ),
                  ],
                );
              },
              loading: () => const SliverFillRemaining(
                child: Center(child: CircularProgressIndicator()),
              ),
              error: (e, _) => SliverFillRemaining(
                child: ErrorState(
                  message: e.toString(),
                  onRetry: () => ref.invalidate(summaryDataProvider),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  SliverAppBar _buildAppBar(BuildContext context, Brightness brightness) {
    return SliverAppBar(
      title: Row(
        children: [
          Container(
            width: 36,
            height: 36,
            decoration: BoxDecoration(
              color: AppColors.info.withAlpha(25),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(
              Icons.insights_rounded,
              color: AppColors.info,
              size: 18,
            ),
          ),
          const SizedBox(width: 12),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Summary',
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
              ),
              Text(
                'Spending analytics',
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: Theme.of(context)
                          .colorScheme
                          .onSurface
                          .withValues(alpha: 0.6),
                      fontSize: 11,
                    ),
              ),
            ],
          ),
        ],
      ),
      pinned: true,
      backgroundColor: Theme.of(context).scaffoldBackgroundColor.withAlpha(230),
      flexibleSpace: ClipRect(
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 12, sigmaY: 12),
          child: Container(color: Colors.transparent),
        ),
      ),
    );
  }
}

class _OverviewCards extends StatelessWidget {
  final SummaryData data;

  const _OverviewCards({required this.data});

  @override
  Widget build(BuildContext context) {
    final brightness = Theme.of(context).brightness;

    return Row(
      children: [
        Expanded(
          child: _StatCard(
            icon: Icons.account_balance_wallet_rounded,
            label: 'Total Spent',
            value: CurrencyFormatter.format(data.totalSpent),
            color: AppColors.primary,
            brightness: brightness,
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: _StatCard(
            icon: Icons.receipt_long_rounded,
            label: 'Expenses',
            value: data.expenseCount.toString(),
            color: AppColors.secondary,
            brightness: brightness,
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: _StatCard(
            icon: Icons.flight_takeoff_rounded,
            label: 'Trips',
            value: data.tripCount.toString(),
            color: AppColors.info,
            brightness: brightness,
          ),
        ),
      ],
    );
  }
}

class _StatCard extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;
  final Color color;
  final Brightness brightness;

  const _StatCard({
    required this.icon,
    required this.label,
    required this.value,
    required this.color,
    required this.brightness,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: GlassTheme.glass(
        brightness: brightness,
        radius: GlassTheme.borderRadiusSmall,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 36,
            height: 36,
            decoration: BoxDecoration(
              color: color.withAlpha(25),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(icon, color: color, size: 18),
          ),
          const SizedBox(height: 10),
          Text(
            value,
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.w700,
                ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(height: 2),
          Text(
            label,
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: Theme.of(context)
                      .colorScheme
                      .onSurface
                      .withValues(alpha: 0.5),
                ),
          ),
        ],
      ),
    );
  }
}

class _CategoryChart extends StatelessWidget {
  final SummaryData data;

  const _CategoryChart({required this.data});

  @override
  Widget build(BuildContext context) {
    final brightness = Theme.of(context).brightness;
    final sorted = data.categoryTotals.entries.toList()
      ..sort((a, b) => b.value.compareTo(a.value));

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: GlassTheme.glass(brightness: brightness),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'By Category',
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.w600,
                ),
          ),
          const SizedBox(height: 20),
          SizedBox(
            height: 180,
            child: Row(
              children: [
                Expanded(
                  child: PieChart(
                    PieChartData(
                      sectionsSpace: 2,
                      centerSpaceRadius: 36,
                      sections: sorted.map((entry) {
                        final category = ExpenseCategory.values.firstWhere(
                          (c) => c.name == entry.key,
                          orElse: () => ExpenseCategory.other,
                        );
                        final pct = (entry.value / data.totalSpent) * 100;
                        return PieChartSectionData(
                          value: entry.value,
                          color: category.color,
                          radius: 48,
                          title: '${pct.round()}%',
                          titleStyle: const TextStyle(
                            fontSize: 11,
                            fontWeight: FontWeight.w600,
                            color: Colors.white,
                          ),
                        );
                      }).toList(),
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: sorted.take(6).map((entry) {
                      final category = ExpenseCategory.values.firstWhere(
                        (c) => c.name == entry.key,
                        orElse: () => ExpenseCategory.other,
                      );
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 8),
                        child: Row(
                          children: [
                            Container(
                              width: 10,
                              height: 10,
                              decoration: BoxDecoration(
                                color: category.color,
                                borderRadius: BorderRadius.circular(3),
                              ),
                            ),
                            const SizedBox(width: 8),
                            Expanded(
                              child: Text(
                                category.displayName,
                                style: Theme.of(context)
                                    .textTheme
                                    .bodySmall
                                    ?.copyWith(fontWeight: FontWeight.w500),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ],
                        ),
                      );
                    }).toList(),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _TripBreakdown extends StatelessWidget {
  final SummaryData data;

  const _TripBreakdown({required this.data});

  @override
  Widget build(BuildContext context) {
    final brightness = Theme.of(context).brightness;
    final sorted = data.tripTotals.entries.toList()
      ..sort((a, b) => b.value.compareTo(a.value));

    if (sorted.isEmpty) return const SizedBox.shrink();

    final maxAmount = sorted.first.value;

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: GlassTheme.glass(brightness: brightness),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'By Trip',
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.w600,
                ),
          ),
          const SizedBox(height: 16),
          ...sorted.map((entry) {
            final tripName =
                data.tripNames[entry.key] ?? 'Unknown Trip';
            final barWidth =
                maxAmount > 0 ? (entry.value / maxAmount) : 0.0;

            return Padding(
              padding: const EdgeInsets.only(bottom: 14),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                          tripName,
                          style: Theme.of(context)
                              .textTheme
                              .bodyMedium
                              ?.copyWith(fontWeight: FontWeight.w600),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      Text(
                        CurrencyFormatter.format(entry.value),
                        style:
                            Theme.of(context).textTheme.bodyMedium?.copyWith(
                                  fontWeight: FontWeight.w700,
                                  color: AppColors.primary,
                                ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 6),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(4),
                    child: LinearProgressIndicator(
                      value: barWidth.clamp(0.0, 1.0),
                      backgroundColor: AppColors.primary.withAlpha(20),
                      valueColor:
                          const AlwaysStoppedAnimation(AppColors.primary),
                      minHeight: 6,
                    ),
                  ),
                ],
              ),
            );
          }),
        ],
      ),
    );
  }
}
