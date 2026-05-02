import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tiptap_tour/application/providers/p2p_providers.dart';
import 'package:tiptap_tour/presentation/theme/app_animations.dart';
import 'package:tiptap_tour/presentation/theme/app_colors.dart';
import 'package:tiptap_tour/presentation/theme/glass_theme.dart';
import 'package:tiptap_tour/presentation/widgets/empty_state.dart';
import 'package:tiptap_tour/presentation/widgets/glass_card.dart';
import 'package:tiptap_tour/presentation/widgets/peer_card.dart';

class NearbyScreen extends ConsumerStatefulWidget {
  const NearbyScreen({super.key});

  @override
  ConsumerState<NearbyScreen> createState() => _NearbyScreenState();
}

class _NearbyScreenState extends ConsumerState<NearbyScreen>
    with TickerProviderStateMixin {
  late final AnimationController _radarController;
  late final AnimationController _pulseController;

  @override
  void initState() {
    super.initState();
    _radarController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3),
    );
    _pulseController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500),
    );
  }

  @override
  void dispose() {
    _radarController.dispose();
    _pulseController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final controllerState = ref.watch(p2pControllerProvider);
    final discoveredAsync = ref.watch(discoveredPeersProvider);
    final connectedAsync = ref.watch(connectedPeersProvider);

    if (controllerState.isScanning) {
      _radarController.repeat();
      _pulseController.repeat(reverse: true);
    } else {
      _radarController.stop();
      _pulseController.stop();
    }

    final connectedPeers =
        connectedAsync.valueOrNull ?? [];
    final discoveredPeers = (discoveredAsync.valueOrNull ?? [])
        .where((p) => !connectedPeers.any((c) => c.deviceId == p.deviceId))
        .toList();

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar.large(
            title: const Text('Nearby'),
            actions: [
              if (connectedPeers.isNotEmpty)
                Padding(
                  padding: const EdgeInsets.only(right: 8),
                  child: Chip(
                    avatar: const Icon(Icons.link_rounded, size: 16),
                    label: Text('${connectedPeers.length} connected'),
                    backgroundColor:
                        AppColors.success.withAlpha(25),
                    side: BorderSide.none,
                  ),
                ),
            ],
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Column(
                children: [
                  const SizedBox(height: 8),
                  _buildRadarSection(controllerState),
                  const SizedBox(height: 24),
                  _buildScanButton(controllerState),
                  if (controllerState.error != null) ...[
                    const SizedBox(height: 12),
                    _buildErrorBanner(controllerState.error!),
                  ],
                  const SizedBox(height: 24),
                ],
              ),
            ),
          ),
          if (connectedPeers.isNotEmpty) ...[
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(24, 0, 24, 12),
                child: Text(
                  'Connected',
                  style: Theme.of(context).textTheme.titleSmall?.copyWith(
                        fontWeight: FontWeight.w600,
                        color: AppColors.success,
                      ),
                ),
              ),
            ),
            SliverPadding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              sliver: SliverList.separated(
                itemCount: connectedPeers.length,
                separatorBuilder: (_, _) => const SizedBox(height: 10),
                itemBuilder: (context, index) {
                  final peer = connectedPeers[index];
                  return PeerCard(
                    peer: peer,
                    isSyncing:
                        controllerState.syncingWith == peer.deviceId,
                    onSync: () => ref
                        .read(p2pControllerProvider.notifier)
                        .syncWithPeer(peer.deviceId),
                    onDisconnect: () => ref
                        .read(p2pControllerProvider.notifier)
                        .disconnectFromPeer(peer.deviceId),
                    animationIndex: index,
                  );
                },
              ),
            ),
          ],
          if (discoveredPeers.isNotEmpty) ...[
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(24, 20, 24, 12),
                child: Text(
                  'Discovered Devices',
                  style: Theme.of(context).textTheme.titleSmall?.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                ),
              ),
            ),
            SliverPadding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              sliver: SliverList.separated(
                itemCount: discoveredPeers.length,
                separatorBuilder: (_, _) => const SizedBox(height: 10),
                itemBuilder: (context, index) {
                  final peer = discoveredPeers[index];
                  return PeerCard(
                    peer: peer,
                    isConnecting:
                        controllerState.connectingTo == peer.deviceId,
                    onConnect: () => ref
                        .read(p2pControllerProvider.notifier)
                        .connectToPeer(peer),
                    animationIndex: index,
                  );
                },
              ),
            ),
          ],
          if (!controllerState.isScanning &&
              connectedPeers.isEmpty &&
              discoveredPeers.isEmpty)
            const SliverFillRemaining(
              child: EmptyState(
                icon: Icons.radar_rounded,
                title: 'No Devices Found',
                subtitle:
                    'Tap "Start Scanning" to discover\nnearby devices on your network',
              ),
            ),
          const SliverToBoxAdapter(child: SizedBox(height: 32)),
        ],
      ),
    );
  }

  Widget _buildRadarSection(P2PControllerState controllerState) {
    return SizedBox(
      height: 200,
      child: Center(
        child: AnimatedBuilder(
          animation: _radarController,
          builder: (context, child) {
            return CustomPaint(
              size: const Size(200, 200),
              painter: _RadarPainter(
                progress: _radarController.value,
                isActive: controllerState.isScanning,
                pulseValue: _pulseController.value,
                color: AppColors.primary,
                brightness: Theme.of(context).brightness,
              ),
            );
          },
        ),
      ),
    )
        .animate()
        .fadeIn(duration: AppAnimations.slow)
        .scale(
          begin: const Offset(0.8, 0.8),
          duration: AppAnimations.slow,
          curve: AppAnimations.entrance,
        );
  }

  Widget _buildScanButton(P2PControllerState controllerState) {
    return SizedBox(
      width: double.infinity,
      height: 56,
      child: controllerState.isScanning
          ? OutlinedButton.icon(
              onPressed: () =>
                  ref.read(p2pControllerProvider.notifier).stopDiscovery(),
              icon: const Icon(Icons.stop_rounded),
              label: const Text('Stop Scanning'),
              style: OutlinedButton.styleFrom(
                foregroundColor: AppColors.error,
                side: const BorderSide(color: AppColors.error),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(
                    GlassTheme.borderRadiusSmall,
                  ),
                ),
              ),
            )
          : FilledButton.icon(
              onPressed: () =>
                  ref.read(p2pControllerProvider.notifier).startDiscovery(),
              icon: const Icon(Icons.radar_rounded),
              label: const Text('Start Scanning'),
              style: FilledButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(
                    GlassTheme.borderRadiusSmall,
                  ),
                ),
              ),
            ),
    ).animate().fadeIn(
          duration: AppAnimations.normal,
          delay: const Duration(milliseconds: 200),
        );
  }

  Widget _buildErrorBanner(String error) {
    return GlassCard(
      padding: const EdgeInsets.all(12),
      child: Row(
        children: [
          const Icon(Icons.error_outline_rounded,
              color: AppColors.error, size: 20),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              error,
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: AppColors.error,
                  ),
            ),
          ),
          IconButton(
            icon: const Icon(Icons.close, size: 18),
            onPressed: () =>
                ref.read(p2pControllerProvider.notifier).clearError(),
            padding: EdgeInsets.zero,
            constraints: const BoxConstraints(),
          ),
        ],
      ),
    );
  }
}

