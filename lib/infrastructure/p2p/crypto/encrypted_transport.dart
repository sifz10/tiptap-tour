import 'dart:async';
import 'dart:convert';

import 'package:cryptography/cryptography.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:tiptap_tour/domain/entities/p2p_peer.dart';
import 'package:tiptap_tour/domain/enums/connection_state.dart';
import 'package:tiptap_tour/infrastructure/p2p/crypto/key_store.dart';
import 'package:tiptap_tour/infrastructure/p2p/p2p_message.dart';
import 'package:tiptap_tour/infrastructure/p2p/transport.dart';

class EncryptedTransport implements P2PTransport {
  final P2PTransport _transport;
  final P2PKeyStore _keyStore;
  final X25519 _x25519 = X25519();
  final AesGcm _aesGcm = AesGcm.with256bits();

  final _incomingController = StreamController<P2PMessage>.broadcast();
  final Map<String, SimplePublicKey> _peerKeys = {};
  final Map<String, SecretKey> _sharedKeys = {};

  StreamSubscription<P2PMessage>? _messageSubscription;
  StreamSubscription<List<P2PPeer>>? _connectedSubscription;
  Future<SimpleKeyPair>? _identityFuture;

  EncryptedTransport(this._transport, {P2PKeyStore? keyStore})
    : _keyStore = keyStore ?? P2PKeyStore(Hive.box('settings'));

  void start() {
    _identityFuture = _keyStore.loadOrCreateIdentity();
    _messageSubscription = _transport.incomingMessages.listen(_onMessage);
    _connectedSubscription = _transport.connectedPeers.listen((peers) {
      if (peers.isNotEmpty) {
        announceKey();
      }
    });
  }

  Future<void> announceKey() async {
    final keyPair = await _identity;
    final publicKey = await keyPair.extractPublicKey();
    final message = P2PMessage.keyAnnounce(
      deviceId: deviceId,
      publicKey: base64Encode(publicKey.bytes),
    );
    await _transport.broadcastMessage(message);
  }

  Future<SimpleKeyPair> get _identity async =>
      _identityFuture ??= _keyStore.loadOrCreateIdentity();

  @override
  String get deviceId => _transport.deviceId;

  @override
  String get displayName => _transport.displayName;

  @override
  P2PConnectionState get currentState => _transport.currentState;

  @override
  List<P2PPeer> get currentDiscoveredPeers => _transport.currentDiscoveredPeers;

  @override
  List<P2PPeer> get currentConnectedPeers => _transport.currentConnectedPeers;

  @override
  Stream<P2PConnectionState> get connectionState => _transport.connectionState;

  @override
  Stream<List<P2PPeer>> get discoveredPeers => _transport.discoveredPeers;

  @override
  Stream<List<P2PPeer>> get connectedPeers => _transport.connectedPeers;

  @override
  Stream<P2PMessage> get incomingMessages => _incomingController.stream;

  Set<String> get encryptedPeerIds => Set.unmodifiable(_sharedKeys.keys);

  bool hasEncryptionFor(String peerDeviceId) =>
      _sharedKeys.containsKey(_normalizeId(peerDeviceId));

  String _normalizeId(String peerDeviceId) {
    final atIndex = peerDeviceId.indexOf('@');
    return atIndex > 0 ? peerDeviceId.substring(0, atIndex) : peerDeviceId;
  }

  @override
  Future<void> startServer() async {
    await _identity;
    await _transport.startServer();
    await announceKey();
  }

  @override
  Future<void> startDiscovery() async {
    await _identity;
    await _transport.startDiscovery();
    await announceKey();
  }

  @override
  Future<void> stopDiscovery() => _transport.stopDiscovery();

  @override
  Future<void> connectToPeer(P2PPeer peer) async {
    await _transport.connectToPeer(peer);
    await announceKey();
  }

  @override
  Future<void> disconnectFromPeer(String peerDeviceId) async {
    final normalizedId = _normalizeId(peerDeviceId);
    _peerKeys.remove(normalizedId);
    _sharedKeys.remove(normalizedId);
    await _transport.disconnectFromPeer(peerDeviceId);
  }

  @override
  Future<void> sendMessage(String peerDeviceId, P2PMessage message) async {
    final outbound = await _encryptForPeer(peerDeviceId, message);
    await _transport.sendMessage(peerDeviceId, outbound);
  }

  @override
  Future<void> broadcastMessage(P2PMessage message) async {
    if (!_shouldEncrypt(message)) {
      await _transport.broadcastMessage(message);
      return;
    }

    final peers = currentConnectedPeers;
    if (peers.isEmpty) return;

    for (final peer in peers) {
      await sendMessage(peer.deviceId, message);
    }
  }

