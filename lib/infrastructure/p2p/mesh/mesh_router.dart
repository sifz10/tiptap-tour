import 'dart:async';

import 'package:tiptap_tour/domain/entities/p2p_peer.dart';
import 'package:tiptap_tour/domain/enums/connection_state.dart';
import 'package:tiptap_tour/infrastructure/p2p/mesh/routing_table.dart';
import 'package:tiptap_tour/infrastructure/p2p/mesh/seen_message_cache.dart';
import 'package:tiptap_tour/infrastructure/p2p/p2p_diagnostics.dart';
import 'package:tiptap_tour/infrastructure/p2p/p2p_message.dart';
import 'package:tiptap_tour/infrastructure/p2p/transport.dart';

class MeshRouter implements P2PTransport {
  final P2PTransport _transport;
  final RoutingTable _routingTable = RoutingTable();
  final SeenMessageCache _seenMessages = SeenMessageCache();
  final Map<String, P2PPeer> _routedPeers = {};

  final _incomingController = StreamController<P2PMessage>.broadcast();
  final _connectedController = StreamController<List<P2PPeer>>.broadcast();
  StreamSubscription<P2PMessage>? _messageSubscription;
  StreamSubscription<List<P2PPeer>>? _connectedSubscription;
  Timer? _announceTimer;

  MeshRouter(this._transport);

  @override
  String get deviceId => _transport.deviceId;
  @override
  String get displayName => _transport.displayName;

  @override
  P2PConnectionState get currentState => _transport.currentState;
  @override
  List<P2PPeer> get currentDiscoveredPeers => _transport.currentDiscoveredPeers;
  @override
  List<P2PPeer> get currentConnectedPeers {
    final directPeers = _transport.currentConnectedPeers;
    final directIds = directPeers.map((p) => p.deviceId).toSet();
    final routedPeers = _routedPeers.entries
        .where((entry) => !directIds.contains(entry.key))
        .where((entry) => _routingTable.hasRoute(entry.key))
        .map((entry) {
          final route = _routingTable.getEntry(entry.key);
          final hopCount = route?.hopCount ?? 2;
          return entry.value.copyWith(
            platform: 'Mesh · $hopCount hops',
            isConnected: true,
            lastSeen: route?.lastUpdated ?? entry.value.lastSeen,
          );
        });
    return [...directPeers, ...routedPeers];
  }

  @override
  Stream<P2PConnectionState> get connectionState => _transport.connectionState;
  @override
  Stream<List<P2PPeer>> get discoveredPeers => _transport.discoveredPeers;
  @override
  Stream<List<P2PPeer>> get connectedPeers => _connectedController.stream;

  @override
  Stream<P2PMessage> get incomingMessages => _incomingController.stream;

  List<P2PPeerDiagnostic> get peerDiagnostics {
    final directPeers = _transport.currentConnectedPeers;
    final directIds = directPeers.map((peer) => peer.deviceId).toSet();
    final diagnostics = <P2PPeerDiagnostic>[
      for (final peer in directPeers)
        P2PPeerDiagnostic(
          deviceId: peer.deviceId,
          displayName: peer.displayName,
          isDirect: true,
          hopCount: 1,
          nextHopId: peer.deviceId,
          transportLabel: peer.platform ?? 'Direct',
          encryptionReady: false,
          lastUpdated: peer.lastSeen,
        ),
    ];

    for (final entry in _routedPeers.entries) {
      if (directIds.contains(entry.key)) continue;
      final route = _routingTable.getEntry(entry.key);
      if (route == null) continue;
      diagnostics.add(
        P2PPeerDiagnostic(
          deviceId: entry.key,
          displayName: entry.value.displayName,
          isDirect: false,
          hopCount: route.hopCount,
          nextHopId: route.nextHopId,
          transportLabel: 'Mesh',
          encryptionReady: false,
          lastUpdated: route.lastUpdated,
        ),
      );
    }

    diagnostics.sort((a, b) {
      final hopCompare = a.hopCount.compareTo(b.hopCount);
      if (hopCompare != 0) return hopCompare;
      return a.displayName.compareTo(b.displayName);
    });
    return diagnostics;
  }

  void start() {
    _messageSubscription = _transport.incomingMessages.listen(_onMessage);
    _connectedSubscription = _transport.connectedPeers.listen(_onPeersChanged);
    _startRouteAnnouncements();
  }

  @override
  Future<void> startServer() => _transport.startServer();

  @override
  Future<void> startDiscovery() => _transport.startDiscovery();

  @override
  Future<void> stopDiscovery() => _transport.stopDiscovery();

  @override
  Future<void> connectToPeer(P2PPeer peer) => _transport.connectToPeer(peer);

  @override
  Future<void> disconnectFromPeer(String peerDeviceId) async {
    final directPeerIds = _transport.currentConnectedPeers
        .map((peer) => peer.deviceId)
        .toSet();
    if (!directPeerIds.contains(peerDeviceId)) {
      _routedPeers.remove(peerDeviceId);
      _routingTable.removeRoutesVia(peerDeviceId);
      _emitConnectedPeers();
      return;
    }

    await _transport.disconnectFromPeer(peerDeviceId);
    _routingTable.removeRoutesVia(peerDeviceId);
    _emitConnectedPeers();
  }

  @override
  Future<void> sendMessage(String peerDeviceId, P2PMessage message) async {
    final directPeerIds = _transport.currentConnectedPeers
        .map((p) => p.deviceId)
        .toSet();

    if (directPeerIds.contains(peerDeviceId)) {
      await _transport.sendMessage(peerDeviceId, message);
      return;
    }

    final nextHop = _routingTable.getNextHop(peerDeviceId);
    if (nextHop != null && directPeerIds.contains(nextHop)) {
      final meshMsg = _attachMesh(message, targetId: peerDeviceId);
      await _transport.sendMessage(nextHop, meshMsg);
      return;
    }

    final meshMsg = _attachMesh(message, targetId: peerDeviceId);
    await _floodExcluding(meshMsg, exclude: {});
  }

