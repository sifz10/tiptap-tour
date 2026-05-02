import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tiptap_tour/application/providers/expense_providers.dart';
import 'package:tiptap_tour/application/providers/user_providers.dart';
import 'package:tiptap_tour/core/utils/currency_formatter.dart';
import 'package:tiptap_tour/core/utils/debt_simplifier.dart';
import 'package:tiptap_tour/presentation/theme/app_animations.dart';
import 'package:tiptap_tour/presentation/theme/app_colors.dart';
import 'package:tiptap_tour/presentation/theme/glass_theme.dart';
import 'package:tiptap_tour/presentation/widgets/avatar_circle.dart';
import 'package:tiptap_tour/presentation/widgets/empty_state.dart';

class BalanceView extends ConsumerWidget {
  final String tripId;
  final String currency;

  const BalanceView({
    super.key,
    required this.tripId,
    required this.currency,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final balancesAsync = ref.watch(balancesByTripProvider(tripId));
    final usersAsync = ref.watch(usersByTripProvider(tripId));

    return balancesAsync.when(
      data: (balances) => usersAsync.when(
        data: (users) {
          if (balances.isEmpty) {
            return const EmptyState(
              icon: Icons.balance_rounded,
              title: 'No expenses yet',
              subtitle: 'Add expenses to see who owes whom',
            );
          }

          final userNames = <String, String>{};
          for (final u in users) {
            userNames[u.id] = u.displayName;
          }

          final settlements = DebtSimplifier.simplify(balances);
          final maxBalance = balances.values
              .map((v) => v.abs())
              .fold(0.0, (a, b) => a > b ? a : b);

          return SingleChildScrollView(
            padding: const EdgeInsets.fromLTRB(16, 12, 16, 100),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Balances',
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                ),
                const SizedBox(height: 12),
                ...balances.entries.toList().asMap().entries.map((entry) {
                  final index = entry.key;
                  final userId = entry.value.key;
                  final balance = entry.value.value;
                  final name = userNames[userId] ?? userId;

                  return Padding(
                    padding: const EdgeInsets.only(bottom: 8),
                    child: _BalanceCard(
                      name: name,
                      balance: balance,
                      maxBalance: maxBalance,
                      currency: currency,
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
                }),
                if (settlements.isNotEmpty) ...[
                  const SizedBox(height: 24),
                  Text(
                    'Settle Up',
                    style:
                        Theme.of(context).textTheme.titleMedium?.copyWith(
                              fontWeight: FontWeight.w600,
                            ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'Minimum transactions to settle all debts',
                    style:
                        Theme.of(context).textTheme.bodySmall?.copyWith(
                              color: Theme.of(context)
                                  .colorScheme
                                  .onSurface
                                  .withValues(alpha: 0.5),
                            ),
                  ),
                  const SizedBox(height: 12),
                  ...settlements.asMap().entries.map((entry) {
                    final index = entry.key;
                    final s = entry.value;
                    final fromName =
                        userNames[s.fromUserId] ?? s.fromUserId;
                    final toName =
                        userNames[s.toUserId] ?? s.toUserId;

                    return Padding(
                      padding: const EdgeInsets.only(bottom: 10),
                      child: _SettlementCard(
                        fromName: fromName,
                        toName: toName,
                        amount: s.amount,
                        currency: currency,
                        onSettle: () => _showSettleDialog(
                          context,
                          ref,
                          fromUserId: s.fromUserId,
                          toUserId: s.toUserId,
                          fromName: fromName,
                          toName: toName,
                          amount: s.amount,
                        ),
                      )
                          .animate()
                          .fadeIn(
                            duration: AppAnimations.normal,
                            delay: AppAnimations.staggerFor(
                                index + balances.length),
                          )
                          .slideY(
                            begin: 0.05,
                            duration: AppAnimations.normal,
                            delay: AppAnimations.staggerFor(
                                index + balances.length),
                            curve: AppAnimations.springLike,
                          ),
                    );
                  }),
                ],
              ],
            ),
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => Center(child: Text('Error: $e')),
      ),
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (e, _) => Center(child: Text('Error: $e')),
    );
  }

  void _showSettleDialog(
    BuildContext context,
    WidgetRef ref, {
    required String fromUserId,
    required String toUserId,
    required String fromName,
    required String toName,
    required double amount,
  }) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('Confirm Settlement'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                AvatarCircle(name: fromName, size: 40),
                const SizedBox(width: 8),
                const Icon(Icons.arrow_forward_rounded),
                const SizedBox(width: 8),
                AvatarCircle(name: toName, size: 40),
              ],
            ),
            const SizedBox(height: 16),
            Text(
              '$fromName pays $toName',
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            const SizedBox(height: 4),
            Text(
              CurrencyFormatter.format(amount, currency: currency),
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: AppColors.primary,
                  ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Cancel'),
          ),
          FilledButton(
            onPressed: () async {
              await ref.read(settleUpProvider.notifier).settle(
                    tripId: tripId,
                    payerId: fromUserId,
                    payeeId: toUserId,
                    amount: amount,
                    currency: currency,
                  );
              ref.invalidate(balancesByTripProvider(tripId));
              if (context.mounted) Navigator.of(context).pop();
            },
            child: const Text('Confirm'),
          ),
        ],
      ),
    );
  }
}

