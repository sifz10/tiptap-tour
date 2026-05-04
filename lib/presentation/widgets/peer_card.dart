import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:tiptap_tour/domain/entities/p2p_peer.dart';
import 'package:tiptap_tour/presentation/theme/app_animations.dart';
import 'package:tiptap_tour/presentation/theme/app_colors.dart';
import 'package:tiptap_tour/presentation/widgets/avatar_circle.dart';
import 'package:tiptap_tour/presentation/widgets/glass_card.dart';

class PeerCard extends StatelessWidget {
  final P2PPeer peer;
  final bool isConnecting;
  final bool isSyncing;
  final VoidCallback? onConnect;
  final VoidCallback? onDisconnect;
  final VoidCallback? onSync;
  final VoidCallback? onAddToTrip;
  final int animationIndex;

  const PeerCard({
    super.key,
    required this.peer,
    this.isConnecting = false,
    this.isSyncing = false,
    this.onConnect,
    this.onDisconnect,
    this.onSync,
    this.onAddToTrip,
    this.animationIndex = 0,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return GlassCard(
      padding: const EdgeInsets.all(16),
      child: Row(
        children: [
          Stack(
            children: [
              AvatarCircle(name: peer.displayName, size: 48),
              Positioned(
                right: 0,
                bottom: 0,
                child: Container(
                  width: 14,
                  height: 14,
                  decoration: BoxDecoration(
                    color: peer.isConnected
                        ? AppColors.success
                        : AppColors.warning,
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: colorScheme.surface,
                      width: 2,
                    ),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  peer.displayName,
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                ),
                const SizedBox(height: 2),
                Text(
                  peer.isConnected
                      ? 'Connected'
                      : peer.platform != null
                          ? peer.platform!
                          : 'Nearby',
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: peer.isConnected
                            ? AppColors.success
                            : colorScheme.onSurfaceVariant,
                      ),
                ),
              ],
            ),
          ),
          if (isConnecting)
            const SizedBox(
              width: 24,
              height: 24,
              child: CircularProgressIndicator(strokeWidth: 2),
            )
          else if (isSyncing)
            const SizedBox(
              width: 24,
              height: 24,
              child: CircularProgressIndicator(
                strokeWidth: 2,
                color: AppColors.secondary,
              ),
            )
          else if (peer.isConnected)
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  icon: const Icon(Icons.group_add_rounded),
                  onPressed: onAddToTrip,
                  tooltip: 'Add to trip',
                  color: AppColors.primary,
                  iconSize: 22,
                ),
                IconButton(
                  icon: const Icon(Icons.sync_rounded),
                  onPressed: onSync,
                  tooltip: 'Sync data',
                  color: AppColors.secondary,
                  iconSize: 22,
                ),
                IconButton(
                  icon: const Icon(Icons.link_off_rounded),
                  onPressed: onDisconnect,
                  tooltip: 'Disconnect',
                  color: AppColors.error,
                  iconSize: 22,
                ),
              ],
            )
          else
            FilledButton.tonal(
              onPressed: onConnect,
              style: FilledButton.styleFrom(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 8,
                ),
              ),
              child: const Text('Connect'),
            ),
        ],
      ),
    )
        .animate()
        .fadeIn(
          duration: AppAnimations.normal,
          delay: AppAnimations.staggerFor(animationIndex),
        )
        .slideX(
          begin: 0.05,
          duration: AppAnimations.normal,
          delay: AppAnimations.staggerFor(animationIndex),
          curve: AppAnimations.snappy,
        );
  }
}