  @override
  Future<void> broadcastMessage(P2PMessage message) async {
    final meshMsg = _attachMesh(message);
    _seenMessages.add(meshMsg.messageId);
    await _transport.broadcastMessage(meshMsg);
  }

  void _onMessage(P2PMessage message) {
    if (message.type == P2PMessageType.routeAnnounce) {
      _handleRouteAnnounce(message);
      return;
    }

    final mesh = message.mesh;
    if (mesh == null) {
      _incomingController.add(message);
      return;
    }

    if (_seenMessages.contains(message.messageId)) return;
    _seenMessages.add(message.messageId);

    if (mesh.isExpired) return;
    if (mesh.hasVisited(deviceId)) return;

    final isForMe = message.targetId == null || message.targetId == deviceId;

    if (isForMe) {
      _incomingController.add(message);
    }

    if (message.targetId == deviceId) return;

    _relay(message, mesh);
  }

  Future<void> _relay(P2PMessage message, MeshMetadata mesh) async {
    final forwarded = message.withMesh(mesh.copyWithHop(deviceId));

    if (message.targetId != null) {
      final nextHop = _routingTable.getNextHop(message.targetId!);
      if (nextHop != null) {
        await _transport.sendMessage(nextHop, forwarded);
        return;
      }
    }

    await _floodExcluding(forwarded, exclude: {message.senderId});
  }

  Future<void> _floodExcluding(
    P2PMessage message, {
    required Set<String> exclude,
  }) async {
    final mesh = message.mesh;
    final visited = mesh?.hopPath.toSet() ?? {};
    final skipIds = {...exclude, ...visited, deviceId};

    for (final peer in _transport.currentConnectedPeers) {
      if (skipIds.contains(peer.deviceId)) continue;
      await _transport.sendMessage(peer.deviceId, message);
    }
  }

  P2PMessage _attachMesh(P2PMessage message, {String? targetId}) {
    if (message.mesh != null) return message;

    final msg = targetId != null
        ? P2PMessage(
            type: message.type,
            senderId: message.senderId,
            targetId: targetId,
            messageId: message.messageId,
            payload: message.payload,
            timestamp: message.timestamp,
          )
        : message;

    return msg.withMesh(
      MeshMetadata(originId: deviceId, ttl: 5, hopPath: [deviceId]),
    );
  }

  void _handleRouteAnnounce(P2PMessage message) {
    final reachable = message.payload['reachable'] as Map<String, dynamic>?;
    if (reachable == null) return;
    final peerInfo = message.payload['peers'] as Map<String, dynamic>? ?? {};

    for (final entry in reachable.entries) {
      final targetId = entry.key;
      final hops = (entry.value as int) + 1;
      if (targetId == deviceId) continue;
      _routingTable.updateRoute(targetId, message.senderId, hops);

      final info = peerInfo[targetId] as Map<String, dynamic>?;
      _routedPeers[targetId] = P2PPeer(
        deviceId: targetId,
        displayName: info?['displayName'] as String? ?? targetId,
        platform: info?['platform'] as String? ?? 'Mesh',
        lastSeen: DateTime.now(),
        isConnected: true,
      );
    }

    _emitConnectedPeers();
  }

  void _onPeersChanged(List<P2PPeer> peers) {
    final connectedIds = peers.map((p) => p.deviceId).toSet();

    for (final peer in peers) {
      _routingTable.updateRoute(peer.deviceId, peer.deviceId, 1);
      _routedPeers[peer.deviceId] = peer;
    }

    final staleRoutes = <String>[];
    for (final entry in _routingTable.getReachablePeers().entries) {
      final nextHop = _routingTable.getNextHop(entry.key);
      if (nextHop != null && !connectedIds.contains(nextHop)) {
        staleRoutes.add(nextHop);
      }
    }
    for (final id in staleRoutes) {
      _routingTable.removeRoutesVia(id);
    }

    _routedPeers.removeWhere(
      (id, _) => !connectedIds.contains(id) && !_routingTable.hasRoute(id),
    );

    _emitConnectedPeers();
    _broadcastRouteAnnounce();
  }

  void _emitConnectedPeers() {
    if (!_connectedController.isClosed) {
      _connectedController.add(currentConnectedPeers);
    }
  }

  void _startRouteAnnouncements() {
    _announceTimer?.cancel();
    _announceTimer = Timer.periodic(
      const Duration(seconds: 15),
      (_) => _broadcastRouteAnnounce(),
    );
  }

  void _broadcastRouteAnnounce() {
    final reachable = _routingTable.getReachablePeers();
    if (reachable.isEmpty) return;

    final peerInfo = <String, Map<String, dynamic>>{};
    for (final peer in currentConnectedPeers) {
      peerInfo[peer.deviceId] = {
        'displayName': peer.displayName,
        if (peer.platform != null) 'platform': peer.platform,
      };
    }

    final announce = P2PMessage.routeAnnounce(
      deviceId: deviceId,
      reachablePeers: reachable,
      peerInfo: peerInfo,
    );
    _transport.broadcastMessage(announce);
  }

  @override
  Future<void> dispose() async {
    _announceTimer?.cancel();
    _messageSubscription?.cancel();
    _connectedSubscription?.cancel();
    _incomingController.close();
    _connectedController.close();
    _routingTable.clear();
    _seenMessages.clear();
    _routedPeers.clear();
    await _transport.dispose();
  }
}