class _RadarPainter extends CustomPainter {
  final double progress;
  final bool isActive;
  final double pulseValue;
  final Color color;
  final Brightness brightness;

  _RadarPainter({
    required this.progress,
    required this.isActive,
    required this.pulseValue,
    required this.color,
    required this.brightness,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final maxRadius = size.width / 2;

    // Background circles
    for (int i = 1; i <= 3; i++) {
      final radius = maxRadius * (i / 3);
      final paint = Paint()
        ..color = color.withAlpha(brightness == Brightness.light ? 20 : 15)
        ..style = PaintingStyle.stroke
        ..strokeWidth = 1;
      canvas.drawCircle(center, radius, paint);
    }

    // Cross lines
    final linePaint = Paint()
      ..color = color.withAlpha(brightness == Brightness.light ? 15 : 10)
      ..strokeWidth = 0.5;
    canvas.drawLine(
      Offset(center.dx, center.dy - maxRadius),
      Offset(center.dx, center.dy + maxRadius),
      linePaint,
    );
    canvas.drawLine(
      Offset(center.dx - maxRadius, center.dy),
      Offset(center.dx + maxRadius, center.dy),
      linePaint,
    );

    if (isActive) {
      // Sweep gradient
      final sweepAngle = progress * 2 * pi;
      final sweepPaint = Paint()
        ..shader = SweepGradient(
          startAngle: sweepAngle - 0.8,
          endAngle: sweepAngle,
          colors: [
            color.withAlpha(0),
            color.withAlpha(60),
          ],
          stops: const [0.0, 1.0],
          transform: GradientRotation(sweepAngle - 0.8),
        ).createShader(Rect.fromCircle(center: center, radius: maxRadius));
      canvas.drawCircle(center, maxRadius, sweepPaint);

      // Pulse rings
      for (int i = 0; i < 3; i++) {
        final ringProgress = (progress + i * 0.33) % 1.0;
        final ringRadius = maxRadius * ringProgress;
        final ringAlpha = ((1.0 - ringProgress) * 40).toInt();
        final ringPaint = Paint()
          ..color = color.withAlpha(ringAlpha)
          ..style = PaintingStyle.stroke
          ..strokeWidth = 2;
        canvas.drawCircle(center, ringRadius, ringPaint);
      }

      // Sweep line
      final lineEndX = center.dx + maxRadius * cos(sweepAngle - pi / 2);
      final lineEndY = center.dy + maxRadius * sin(sweepAngle - pi / 2);
      final sweepLinePaint = Paint()
        ..color = color.withAlpha(100)
        ..strokeWidth = 1.5;
      canvas.drawLine(center, Offset(lineEndX, lineEndY), sweepLinePaint);
    }

    // Center dot
    final dotRadius = isActive ? 6.0 + pulseValue * 2.0 : 6.0;
    final dotPaint = Paint()..color = color;
    canvas.drawCircle(center, dotRadius, dotPaint);

    // Center glow
    if (isActive) {
      final glowPaint = Paint()
        ..color = color.withAlpha((pulseValue * 30).toInt())
        ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 8);
      canvas.drawCircle(center, dotRadius + 4, glowPaint);
    }
  }

  @override
  bool shouldRepaint(_RadarPainter oldDelegate) =>
      progress != oldDelegate.progress ||
      isActive != oldDelegate.isActive ||
      pulseValue != oldDelegate.pulseValue;
}
