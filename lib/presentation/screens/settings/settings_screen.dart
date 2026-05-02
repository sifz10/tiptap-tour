import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tiptap_tour/application/providers/settings_providers.dart';
import 'package:tiptap_tour/application/providers/user_providers.dart';
import 'package:tiptap_tour/presentation/theme/app_animations.dart';
import 'package:tiptap_tour/presentation/theme/app_colors.dart';
import 'package:tiptap_tour/presentation/theme/glass_theme.dart';
import 'package:tiptap_tour/presentation/widgets/avatar_circle.dart';

class SettingsScreen extends ConsumerWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final brightness = Theme.of(context).brightness;
    final userAsync = ref.watch(currentUserProvider);
    final themeMode = ref.watch(themeProvider);
    final currency = ref.watch(currencyProvider);

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          _buildAppBar(context, brightness),
          SliverPadding(
            padding: const EdgeInsets.fromLTRB(16, 8, 16, 100),
            sliver: SliverList.list(
              children: [
                _ProfileCard(userAsync: userAsync, brightness: brightness)
                    .animate()
                    .fadeIn(duration: AppAnimations.normal)
                    .slideY(
                      begin: 0.05,
                      duration: AppAnimations.normal,
                      curve: AppAnimations.springLike,
                    ),
                const SizedBox(height: 20),
                _SectionTitle(title: 'Appearance'),
                const SizedBox(height: 8),
                _ThemeSelector(
                  currentMode: themeMode,
                  brightness: brightness,
                  onChanged: (mode) =>
                      ref.read(themeProvider.notifier).setThemeMode(mode),
                )
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
                _SectionTitle(title: 'Preferences'),
                const SizedBox(height: 8),
                _CurrencySelector(
                  currentCurrency: currency,
                  brightness: brightness,
                  onChanged: (c) =>
                      ref.read(currencyProvider.notifier).setCurrency(c),
                )
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
                const SizedBox(height: 20),
                _SectionTitle(title: 'About'),
                const SizedBox(height: 8),
                _AboutCard(brightness: brightness)
                    .animate()
                    .fadeIn(
                      duration: AppAnimations.normal,
                      delay: AppAnimations.staggerFor(3),
                    )
                    .slideY(
                      begin: 0.05,
                      duration: AppAnimations.normal,
                      delay: AppAnimations.staggerFor(3),
                      curve: AppAnimations.springLike,
                    ),
              ],
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
              color: AppColors.primary.withAlpha(25),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(
              Icons.settings_rounded,
              color: AppColors.primary,
              size: 18,
            ),
          ),
          const SizedBox(width: 12),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Settings',
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
              ),
              Text(
                'Customize your experience',
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

class _SectionTitle extends StatelessWidget {
  final String title;

  const _SectionTitle({required this.title});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 4),
      child: Text(
        title,
        style: Theme.of(context).textTheme.titleSmall?.copyWith(
              fontWeight: FontWeight.w600,
              color: Theme.of(context)
                  .colorScheme
                  .onSurface
                  .withValues(alpha: 0.6),
            ),
      ),
    );
  }
}

class _ProfileCard extends StatelessWidget {
  final AsyncValue userAsync;
  final Brightness brightness;

