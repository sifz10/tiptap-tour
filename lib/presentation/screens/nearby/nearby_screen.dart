import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:tiptap_tour/application/providers/p2p_providers.dart';
import 'package:tiptap_tour/application/providers/trip_providers.dart';
import 'package:tiptap_tour/application/providers/user_providers.dart';
import 'package:tiptap_tour/domain/entities/p2p_peer.dart';
import 'package:tiptap_tour/infrastructure/p2p/p2p_diagnostics.dart';
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
    final diagnostics = ref.watch(p2pDiagnosticsProvider);
    final discoveredAsync = ref.watch(discoveredPeersProvider);
    final connectedAsync = ref.watch(connectedPeersProvider);

    if (controllerState.isScanning) {
      _radarController.repeat();
      _pulseController.repeat(reverse: true);
    } else {
      _radarController.stop();
      _pulseController.stop();
    }

    final connectedPeers = connectedAsync.valueOrNull ?? [];
    final discoveredPeers = (discoveredAsync.valueOrNull ?? [])
        .where((p) => !connectedPeers.any((c) => c.deviceId == p.deviceId))
        .toList();

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            title: Row(
              children: [
                Container(
                  width: 36,
                  height: 36,
                  decoration: BoxDecoration(
                    color: AppColors.secondary.withAlpha(25),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Icon(
                    Icons.radar_rounded,
                    color: AppColors.secondary,
                    size: 18,
                  ),
                ),
                const SizedBox(width: 12),
                Text(
                  'Nearby',
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            pinned: true,
            backgroundColor: Theme.of(
              context,
            ).scaffoldBackgroundColor.withAlpha(230),
            actions: [
              if (connectedPeers.isNotEmpty)
                Padding(
                  padding: const EdgeInsets.only(right: 8),
                  child: Chip(
                    avatar: const Icon(Icons.link_rounded, size: 16),
                    label: Text('${connectedPeers.length} connected'),
                    backgroundColor: AppColors.success.withAlpha(25),
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
                  _buildTransportToggles(controllerState),
                  if (controllerState.isScanning ||
                      connectedPeers.isNotEmpty ||
                      diagnostics.peers.isNotEmpty) ...[
                    const SizedBox(height: 12),
                    _buildNetworkDiagnostics(diagnostics),
                  ],
                  const SizedBox(height: 16),
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
                    isSyncing: controllerState.syncingWith == peer.deviceId,
                    onAddToTrip: () => _showAddToTripSheet(peer),
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
                  style: Theme.of(
                    context,
                  ).textTheme.titleSmall?.copyWith(fontWeight: FontWeight.w600),
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
                    isConnecting: controllerState.connectingTo == peer.deviceId,
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

  void _showAddToTripSheet(P2PPeer peer) {
    showModalBottomSheet<void>(
      context: context,
      backgroundColor: Theme.of(context).colorScheme.surface,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (sheetContext) {
        return Consumer(
          builder: (context, ref, _) {
            final tripsAsync = ref.watch(tripsProvider);

            return Padding(
              padding: const EdgeInsets.fromLTRB(24, 16, 24, 32),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: Container(
                      width: 40,
                      height: 4,
                      decoration: BoxDecoration(
                        color: Theme.of(context)
                            .colorScheme
                            .onSurfaceVariant
                            .withAlpha(60),
                        borderRadius: BorderRadius.circular(2),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'Add ${peer.displayName} to Trip',
                    style: Theme.of(context)
                        .textTheme
                        .titleMedium
                        ?.copyWith(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 16),
                  tripsAsync.when(
                    data: (trips) {
                      if (trips.isEmpty) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(vertical: 24),
                          child: Center(
                            child: Text(
                              'No trips yet. Create a trip first!',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyMedium
                                  ?.copyWith(
                                    color: Theme.of(context)
                                        .colorScheme
                                        .onSurfaceVariant,
                                  ),
                            ),
                          ),
                        );
                      }

                      return ConstrainedBox(
                        constraints: BoxConstraints(
                          maxHeight: MediaQuery.of(context).size.height * 0.4,
                        ),
                        child: ListView.separated(
                          shrinkWrap: true,
                          itemCount: trips.length,
                          separatorBuilder: (_, _) =>
                              const SizedBox(height: 8),
                          itemBuilder: (context, index) {
                            final trip = trips[index];
                            return ListTile(
                              leading: CircleAvatar(
                                backgroundColor:
                                    AppColors.primary.withAlpha(25),
                                child: const Icon(
                                  Icons.luggage_rounded,
                                  color: AppColors.primary,
                                  size: 20,
                                ),
                              ),
                              title: Text(
                                trip.name,
                                style: const TextStyle(
                                    fontWeight: FontWeight.w600),
                              ),
                              subtitle: trip.description != null &&
                                      trip.description!.isNotEmpty
                                  ? Text(
                                      trip.description!,
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                    )
                                  : null,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                                side: BorderSide(
                                  color: Theme.of(context)
                                      .colorScheme
                                      .outlineVariant
                                      .withAlpha(60),
                                ),
                              ),
                              onTap: () async {
                                Navigator.of(sheetContext).pop();
                                await _addPeerToTrip(peer, trip.id);
                              },
                            );
                          },
                        ),
                      );
                    },
                    loading: () => const Padding(
                      padding: EdgeInsets.symmetric(vertical: 24),
                      child: Center(child: CircularProgressIndicator()),
                    ),
                    error: (e, _) => Padding(
                      padding: const EdgeInsets.symmetric(vertical: 24),
                      child: Center(child: Text('Error loading trips: $e')),
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }

  Future<void> _addPeerToTrip(P2PPeer peer, String tripId) async {
    try {
      await ref
          .read(addPeerToTripProvider.notifier)
          .addPeerToTrip(peer: peer, tripId: tripId);

      if (!mounted) return;

      ref.invalidate(usersByTripProvider(tripId));
      ref.invalidate(tripMembersProvider(tripId));

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('${peer.displayName} added and synced'),
          action: SnackBarAction(
            label: 'Go to Trip',
            onPressed: () => context.go('/trip/$tripId'),
          ),
        ),
      );
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Failed to add: $e'),
          backgroundColor: AppColors.error,
        ),
      );
    }
  }

  Widget _buildTransportToggles(P2PControllerState controllerState) {
    return GlassCard(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      child: Row(
        children: [
          Icon(
            Icons.settings_input_antenna_rounded,
            size: 16,
            color: Theme.of(context).colorScheme.onSurfaceVariant,
          ),
          const SizedBox(width: 8),
          Text(
            'Transport',
            style: Theme.of(
              context,
            ).textTheme.labelMedium?.copyWith(fontWeight: FontWeight.w600),
          ),
          const Spacer(),
          _TransportChip(
            label: 'Wi-Fi',
            icon: Icons.wifi_rounded,
            enabled: controllerState.wifiEnabled,
            onTap: () => ref
                .read(p2pControllerProvider.notifier)
                .setWifiEnabled(!controllerState.wifiEnabled),
          ),
          const SizedBox(width: 8),
          _TransportChip(
            label: 'BLE',
            icon: Icons.bluetooth_rounded,
            enabled: controllerState.bleEnabled,
            onTap: () => ref
                .read(p2pControllerProvider.notifier)
                .setBleEnabled(!controllerState.bleEnabled),
          ),
        ],
      ),
    ).animate().fadeIn(duration: AppAnimations.normal);
  }

  Widget _buildNetworkDiagnostics(P2PDiagnostics diagnostics) {
    return GlassCard(
      padding: const EdgeInsets.all(14),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                Icons.hub_rounded,
                size: 18,
                color: Theme.of(context).colorScheme.onSurfaceVariant,
              ),
              const SizedBox(width: 8),
              Text(
                'Network Status',
                style: Theme.of(
                  context,
                ).textTheme.labelLarge?.copyWith(fontWeight: FontWeight.w700),
              ),
              const Spacer(),
              _StatusPill(
                icon: Icons.security_rounded,
                label: '${diagnostics.encryptedPeerCount}',
                color: AppColors.success,
              ),
            ],
          ),
          const SizedBox(height: 12),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              _StatusPill(
                icon: Icons.link_rounded,
                label: '${diagnostics.directPeerCount} direct',
                color: AppColors.secondary,
              ),
              _StatusPill(
                icon: Icons.route_rounded,
                label: '${diagnostics.meshPeerCount} mesh',
                color: AppColors.info,
              ),
              _StatusPill(
                icon: diagnostics.wifiEnabled
                    ? Icons.wifi_rounded
                    : Icons.wifi_off_rounded,
                label: diagnostics.wifiEnabled ? 'Wi-Fi on' : 'Wi-Fi off',
                color: diagnostics.wifiEnabled
                    ? AppColors.success
                    : AppColors.warning,
              ),
              _StatusPill(
                icon: Icons.bluetooth_rounded,
                label: diagnostics.bleEnabled ? 'BLE on' : 'BLE off',
                color: diagnostics.bleEnabled
                    ? AppColors.success
                    : AppColors.warning,
              ),
            ],
          ),
          if (diagnostics.peers.isNotEmpty) ...[
            const SizedBox(height: 12),
            for (final peer in diagnostics.peers.take(4)) ...[
              _RouteDiagnosticRow(peer: peer),
              if (peer != diagnostics.peers.take(4).last)
                const SizedBox(height: 8),
            ],
          ],
        ],
      ),
    ).animate().fadeIn(duration: AppAnimations.normal);
  }

  Widget _buildRadarSection(P2PControllerState controllerState) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Container(
          height: 220,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            gradient: RadialGradient(
              colors: [
                AppColors.primary.withAlpha(isDark ? 12 : 8),
                Colors.transparent,
              ],
              radius: 0.7,
            ),
          ),
          child: Center(
            child: AnimatedBuilder(
              animation: _radarController,
              builder: (context, child) {
                return CustomPaint(
                  size: const Size(210, 210),
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
          const Icon(
            Icons.error_outline_rounded,
            color: AppColors.error,
            size: 20,
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              error,
              style: Theme.of(
                context,
              ).textTheme.bodySmall?.copyWith(color: AppColors.error),
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
    final maxRadius = size.width / 2 - 4;
    final isDark = brightness == Brightness.dark;

    // Concentric guide rings with subtle gradient feel
    for (int i = 1; i <= 4; i++) {
      final radius = maxRadius * (i / 4);
      final alpha = isDark ? (10 + i * 3) : (15 + i * 4);
      final paint = Paint()
        ..color = color.withAlpha(alpha)
        ..style = PaintingStyle.stroke
        ..strokeWidth = 0.8;
      canvas.drawCircle(center, radius, paint);
    }

    // Subtle cross-hair lines
    final crossAlpha = isDark ? 12 : 18;
    final crossPaint = Paint()
      ..color = color.withAlpha(crossAlpha)
      ..strokeWidth = 0.5;
    canvas.drawLine(
      Offset(center.dx, center.dy - maxRadius),
      Offset(center.dx, center.dy + maxRadius),
      crossPaint,
    );
    canvas.drawLine(
      Offset(center.dx - maxRadius, center.dy),
      Offset(center.dx + maxRadius, center.dy),
      crossPaint,
    );

    // Diagonal cross-hairs for premium look
    final diagLength = maxRadius * 0.7;
    for (final angle in [pi / 4, 3 * pi / 4, 5 * pi / 4, 7 * pi / 4]) {
      final dx = cos(angle) * diagLength;
      final dy = sin(angle) * diagLength;
      canvas.drawLine(
        center,
        Offset(center.dx + dx, center.dy + dy),
        Paint()..color = color.withAlpha(isDark ? 6 : 8)..strokeWidth = 0.3,
      );
    }

    if (isActive) {
      final sweepAngle = progress * 2 * pi;

      // Sweep trail — drawn as a series of thin arc segments with fading alpha
      final trailLength = pi / 2.5;
      const trailSegments = 30;
      for (int i = 0; i < trailSegments; i++) {
        final t = i / trailSegments;
        final segAngle = sweepAngle - trailLength * (1 - t);
        final nextAngle = sweepAngle - trailLength * (1 - (i + 1) / trailSegments);
        final alpha = (t * t * (isDark ? 35 : 45)).toInt();
        if (alpha <= 0) continue;

        final trailPaint = Paint()
          ..color = color.withAlpha(alpha)
          ..style = PaintingStyle.fill;

        final path = Path()
          ..moveTo(center.dx, center.dy)
          ..lineTo(
            center.dx + maxRadius * cos(segAngle - pi / 2),
            center.dy + maxRadius * sin(segAngle - pi / 2),
          )
          ..arcTo(
            Rect.fromCircle(center: center, radius: maxRadius),
            segAngle - pi / 2,
            nextAngle - segAngle,
            false,
          )
          ..close();
        canvas.drawPath(path, trailPaint);
      }

      // Main sweep line with gradient
      final lineEndX = center.dx + maxRadius * cos(sweepAngle - pi / 2);
      final lineEndY = center.dy + maxRadius * sin(sweepAngle - pi / 2);
      final sweepLinePaint = Paint()
        ..shader = LinearGradient(
          colors: [
            color.withAlpha(20),
            color.withAlpha(180),
          ],
        ).createShader(
          Rect.fromPoints(center, Offset(lineEndX, lineEndY)),
        )
        ..strokeWidth = 2.0
        ..strokeCap = StrokeCap.round;
      canvas.drawLine(center, Offset(lineEndX, lineEndY), sweepLinePaint);

      // Sweep tip dot
      final tipGlow = Paint()
        ..color = color.withAlpha(60)
        ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 6);
      canvas.drawCircle(Offset(lineEndX, lineEndY), 4, tipGlow);
      canvas.drawCircle(
        Offset(lineEndX, lineEndY),
        2.5,
        Paint()..color = color.withAlpha(200),
      );

      // Expanding pulse rings — only 2 for cleaner look
      for (int i = 0; i < 2; i++) {
        final ringProgress = (progress + i * 0.5) % 1.0;
        final ringRadius = maxRadius * ringProgress;
        final ringAlpha = ((1.0 - ringProgress) * (isDark ? 30 : 40)).toInt();
        if (ringAlpha <= 0) continue;
        final ringPaint = Paint()
          ..color = color.withAlpha(ringAlpha)
          ..style = PaintingStyle.stroke
          ..strokeWidth = 1.5;
        canvas.drawCircle(center, ringRadius, ringPaint);
      }
    }

    // Outer rim glow
    if (isActive) {
      final rimPaint = Paint()
        ..color = color.withAlpha(isDark ? 15 : 20)
        ..style = PaintingStyle.stroke
        ..strokeWidth = 2.0
        ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 3);
      canvas.drawCircle(center, maxRadius, rimPaint);
    }

    // Center device dot — multi-layer for depth
    final baseRadius = isActive ? 5.0 + pulseValue * 1.5 : 5.0;

    // Outer glow
    if (isActive) {
      canvas.drawCircle(
        center,
        baseRadius + 8,
        Paint()
          ..color = color.withAlpha((pulseValue * 20).toInt())
          ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 12),
      );
    }

    // Middle ring
    canvas.drawCircle(
      center,
      baseRadius + 3,
      Paint()
        ..color = color.withAlpha(isActive ? 30 : 15)
        ..style = PaintingStyle.stroke
        ..strokeWidth = 1.5,
    );

    // Core dot with gradient
    final dotPaint = Paint()
      ..shader = RadialGradient(
        colors: [
          color,
          color.withAlpha(180),
        ],
      ).createShader(Rect.fromCircle(center: center, radius: baseRadius));
    canvas.drawCircle(center, baseRadius, dotPaint);

    // Tiny highlight on center dot
    canvas.drawCircle(
      Offset(center.dx - baseRadius * 0.25, center.dy - baseRadius * 0.25),
      baseRadius * 0.35,
      Paint()..color = Colors.white.withAlpha(isActive ? 80 : 40),
    );
  }

  @override
  bool shouldRepaint(_RadarPainter oldDelegate) =>
      progress != oldDelegate.progress ||
      isActive != oldDelegate.isActive ||
      pulseValue != oldDelegate.pulseValue;
}

class _StatusPill extends StatelessWidget {
  final IconData icon;
  final String label;
  final Color color;

  const _StatusPill({
    required this.icon,
    required this.label,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 5),
      decoration: BoxDecoration(
        color: color.withAlpha(22),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: color.withAlpha(55)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 13, color: color),
          const SizedBox(width: 5),
          Text(
            label,
            style: Theme.of(context).textTheme.labelSmall?.copyWith(
              color: color,
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
      ),
    );
  }
}

class _RouteDiagnosticRow extends StatelessWidget {
  final P2PPeerDiagnostic peer;

  const _RouteDiagnosticRow({required this.peer});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final routeColor = peer.isDirect ? AppColors.secondary : AppColors.info;

    return Row(
      children: [
        Container(
          width: 28,
          height: 28,
          decoration: BoxDecoration(
            color: routeColor.withAlpha(22),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(
            peer.isDirect ? Icons.link_rounded : Icons.route_rounded,
            size: 15,
            color: routeColor,
          ),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                peer.displayName,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: Theme.of(
                  context,
                ).textTheme.labelMedium?.copyWith(fontWeight: FontWeight.w700),
              ),
              const SizedBox(height: 2),
              Text(
                peer.isDirect
                    ? '${peer.transportLabel} · direct'
                    : '${peer.hopCount} hops · via ${_shortId(peer.nextHopId)}',
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: Theme.of(context).textTheme.labelSmall?.copyWith(
                  color: colorScheme.onSurfaceVariant,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(width: 8),
        Icon(
          peer.encryptionReady ? Icons.lock_rounded : Icons.lock_open_rounded,
          size: 16,
          color: peer.encryptionReady ? AppColors.success : AppColors.warning,
        ),
      ],
    );
  }

  String _shortId(String value) {
    if (value.length <= 8) return value;
    return value.substring(0, 8);
  }
}

class _TransportChip extends StatelessWidget {
  final String label;
  final IconData icon;
  final bool enabled;
  final VoidCallback onTap;

  const _TransportChip({
    required this.label,
    required this.icon,
    required this.enabled,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final color = enabled
        ? AppColors.primary
        : Theme.of(context).colorScheme.onSurfaceVariant.withAlpha(100);

    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
        decoration: BoxDecoration(
          color: enabled ? AppColors.primary.withAlpha(20) : Colors.transparent,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            color: enabled
                ? AppColors.primary.withAlpha(60)
                : color.withAlpha(40),
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, size: 14, color: color),
            const SizedBox(width: 4),
            Text(
              label,
              style: Theme.of(context).textTheme.labelSmall?.copyWith(
                color: color,
                fontWeight: enabled ? FontWeight.w600 : FontWeight.normal,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
