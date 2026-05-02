import 'dart:async';
import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:path/path.dart' as p;
import 'package:tiptap_tour/domain/entities/p2p_peer.dart';
import 'package:tiptap_tour/domain/enums/connection_state.dart';
import 'package:tiptap_tour/infrastructure/p2p/crypto/encrypted_transport.dart';
import 'package:tiptap_tour/infrastructure/p2p/crypto/key_store.dart';
import 'package:tiptap_tour/infrastructure/p2p/p2p_message.dart';
import 'package:tiptap_tour/infrastructure/p2p/transport.dart';

void main() {
  late _FakeTransport aliceBase;
  late _FakeTransport bobBase;
  late EncryptedTransport alice;
  late EncryptedTransport bob;

  setUp(() async {
    final tempDir = await Directory.systemTemp.createTemp(
      'tiptap_crypto_test_',
    );
    Hive.init(p.join(tempDir.path, 'hive'));

    aliceBase = _FakeTransport(deviceId: 'alice', displayName: 'Alice');
    bobBase = _FakeTransport(deviceId: 'bob', displayName: 'Bob');
    aliceBase.linkTo(bobBase);
    bobBase.linkTo(aliceBase);

    alice = EncryptedTransport(
      aliceBase,
      keyStore: P2PKeyStore(await Hive.openBox('alice-settings')),
    )..start();
    bob = EncryptedTransport(
      bobBase,
      keyStore: P2PKeyStore(await Hive.openBox('bob-settings')),
    )..start();

    await alice.startServer();
    await bob.startServer();
    await pumpEventQueue(times: 10);
  });

  tearDown(() async {
    await alice.dispose();
    await bob.dispose();
    await Hive.close();
  });

  test('encrypts chat payload on wire and decrypts for receiver', () async {
    final received = bob.incomingMessages.firstWhere(
      (message) => message.type == P2PMessageType.chatMessage,
    );

    final message = P2PMessage.chat(
      deviceId: 'alice',
      targetId: 'bob',
      messageData: {'content': 'hidden mountain note', 'tripId': 'trip-1'},
    );

    await alice.sendMessage('bob', message);

    final wireMessage = aliceBase.sentMessages.last;
    expect(wireMessage.payload['_encrypted'], isTrue);
    expect(
      wireMessage.payload.toString(),
      isNot(contains('hidden mountain note')),
    );

    final decrypted = await received;
    expect(decrypted.payload['content'], 'hidden mountain note');
    expect(decrypted.payload['tripId'], 'trip-1');
  });
}

class _FakeTransport implements P2PTransport {
  @override
  final String deviceId;
  @override
  final String displayName;

  _FakeTransport({required this.deviceId, required this.displayName});

  final List<P2PMessage> sentMessages = [];
  final _stateController = StreamController<P2PConnectionState>.broadcast();
  final _discoveredController = StreamController<List<P2PPeer>>.broadcast();
  final _connectedController = StreamController<List<P2PPeer>>.broadcast();
  final _incomingController = StreamController<P2PMessage>.broadcast();

  _FakeTransport? _peer;

  void linkTo(_FakeTransport peer) {
    _peer = peer;
    _connectedController.add(currentConnectedPeers);
  }

  @override
  P2PConnectionState get currentState => P2PConnectionState.connected;

  @override
  List<P2PPeer> get currentDiscoveredPeers => const [];

  @override
  List<P2PPeer> get currentConnectedPeers {
    final peer = _peer;
    if (peer == null) return const [];
    return [
      P2PPeer(
        deviceId: peer.deviceId,
        displayName: peer.displayName,
        lastSeen: DateTime.now(),
        isConnected: true,
      ),
    ];
  }

  @override
  Stream<P2PConnectionState> get connectionState => _stateController.stream;

  @override
  Stream<List<P2PPeer>> get discoveredPeers => _discoveredController.stream;

  @override
  Stream<List<P2PPeer>> get connectedPeers => _connectedController.stream;

  @override
  Stream<P2PMessage> get incomingMessages => _incomingController.stream;

  @override
  Future<void> startServer() async {}

  @override
  Future<void> startDiscovery() async {}

  @override
  Future<void> stopDiscovery() async {}

  @override
  Future<void> connectToPeer(P2PPeer peer) async {}

  @override
  Future<void> disconnectFromPeer(String peerDeviceId) async {}

  @override
  Future<void> sendMessage(String peerDeviceId, P2PMessage message) async {
    sentMessages.add(message);
    _peer?._incomingController.add(message);
  }

  @override
  Future<void> broadcastMessage(P2PMessage message) async {
    await sendMessage(_peer?.deviceId ?? '', message);
  }

  @override
  Future<void> dispose() async {
    await _stateController.close();
    await _discoveredController.close();
    await _connectedController.close();
    await _incomingController.close();
  }
}
