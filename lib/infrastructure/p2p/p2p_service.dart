import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:tiptap_tour/domain/entities/p2p_peer.dart';
import 'package:tiptap_tour/domain/enums/connection_state.dart';
import 'package:tiptap_tour/infrastructure/p2p/p2p_message.dart';

class _PeerConnection {
  final Socket socket;
  final P2PPeer peer;
  final BytesBuilder _buffer = BytesBuilder();
  StreamSubscription<Uint8List>? _subscription;

  _PeerConnection({required this.socket, required this.peer});

  void dispose() {
    _subscription?.cancel();
    socket.destroy();
  }
}

class P2PService {
  final String deviceId;
  final String displayName;

  P2PService({required this.deviceId, required this.displayName});

  ServerSocket? _tcpServer;
  RawDatagramSocket? _udpSocket;
  Timer? _discoveryTimer;
  Timer? _heartbeatTimer;

  int _tcpPort = 0;

  final Map<String, _PeerConnection> _connections = {};
  final Map<String, P2PPeer> _discoveredPeers = {};

  final _connectionStateController =
      StreamController<P2PConnectionState>.broadcast();
  final _discoveredPeersController =
      StreamController<List<P2PPeer>>.broadcast();
  final _connectedPeersController =
      StreamController<List<P2PPeer>>.broadcast();
  final _incomingMessageController =
      StreamController<P2PMessage>.broadcast();

  Stream<P2PConnectionState> get connectionState =>
      _connectionStateController.stream;
  Stream<List<P2PPeer>> get discoveredPeers =>
      _discoveredPeersController.stream;
  Stream<List<P2PPeer>> get connectedPeers =>
      _connectedPeersController.stream;
  Stream<P2PMessage> get incomingMessages =>
      _incomingMessageController.stream;

  P2PConnectionState _state = P2PConnectionState.disconnected;
  P2PConnectionState get currentState => _state;

  List<P2PPeer> get currentDiscoveredPeers =>
      _discoveredPeers.values.toList();
  List<P2PPeer> get currentConnectedPeers =>
      _connections.values.map((c) => c.peer).toList();

  void _setState(P2PConnectionState state) {
    _state = state;
    _connectionStateController.add(state);
  }

  Future<void> startServer() async {
    if (_tcpServer != null) return;

    _tcpServer = await ServerSocket.bind(InternetAddress.anyIPv4, 0);
    _tcpPort = _tcpServer!.port;

    _tcpServer!.listen(_handleIncomingConnection);
    _startHeartbeat();
  }

  Future<void> startDiscovery() async {
    _setState(P2PConnectionState.discovering);
    await startServer();

    _udpSocket = await RawDatagramSocket.bind(
      InternetAddress.anyIPv4,
      _udpListenPort,
      reuseAddress: true,
      reusePort: true,
    );
    _udpSocket!.broadcastEnabled = true;
    _udpSocket!.multicastLoopback = false;

    _udpSocket!.listen((event) {
      if (event == RawSocketEvent.read) {
        final datagram = _udpSocket!.receive();
        if (datagram != null) {
          _handleDiscoveryPacket(datagram);
        }
      }
    });

    _broadcastPresence();
    _discoveryTimer = Timer.periodic(
      const Duration(seconds: 3),
      (_) => _broadcastPresence(),
    );
  }

  Future<void> stopDiscovery() async {
    _discoveryTimer?.cancel();
    _discoveryTimer = null;
    _udpSocket?.close();
    _udpSocket = null;
    if (_connections.isEmpty) {
      _setState(P2PConnectionState.disconnected);
    }
  }

  Future<void> connectToPeer(P2PPeer peer) async {
    if (_connections.containsKey(peer.deviceId)) return;

    _setState(P2PConnectionState.connecting);

    try {
      final parts = peer.deviceId.split('@');
      if (parts.length < 2) return;

      final host = parts[1].split(':')[0];
      final port = int.parse(parts[1].split(':')[1]);

      final socket = await Socket.connect(
        host,
        port,
        timeout: const Duration(seconds: 10),
      );

      final connection = _PeerConnection(socket: socket, peer: peer);
      _connections[peer.deviceId] = connection;
      _listenToSocket(connection);

      final handshake = P2PMessage.handshake(
        deviceId: deviceId,
        displayName: displayName,
      );
      _sendToSocket(socket, handshake);

      _setState(P2PConnectionState.connected);
      _notifyConnectedPeers();
    } catch (e) {
      _setState(P2PConnectionState.error);
      rethrow;
    }
  }

