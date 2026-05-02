import 'dart:async';

import 'package:tiptap_tour/domain/entities/p2p_peer.dart';
import 'package:tiptap_tour/domain/enums/connection_state.dart';
import 'package:tiptap_tour/infrastructure/p2p/mesh/routing_table.dart';
import 'package:tiptap_tour/infrastructure/p2p/mesh/seen_message_cache.dart';
import 'package:tiptap_tour/infrastructure/p2p/p2p_message.dart';
import 'package:tiptap_tour/infrastructure/p2p/transport.dart';

class MeshRouter implements P2PTransport {
  final P2PTransport _transport;
  final RoutingTable _routingTable = RoutingTable();
  final SeenMessageCache _seenMessages = SeenMessageCache();

  final _incomingController = StreamController<P2PMessage>.broadcast();
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
  List<P2PPeer> get currentDiscoveredPeers =>
      _transport.currentDiscoveredPeers;
  @override
  List<P2PPeer> get currentConnectedPeers =>
      _transport.currentConnectedPeers;

  @override
  Stream<P2PConnectionState> get connectionState =>
      _transport.connectionState;
  @override
  Stream<List<P2PPeer>> get discoveredPeers => _transport.discoveredPeers;
  @override
  Stream<List<P2PPeer>> get connectedPeers => _transport.connectedPeers;

  @override
  Stream<P2PMessage> get incomingMessages => _incomingController.stream;

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
    await _transport.disconnectFromPeer(peerDeviceId);
    _routingTable.removeRoutesVia(peerDeviceId);
  }

  @override
  Future<void> sendMessage(String peerDeviceId, P2PMessage message) async {
    final directPeerIds =
        currentConnectedPeers.map((p) => p.deviceId).toSet();

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

    final isForMe =
        message.targetId == null || message.targetId == deviceId;

    if (isForMe) {
      _incomingController.add(message);
    }

    if (message.targetId == deviceId) return;

    _relay(message, mesh);
  }

  Future<void> _relay(P2PMessage message, MeshMetadata mesh) async {
    final forwarded = message
        .forRelay(relaySenderId: deviceId)
        .withMesh(mesh.copyWithHop(deviceId));

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

    for (final peer in currentConnectedPeers) {
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

    return msg.withMesh(MeshMetadata(
      originId: deviceId,
      ttl: 5,
      hopPath: [deviceId],
    ));
  }

  void _handleRouteAnnounce(P2PMessage message) {
    final reachable = message.payload['reachable'] as Map<String, dynamic>?;
    if (reachable == null) return;

    for (final entry in reachable.entries) {
      final targetId = entry.key;
      final hops = (entry.value as int) + 1;
      if (targetId == deviceId) continue;
      _routingTable.updateRoute(targetId, message.senderId, hops);
    }
  }

  void _onPeersChanged(List<P2PPeer> peers) {
    final connectedIds = peers.map((p) => p.deviceId).toSet();

    for (final peer in peers) {
      _routingTable.updateRoute(peer.deviceId, peer.deviceId, 1);
    }

    final staleRoutes = <String>[];
    for (final entry
        in _routingTable.getReachablePeers().entries) {
      final nextHop = _routingTable.getNextHop(entry.key);
      if (nextHop != null && !connectedIds.contains(nextHop)) {
        staleRoutes.add(nextHop);
      }
    }
    for (final id in staleRoutes) {
      _routingTable.removeRoutesVia(id);
    }

    _broadcastRouteAnnounce();
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

    final announce = P2PMessage.routeAnnounce(
      deviceId: deviceId,
      reachablePeers: reachable,
    );
    _transport.broadcastMessage(announce);
  }

  @override
  Future<void> dispose() async {
    _announceTimer?.cancel();
    _messageSubscription?.cancel();
    _connectedSubscription?.cancel();
    _incomingController.close();
    _routingTable.clear();
    _seenMessages.clear();
    await _transport.dispose();
  }
}