  Future<void> _onMessage(P2PMessage message) async {
    if (message.type == P2PMessageType.keyAnnounce) {
      await _handleKeyAnnounce(message);
      return;
    }

    if (_isEncrypted(message)) {
      final decrypted = await _decrypt(message);
      if (decrypted != null) {
        _incomingController.add(decrypted);
      }
      return;
    }

    _incomingController.add(message);
  }

  Future<void> _handleKeyAnnounce(P2PMessage message) async {
    final publicKeyBase64 = message.payload['publicKey'] as String?;
    if (publicKeyBase64 == null) return;

    final publicKey = SimplePublicKey(
      base64Decode(publicKeyBase64),
      type: KeyPairType.x25519,
    );

    final peerId = _normalizeId(message.senderId);
    _peerKeys[peerId] = publicKey;
    _sharedKeys.remove(peerId);
    await _sharedKeyFor(peerId);
  }

  Future<P2PMessage> _encryptForPeer(
    String peerDeviceId,
    P2PMessage message,
  ) async {
    if (!_shouldEncrypt(message)) return message;

    final normalizedId = _normalizeId(peerDeviceId);
    final sharedKey = await _sharedKeyFor(normalizedId);
    if (sharedKey == null) {
      await announceKey();
      throw StateError('Missing encryption key for $peerDeviceId');
    }

    final secretBox = await _aesGcm.encrypt(
      utf8.encode(jsonEncode(message.payload)),
      secretKey: sharedKey,
    );

    return P2PMessage(
      type: message.type,
      senderId: message.senderId,
      targetId: message.targetId ?? peerDeviceId,
      messageId: message.messageId,
      timestamp: message.timestamp,
      payload: {
        '_encrypted': true,
        'algorithm': 'x25519-aes-256-gcm',
        'nonce': base64Encode(secretBox.nonce),
        'cipherText': base64Encode(secretBox.cipherText),
        'mac': base64Encode(secretBox.mac.bytes),
        if (message.mesh != null) '_mesh': message.mesh!.toJson(),
      },
    );
  }

  Future<P2PMessage?> _decrypt(P2PMessage message) async {
    final normalizedId = _normalizeId(message.senderId);
    final sharedKey = await _sharedKeyFor(normalizedId);
    if (sharedKey == null) {
      await announceKey();
      return null;
    }

    try {
      final clearBytes = await _aesGcm.decrypt(
        SecretBox(
          base64Decode(message.payload['cipherText'] as String),
          nonce: base64Decode(message.payload['nonce'] as String),
          mac: Mac(base64Decode(message.payload['mac'] as String)),
        ),
        secretKey: sharedKey,
      );

      return P2PMessage(
        type: message.type,
        senderId: message.senderId,
        targetId: message.targetId,
        messageId: message.messageId,
        timestamp: message.timestamp,
        payload: Map<String, dynamic>.from(
          jsonDecode(utf8.decode(clearBytes)) as Map,
        ),
      );
    } catch (_) {
      return null;
    }
  }

  Future<SecretKey?> _sharedKeyFor(String peerDeviceId) async {
    final cached = _sharedKeys[peerDeviceId];
    if (cached != null) return cached;

    final peerKey = _peerKeys[peerDeviceId];
    if (peerKey == null) return null;

    final sharedKey = await _x25519.sharedSecretKey(
      keyPair: await _identity,
      remotePublicKey: peerKey,
    );
    _sharedKeys[peerDeviceId] = sharedKey;
    return sharedKey;
  }

  bool _isEncrypted(P2PMessage message) =>
      message.payload['_encrypted'] == true;

  bool _shouldEncrypt(P2PMessage message) {
    switch (message.type) {
      case P2PMessageType.syncRequest:
      case P2PMessageType.syncResponse:
      case P2PMessageType.chatMessage:
        return true;
      case P2PMessageType.discovery:
      case P2PMessageType.handshake:
      case P2PMessageType.handshakeAck:
      case P2PMessageType.ack:
      case P2PMessageType.heartbeat:
      case P2PMessageType.disconnect:
      case P2PMessageType.routeAnnounce:
      case P2PMessageType.keyAnnounce:
        return false;
    }
  }

  @override
  Future<void> dispose() async {
    await _messageSubscription?.cancel();
    await _connectedSubscription?.cancel();
    await _incomingController.close();
    _peerKeys.clear();
    _sharedKeys.clear();
    await _transport.dispose();
  }
}