  const _ProfileCard({required this.userAsync, required this.brightness});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: GlassTheme.accentGlass(brightness: brightness),
      child: userAsync.when(
        data: (user) {
          if (user == null) {
            return const Text('No profile found');
          }
          return Row(
            children: [
              AvatarCircle(
                name: user.displayName,
                size: 56,
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      user.displayName,
                      style:
                          Theme.of(context).textTheme.titleLarge?.copyWith(
                                fontWeight: FontWeight.w700,
                              ),
                    ),
                    const SizedBox(height: 4),
                    Row(
                      children: [
                        Icon(
                          Icons.verified_rounded,
                          size: 14,
                          color: AppColors.success,
                        ),
                        const SizedBox(width: 4),
                        Text(
                          'Local profile',
                          style: Theme.of(context)
                              .textTheme
                              .bodySmall
                              ?.copyWith(
                                color: Theme.of(context)
                                    .colorScheme
                                    .onSurface
                                    .withValues(alpha: 0.6),
                              ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          );
        },
        loading: () => const Center(
          child: Padding(
            padding: EdgeInsets.all(16),
            child: CircularProgressIndicator(),
          ),
        ),
        error: (_, _) => const Text('Error loading profile'),
      ),
    );
  }
}

class _ThemeSelector extends StatelessWidget {
  final ThemeMode currentMode;
  final Brightness brightness;
  final ValueChanged<ThemeMode> onChanged;

  const _ThemeSelector({
    required this.currentMode,
    required this.brightness,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: GlassTheme.glass(
        brightness: brightness,
        radius: GlassTheme.borderRadiusSmall,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                Icons.palette_outlined,
                size: 20,
                color: AppColors.primary,
              ),
              const SizedBox(width: 10),
              Text(
                'Theme',
                style: Theme.of(context).textTheme.titleSmall?.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
              ),
            ],
          ),
          const SizedBox(height: 14),
          Row(
            children: [
              _ThemeOption(
                icon: Icons.phone_android_rounded,
                label: 'System',
                isSelected: currentMode == ThemeMode.system,
                onTap: () => onChanged(ThemeMode.system),
              ),
              const SizedBox(width: 8),
              _ThemeOption(
                icon: Icons.light_mode_rounded,
                label: 'Light',
                isSelected: currentMode == ThemeMode.light,
                onTap: () => onChanged(ThemeMode.light),
              ),
              const SizedBox(width: 8),
              _ThemeOption(
                icon: Icons.dark_mode_rounded,
                label: 'Dark',
                isSelected: currentMode == ThemeMode.dark,
                onTap: () => onChanged(ThemeMode.dark),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _ThemeOption extends StatelessWidget {
  final IconData icon;
  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  const _ThemeOption({
    required this.icon,
    required this.label,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: AnimatedContainer(
          duration: AppAnimations.fast,
          padding: const EdgeInsets.symmetric(vertical: 12),
          decoration: BoxDecoration(
            color: isSelected
                ? AppColors.primary.withAlpha(25)
                : Colors.transparent,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(
              color: isSelected
                  ? AppColors.primary.withAlpha(102)
                  : Theme.of(context).colorScheme.outline.withAlpha(51),
            ),
          ),
          child: Column(
            children: [
              Icon(
                icon,
                size: 22,
                color: isSelected
                    ? AppColors.primary
                    : Theme.of(context)
                        .colorScheme
                        .onSurface
                        .withValues(alpha: 0.5),
              ),
              const SizedBox(height: 4),
              Text(
                label,
                style: Theme.of(context).textTheme.labelSmall?.copyWith(
                      color: isSelected
                          ? AppColors.primary
                          : Theme.of(context)
                              .colorScheme
                              .onSurface
                              .withValues(alpha: 0.5),
                      fontWeight:
                          isSelected ? FontWeight.w600 : FontWeight.normal,
                    ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _CurrencySelector extends StatelessWidget {
  final String currentCurrency;
  final Brightness brightness;
  final ValueChanged<String> onChanged;

  const _CurrencySelector({
    required this.currentCurrency,
    required this.brightness,
    required this.onChanged,
  });

  static const _currencies = [
    ('BDT', '৳', 'Bangladeshi Taka'),
    ('USD', '\$', 'US Dollar'),
    ('EUR', '€', 'Euro'),
    ('GBP', '£', 'British Pound'),
    ('INR', '₹', 'Indian Rupee'),
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: GlassTheme.glass(
        brightness: brightness,
        radius: GlassTheme.borderRadiusSmall,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                Icons.currency_exchange_rounded,
                size: 20,
                color: AppColors.secondary,
              ),
              const SizedBox(width: 10),
              Text(
                'Default Currency',
                style: Theme.of(context).textTheme.titleSmall?.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
              ),
            ],
          ),
          const SizedBox(height: 14),
          ..._currencies.map((c) {
            final isSelected = c.$1 == currentCurrency;
            return Padding(
              padding: const EdgeInsets.only(bottom: 4),
              child: InkWell(
                onTap: () => onChanged(c.$1),
                borderRadius: BorderRadius.circular(10),
                child: AnimatedContainer(
                  duration: AppAnimations.fast,
                  padding: const EdgeInsets.symmetric(
                      horizontal: 14, vertical: 12),
                  decoration: BoxDecoration(
                    color: isSelected
                        ? AppColors.secondary.withAlpha(20)
                        : Colors.transparent,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Row(
                    children: [
                      Container(
                        width: 32,
                        height: 32,
                        decoration: BoxDecoration(
                          color: isSelected
                              ? AppColors.secondary.withAlpha(38)
                              : Theme.of(context)
                                  .colorScheme
                                  .surfaceContainerHighest
                                  .withAlpha(128),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Center(
                          child: Text(
                            c.$2,
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w700,
                              color: isSelected
                                  ? AppColors.secondary
                                  : Theme.of(context)
                                      .colorScheme
                                      .onSurface
                                      .withValues(alpha: 0.5),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              c.$1,
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyMedium
                                  ?.copyWith(
                                    fontWeight: FontWeight.w600,
                                  ),
                            ),
                            Text(
                              c.$3,
                              style: Theme.of(context)
                                  .textTheme
                                  .bodySmall
                                  ?.copyWith(
                                    color: Theme.of(context)
                                        .colorScheme
                                        .onSurface
                                        .withValues(alpha: 0.5),
                                  ),
                            ),
                          ],
                        ),
                      ),
                      if (isSelected)
                        Icon(
                          Icons.check_circle_rounded,
                          color: AppColors.secondary,
                          size: 22,
                        ),
                    ],
                  ),
                ),
              ),
            );
          }),
        ],
      ),
    );
  }
}

class _AboutCard extends StatelessWidget {
  final Brightness brightness;

  const _AboutCard({required this.brightness});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: GlassTheme.glass(
        brightness: brightness,
        radius: GlassTheme.borderRadiusSmall,
      ),
      child: Column(
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
                      'Tiptap Tour',
                      style:
                          Theme.of(context).textTheme.titleMedium?.copyWith(
                                fontWeight: FontWeight.w700,
                              ),
                    ),
                    Text(
                      'Version 1.0.0',
                      style:
                          Theme.of(context).textTheme.bodySmall?.copyWith(
                                color: Theme.of(context)
                                    .colorScheme
                                    .onSurface
                                    .withValues(alpha: 0.5),
                              ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          const Divider(height: 1),
          const SizedBox(height: 12),
          _AboutRow(
            icon: Icons.info_outline_rounded,
            label: 'Split expenses offline with friends',
          ),
          const SizedBox(height: 8),
          _AboutRow(
            icon: Icons.wifi_off_rounded,
            label: 'P2P sync — no internet needed',
          ),
          const SizedBox(height: 8),
          _AboutRow(
            icon: Icons.code_rounded,
            label: 'Made by Ryven Agency',
          ),
        ],
      ),
    );
  }
}

class _AboutRow extends StatelessWidget {
  final IconData icon;
  final String label;

  const _AboutRow({required this.icon, required this.label});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(
          icon,
          size: 16,
          color: Theme.of(context)
              .colorScheme
              .onSurface
              .withValues(alpha: 0.4),
        ),
        const SizedBox(width: 10),
        Text(
          label,
          style: Theme.of(context).textTheme.bodySmall?.copyWith(
                color: Theme.of(context)
                    .colorScheme
                    .onSurface
                    .withValues(alpha: 0.6),
              ),
        ),
      ],
    );
  }
}
