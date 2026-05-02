import 'package:tiptap_tour/domain/entities/p2p_peer.dart';
import 'package:tiptap_tour/domain/enums/connection_state.dart';
import 'package:tiptap_tour/infrastructure/p2p/p2p_message.dart';

abstract class P2PTransport {
  String get deviceId;
  String get displayName;

  P2PConnectionState get currentState;
  List<P2PPeer> get currentDiscoveredPeers;
  List<P2PPeer> get currentConnectedPeers;

  Stream<P2PConnectionState> get connectionState;
  Stream<List<P2PPeer>> get discoveredPeers;
  Stream<List<P2PPeer>> get connectedPeers;
  Stream<P2PMessage> get incomingMessages;

  Future<void> startServer();
  Future<void> startDiscovery();
  Future<void> stopDiscovery();

  Future<void> connectToPeer(P2PPeer peer);
  Future<void> disconnectFromPeer(String peerDeviceId);

  Future<void> sendMessage(String peerDeviceId, P2PMessage message);
  Future<void> broadcastMessage(P2PMessage message);

  Future<void> dispose();
}