class _BalanceCard extends StatelessWidget {
  final String name;
  final double balance;
  final double maxBalance;
  final String currency;

  const _BalanceCard({
    required this.name,
    required this.balance,
    required this.maxBalance,
    required this.currency,
  });

  @override
  Widget build(BuildContext context) {
    final isPositive = balance >= 0;
    final color = isPositive ? AppColors.success : AppColors.error;
    final barWidth = maxBalance > 0 ? (balance.abs() / maxBalance) : 0.0;

    return Container(
      decoration: GlassTheme.glass(
        brightness: Theme.of(context).brightness,
        radius: GlassTheme.borderRadiusSmall,
      ),
      padding: const EdgeInsets.all(14),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              AvatarCircle(name: name, size: 36),
              const SizedBox(width: 10),
              Expanded(
                child: Text(
                  name,
                  style: Theme.of(context).textTheme.titleSmall?.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                ),
              ),
              Text(
                '${isPositive ? '+' : ''}${CurrencyFormatter.format(balance, currency: currency)}',
                style: Theme.of(context).textTheme.titleSmall?.copyWith(
                      fontWeight: FontWeight.w700,
                      color: color,
                    ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          ClipRRect(
            borderRadius: BorderRadius.circular(4),
            child: LinearProgressIndicator(
              value: barWidth.clamp(0.0, 1.0),
              backgroundColor: color.withValues(alpha: 0.1),
              valueColor: AlwaysStoppedAnimation(color),
              minHeight: 6,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            isPositive ? 'Gets back' : 'Owes',
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: color.withValues(alpha: 0.8),
                  fontSize: 11,
                ),
          ),
        ],
      ),
    );
  }
}

class _SettlementCard extends StatelessWidget {
  final String fromName;
  final String toName;
  final double amount;
  final String currency;
  final VoidCallback onSettle;

  const _SettlementCard({
    required this.fromName,
    required this.toName,
    required this.amount,
    required this.currency,
    required this.onSettle,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: GlassTheme.accentGlass(
        brightness: Theme.of(context).brightness,
        radius: GlassTheme.borderRadiusSmall,
      ),
      padding: const EdgeInsets.all(14),
      child: Row(
        children: [
          AvatarCircle(name: fromName, size: 32),
          const SizedBox(width: 8),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '$fromName → $toName',
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                ),
                Text(
                  CurrencyFormatter.format(amount, currency: currency),
                  style: Theme.of(context).textTheme.titleSmall?.copyWith(
                        fontWeight: FontWeight.w700,
                        color: AppColors.primary,
                      ),
                ),
              ],
            ),
          ),
          FilledButton.tonal(
            onPressed: onSettle,
            style: FilledButton.styleFrom(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              minimumSize: const Size(0, 36),
            ),
            child: const Text('Settle'),
          ),
        ],
      ),
    );
  }
}