  Future<void> disconnectFromPeer(String peerDeviceId) async {
    final connection = _connections.remove(peerDeviceId);
    if (connection != null) {
      try {
        final msg = P2PMessage.disconnect(deviceId: deviceId);
        _sendToSocket(connection.socket, msg);
        await Future.delayed(const Duration(milliseconds: 100));
      } catch (_) {}
      connection.dispose();
      _notifyConnectedPeers();
    }
    if (_connections.isEmpty) {
      _setState(P2PConnectionState.disconnected);
    }
  }

  Future<void> sendMessage(String peerDeviceId, P2PMessage message) async {
    final connection = _connections[peerDeviceId];
    if (connection == null) return;
    _sendToSocket(connection.socket, message);
  }

  Future<void> broadcastMessage(P2PMessage message) async {
    for (final connection in _connections.values) {
      _sendToSocket(connection.socket, message);
    }
  }

  void _handleIncomingConnection(Socket socket) {
    final tempId = '${socket.remoteAddress.address}:${socket.remotePort}';
    final tempPeer = P2PPeer(
      deviceId: tempId,
      displayName: 'Connecting...',
      lastSeen: DateTime.now(),
      isConnected: true,
    );

    final connection = _PeerConnection(socket: socket, peer: tempPeer);
    _connections[tempId] = connection;
    _listenToSocket(connection);
  }

  void _listenToSocket(_PeerConnection connection) {
    connection._subscription = connection.socket.listen(
      (data) => _handleTcpData(connection, Uint8List.fromList(data)),
      onError: (_) => _handlePeerDisconnect(connection),
      onDone: () => _handlePeerDisconnect(connection),
    );
  }

  void _handleTcpData(_PeerConnection connection, Uint8List data) {
    connection._buffer.add(data);
    _processBuffer(connection);
  }

  void _processBuffer(_PeerConnection connection) {
    while (true) {
      final bytes = connection._buffer.toBytes();
      if (bytes.length < 4) return;

      final length =
          ByteData.sublistView(Uint8List.fromList(bytes.sublist(0, 4)))
              .getUint32(0, Endian.big);

      if (bytes.length < 4 + length) return;

      final messageBytes = bytes.sublist(4, 4 + length);
      final remaining = bytes.sublist(4 + length);

      connection._buffer.clear();
      if (remaining.isNotEmpty) {
        connection._buffer.add(remaining);
      }

      final message = P2PMessage.decodeFrom(Uint8List.fromList(messageBytes));
      if (message != null) {
        _handleMessage(connection, message);
      }
    }
  }

  void _handleMessage(_PeerConnection connection, P2PMessage message) {
    switch (message.type) {
      case P2PMessageType.handshake:
        _handleHandshake(connection, message);
      case P2PMessageType.handshakeAck:
        _handleHandshakeAck(connection, message);
      case P2PMessageType.disconnect:
        _handlePeerDisconnect(connection);
      case P2PMessageType.heartbeat:
        break;
      default:
        _incomingMessageController.add(message);
    }
  }

  void _handleHandshake(_PeerConnection connection, P2PMessage message) {
    final newPeer = P2PPeer(
      deviceId: message.senderId,
      displayName: message.payload['displayName'] as String? ?? 'Unknown',
      lastSeen: DateTime.now(),
      isConnected: true,
    );

    final oldId = _connections.keys.firstWhere(
      (k) => _connections[k] == connection,
      orElse: () => '',
    );
    if (oldId.isNotEmpty && oldId != message.senderId) {
      _connections.remove(oldId);
    }

    final updatedConnection =
        _PeerConnection(socket: connection.socket, peer: newPeer);
    updatedConnection._subscription = connection._subscription;
    _connections[message.senderId] = updatedConnection;

    final ack = P2PMessage.handshakeAck(
      deviceId: deviceId,
      displayName: displayName,
    );
    _sendToSocket(connection.socket, ack);

    _setState(P2PConnectionState.connected);
    _notifyConnectedPeers();
  }

