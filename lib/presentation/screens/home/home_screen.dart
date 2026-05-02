import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:tiptap_tour/application/providers/trip_providers.dart';
import 'package:tiptap_tour/presentation/theme/app_colors.dart';
import 'package:tiptap_tour/presentation/theme/app_animations.dart';
import 'package:tiptap_tour/presentation/theme/glass_theme.dart';
import 'package:tiptap_tour/presentation/screens/home/create_trip_sheet.dart';
import 'package:tiptap_tour/presentation/widgets/empty_state.dart';
import 'package:tiptap_tour/presentation/widgets/error_state.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final tripsAsync = ref.watch(tripsProvider);
    final brightness = Theme.of(context).brightness;

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          _buildAppBar(context, brightness),
          SliverPadding(
            padding: const EdgeInsets.fromLTRB(16, 8, 16, 100),
            sliver: tripsAsync.when(
              data: (trips) {
                if (trips.isEmpty) {
                  return SliverFillRemaining(
                    child: EmptyState(
                      icon: Icons.flight_takeoff_rounded,
                      title: 'No trips yet',
                      subtitle: 'Start a new trip and add your friends!',
                      actionLabel: 'Create Trip',
                      onAction: () => _showCreateTrip(context),
                    ),
                  );
                }
                return SliverList.builder(
                  itemCount: trips.length,
                  itemBuilder: (context, index) {
                    final trip = trips[index];
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 12),
                      child: _TripCard(
                        name: trip.name,
                        description: trip.description,
                        currency: trip.baseCurrency,
                        isArchived: trip.isArchived,
                        startDate: trip.startDate != null
                            ? DateTime.fromMillisecondsSinceEpoch(
                                trip.startDate!)
                            : null,
                        onTap: () => context.go('/trip/${trip.id}'),
                      )
                          .animate()
                          .fadeIn(
                            duration: AppAnimations.normal,
                            delay: AppAnimations.staggerFor(index),
                          )
                          .slideY(
                            begin: 0.05,
                            duration: AppAnimations.normal,
                            delay: AppAnimations.staggerFor(index),
                            curve: AppAnimations.springLike,
                          ),
                    );
                  },
                );
              },
              loading: () => const SliverFillRemaining(
                child: Center(child: CircularProgressIndicator()),
              ),
              error: (error, _) => SliverFillRemaining(
                child: ErrorState(
                  message: error.toString(),
                  onRetry: () => ref.invalidate(tripsProvider),
                ),
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => _showCreateTrip(context),
        icon: const Icon(Icons.add_rounded),
        label: const Text('New Trip'),
      ),
    );
  }

  SliverAppBar _buildAppBar(BuildContext context, Brightness brightness) {
    return SliverAppBar.large(
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Tiptap Tour',
            style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
          ),
          Text(
            'Your trips',
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: Theme.of(context)
                      .colorScheme
                      .onSurface
                      .withValues(alpha: 0.6),
                ),
          ),
        ],
      ),
      floating: true,
      backgroundColor: Colors.transparent,
      flexibleSpace: ClipRect(
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 12, sigmaY: 12),
          child: Container(color: Colors.transparent),
        ),
      ),
    );
  }

  void _showCreateTrip(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      useSafeArea: true,
      backgroundColor: Colors.transparent,
      builder: (_) => const CreateTripSheet(),
    );
  }
}

class _TripCard extends StatelessWidget {
  final String name;
  final String? description;
  final String currency;
  final bool isArchived;
  final DateTime? startDate;
  final VoidCallback? onTap;

  const _TripCard({
    required this.name,
    this.description,
    required this.currency,
    required this.isArchived,
    this.startDate,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final brightness = Theme.of(context).brightness;

    return GestureDetector(
      onTap: onTap,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(GlassTheme.borderRadius),
        child: BackdropFilter(
          filter: GlassTheme.blurFilter(brightness: brightness),
          child: Container(
            decoration: GlassTheme.glass(brightness: brightness),
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      width: 48,
                      height: 48,
                      decoration: BoxDecoration(
                        gradient: AppColors.primaryGradient,
                        borderRadius: BorderRadius.circular(14),
                      ),
                      child: const Icon(
                        Icons.flight_takeoff_rounded,
                        color: Colors.white,
                        size: 24,
                      ),
                    ),
                    const SizedBox(width: 14),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            name,
                            style: Theme.of(context)
                                .textTheme
                                .titleMedium
                                ?.copyWith(fontWeight: FontWeight.w600),
                          ),
                          if (description != null && description!.isNotEmpty)
                            Text(
                              description!,
                              style: Theme.of(context)
                                  .textTheme
                                  .bodySmall
                                  ?.copyWith(
                                    color: Theme.of(context)
                                        .colorScheme
                                        .onSurface
                                        .withValues(alpha: 0.6),
                                  ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                        ],
                      ),
                    ),
                    if (isArchived)
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          color: AppColors.warning.withValues(alpha: 0.15),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Text(
                          'Archived',
                          style: Theme.of(context)
                              .textTheme
                              .labelSmall
                              ?.copyWith(color: AppColors.warningDark),
                        ),
                      ),
                  ],
                ),
                const SizedBox(height: 16),
                Row(
                  children: [
                    _InfoChip(
                      icon: Icons.currency_exchange_rounded,
                      label: currency,
                    ),
                    const SizedBox(width: 8),
                    if (startDate != null)
                      _InfoChip(
                        icon: Icons.calendar_today_rounded,
                        label: _formatDate(startDate!),
                      ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  String _formatDate(DateTime date) {
    final months = [
      'Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun',
      'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'
    ];
    return '${months[date.month - 1]} ${date.day}, ${date.year}';
  }
}

class _InfoChip extends StatelessWidget {
  final IconData icon;
  final String label;

  const _InfoChip({required this.icon, required this.label});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: Theme.of(context)
            .colorScheme
            .primary
            .withValues(alpha: 0.08),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 14, color: Theme.of(context).colorScheme.primary),
          const SizedBox(width: 4),
          Text(
            label,
            style: Theme.of(context).textTheme.labelSmall?.copyWith(
                  color: Theme.of(context).colorScheme.primary,
                  fontWeight: FontWeight.w600,
                ),
          ),
        ],
      ),
    );
  }
}
