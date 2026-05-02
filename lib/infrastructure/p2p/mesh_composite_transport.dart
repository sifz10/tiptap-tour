import 'package:tiptap_tour/domain/entities/p2p_peer.dart';
import 'package:tiptap_tour/domain/enums/connection_state.dart';
import 'package:tiptap_tour/domain/enums/transport_type.dart';
import 'package:tiptap_tour/infrastructure/p2p/composite_transport.dart';
import 'package:tiptap_tour/infrastructure/p2p/crypto/encrypted_transport.dart';
import 'package:tiptap_tour/infrastructure/p2p/mesh/mesh_router.dart';
import 'package:tiptap_tour/infrastructure/p2p/p2p_diagnostics.dart';
import 'package:tiptap_tour/infrastructure/p2p/p2p_message.dart';
import 'package:tiptap_tour/infrastructure/p2p/transport.dart';

class MeshCompositeTransport implements P2PTransport {
  final CompositeTransport _composite;
  late final MeshRouter _meshRouter;
  late final EncryptedTransport _encryptedTransport;

  MeshCompositeTransport({
    required String deviceId,
    required String displayName,
    bool enableWifi = true,
    bool enableBle = true,
  }) : _composite = CompositeTransport(
         deviceId: deviceId,
         displayName: displayName,
         enableWifi: enableWifi,
         enableBle: enableBle,
       ) {
    _meshRouter = MeshRouter(_composite)..start();
    _encryptedTransport = EncryptedTransport(_meshRouter)..start();
  }

  bool get wifiEnabled => _composite.wifiEnabled;
  bool get bleEnabled => _composite.bleEnabled;
  Map<String, TransportType> get peerTransportMap =>
      _composite.peerTransportMap;

  P2PDiagnostics get diagnostics {
    final transportMap = _composite.peerTransportMap;
    final encryptedPeerIds = _encryptedTransport.encryptedPeerIds;
    return P2PDiagnostics(
      wifiEnabled: wifiEnabled,
      bleEnabled: bleEnabled,
      peers: [
        for (final peer in _meshRouter.peerDiagnostics)
          peer.copyWith(
            encryptionReady: encryptedPeerIds.contains(peer.deviceId),
            transportLabel: peer.isDirect
                ? transportMap[peer.deviceId]?.label ?? peer.transportLabel
                : peer.transportLabel,
          ),
      ],
    );
  }

  void setWifiEnabled(bool enabled) => _composite.setWifiEnabled(enabled);
  void setBleEnabled(bool enabled) => _composite.setBleEnabled(enabled);

  @override
  String get deviceId => _encryptedTransport.deviceId;

  @override
  String get displayName => _encryptedTransport.displayName;

  @override
  P2PConnectionState get currentState => _encryptedTransport.currentState;

  @override
  List<P2PPeer> get currentDiscoveredPeers =>
      _encryptedTransport.currentDiscoveredPeers;

  @override
  List<P2PPeer> get currentConnectedPeers =>
      _encryptedTransport.currentConnectedPeers;

  @override
  Stream<P2PConnectionState> get connectionState =>
      _encryptedTransport.connectionState;

  @override
  Stream<List<P2PPeer>> get discoveredPeers =>
      _encryptedTransport.discoveredPeers;

  @override
  Stream<List<P2PPeer>> get connectedPeers =>
      _encryptedTransport.connectedPeers;

  @override
  Stream<P2PMessage> get incomingMessages =>
      _encryptedTransport.incomingMessages;

  @override
  Future<void> startServer() => _encryptedTransport.startServer();

  @override
  Future<void> startDiscovery() => _encryptedTransport.startDiscovery();

  @override
  Future<void> stopDiscovery() => _encryptedTransport.stopDiscovery();

  @override
  Future<void> connectToPeer(P2PPeer peer) =>
      _encryptedTransport.connectToPeer(peer);

  @override
  Future<void> disconnectFromPeer(String peerDeviceId) =>
      _encryptedTransport.disconnectFromPeer(peerDeviceId);

  @override
  Future<void> sendMessage(String peerDeviceId, P2PMessage message) =>
      _encryptedTransport.sendMessage(peerDeviceId, message);

  @override
  Future<void> broadcastMessage(P2PMessage message) =>
      _encryptedTransport.broadcastMessage(message);

  @override
  Future<void> dispose() => _encryptedTransport.dispose();
}