  void _handleHandshakeAck(_PeerConnection connection, P2PMessage message) {
    final newPeer = P2PPeer(
      deviceId: message.senderId,
      displayName: message.payload['displayName'] as String? ?? 'Unknown',
      lastSeen: DateTime.now(),
      isConnected: true,
    );

    final oldId = _connections.keys.firstWhere(
      (k) => _connections[k] == connection,
      orElse: () => '',
    );
    if (oldId.isNotEmpty && oldId != message.senderId) {
      _connections.remove(oldId);
    }

    final updatedConnection =
        _PeerConnection(socket: connection.socket, peer: newPeer);
    updatedConnection._subscription = connection._subscription;
    _connections[message.senderId] = updatedConnection;

    _setState(P2PConnectionState.connected);
    _notifyConnectedPeers();
  }

  void _handlePeerDisconnect(_PeerConnection connection) {
    final key = _connections.keys.firstWhere(
      (k) => _connections[k] == connection,
      orElse: () => '',
    );
    if (key.isNotEmpty) {
      _connections.remove(key);
      connection.dispose();
      _notifyConnectedPeers();
    }
    if (_connections.isEmpty && _state != P2PConnectionState.discovering) {
      _setState(P2PConnectionState.disconnected);
    }
  }

  void _sendToSocket(Socket socket, P2PMessage message) {
    try {
      socket.add(message.encode());
    } catch (_) {}
  }

  void _broadcastPresence() {
    if (_udpSocket == null) return;

    final message = P2PMessage.discovery(
      deviceId: deviceId,
      displayName: displayName,
      tcpPort: _tcpPort,
    );

    final data = utf8.encode(jsonEncode(message.toJson()));

    for (final address in _broadcastAddresses) {
      try {
        _udpSocket!.send(data, InternetAddress(address), _udpBroadcastPort);
      } catch (_) {}
    }
  }

  void _handleDiscoveryPacket(Datagram datagram) {
    try {
      final jsonStr = utf8.decode(datagram.data);
      final json = jsonDecode(jsonStr) as Map<String, dynamic>;
      final message = P2PMessage.fromJson(json);

      if (message.senderId == deviceId) return;

      final tcpPort = message.payload['tcpPort'] as int;
      final peerAddress = datagram.address.address;
      final peerId = '${message.senderId}@$peerAddress:$tcpPort';

      final peer = P2PPeer(
        deviceId: peerId,
        displayName:
            message.payload['displayName'] as String? ?? 'Unknown Device',
        platform: message.payload['platform'] as String?,
        lastSeen: DateTime.now(),
      );

      _discoveredPeers[peerId] = peer;
      _cleanStalePeers();
      _discoveredPeersController.add(_discoveredPeers.values.toList());
    } catch (_) {}
  }

  void _cleanStalePeers() {
    final cutoff = DateTime.now().subtract(const Duration(seconds: 15));
    _discoveredPeers.removeWhere((_, peer) => peer.lastSeen.isBefore(cutoff));
  }

  void _startHeartbeat() {
    _heartbeatTimer?.cancel();
    _heartbeatTimer = Timer.periodic(const Duration(seconds: 10), (_) {
      final hb = P2PMessage.heartbeat(deviceId: deviceId);
      for (final connection in _connections.values) {
        _sendToSocket(connection.socket, hb);
      }
    });
  }

  Future<void> dispose() async {
    _discoveryTimer?.cancel();
    _heartbeatTimer?.cancel();
    _udpSocket?.close();

    for (final connection in _connections.values) {
      connection.dispose();
    }
    _connections.clear();

    await _tcpServer?.close();
    _tcpServer = null;

    _connectionStateController.close();
    _discoveredPeersController.close();
    _connectedPeersController.close();
    _incomingMessageController.close();
  }

  void _notifyConnectedPeers() {
    _connectedPeersController
        .add(_connections.values.map((c) => c.peer).toList());
  }

  static const int _udpListenPort = 41234;
  static const int _udpBroadcastPort = 41234;

  static List<String> get _broadcastAddresses =>
      ['255.255.255.255', '192.168.1.255', '10.0.0.255', '172.16.0.255'];
}
