import 'dart:async';
import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';

import 'package:tiptap_tour/domain/entities/p2p_peer.dart';
import 'package:tiptap_tour/domain/enums/connection_state.dart';
import 'package:tiptap_tour/infrastructure/p2p/ble/ble_chunker.dart';
import 'package:tiptap_tour/infrastructure/p2p/ble/ble_constants.dart';
import 'package:tiptap_tour/infrastructure/p2p/ble/ble_gatt_server.dart';
import 'package:tiptap_tour/infrastructure/p2p/p2p_message.dart';
import 'package:tiptap_tour/infrastructure/p2p/transport.dart';

class _BleConnection {
  final BluetoothDevice device;
  final BluetoothCharacteristic? writeChar;
  final BluetoothCharacteristic? notifyChar;
  final P2PPeer peer;
  final BleChunkAssembler assembler = BleChunkAssembler();
  int negotiatedMtu;

  _BleConnection({
    required this.device,
    required this.peer,
    this.writeChar,
    this.notifyChar,
    this.negotiatedMtu = BleConstants.defaultMtu,
  });
}

class BleTransport implements P2PTransport {
  @override
  final String deviceId;
  @override
  final String displayName;

  BleTransport({required this.deviceId, required this.displayName});

  final BleGattServer _gattServer = BleGattServer();
  final Map<String, _BleConnection> _connections = {};
  final Map<String, P2PPeer> _discoveredPeers = {};
  final Map<String, BleChunkAssembler> _gattAssemblers = {};

  Timer? _scanTimer;
  Timer? _heartbeatTimer;
  StreamSubscription<List<ScanResult>>? _scanSubscription;
  StreamSubscription<GattIncomingData>? _gattDataSubscription;
  StreamSubscription<List<String>>? _gattDeviceSubscription;

  final _connectionStateController =
      StreamController<P2PConnectionState>.broadcast();
  final _discoveredPeersController =
      StreamController<List<P2PPeer>>.broadcast();
  final _connectedPeersController =
      StreamController<List<P2PPeer>>.broadcast();
  final _incomingMessageController = StreamController<P2PMessage>.broadcast();

  P2PConnectionState _state = P2PConnectionState.disconnected;

  @override
  P2PConnectionState get currentState => _state;
  @override
  List<P2PPeer> get currentDiscoveredPeers =>
      _discoveredPeers.values.toList();
  @override
  List<P2PPeer> get currentConnectedPeers =>
      _connections.values.map((c) => c.peer).toList();

  @override
  Stream<P2PConnectionState> get connectionState =>
      _connectionStateController.stream;
  @override
  Stream<List<P2PPeer>> get discoveredPeers =>
      _discoveredPeersController.stream;
  @override
  Stream<List<P2PPeer>> get connectedPeers =>
      _connectedPeersController.stream;
  @override
  Stream<P2PMessage> get incomingMessages =>
      _incomingMessageController.stream;

  void _setState(P2PConnectionState state) {
    _state = state;
    _connectionStateController.add(state);
  }

  @override
  Future<void> startServer() async {
    await _gattServer.start(deviceId: deviceId, displayName: displayName);
    _listenToGattServer();
    _startHeartbeat();
  }

  @override
  Future<void> startDiscovery() async {
    _setState(P2PConnectionState.discovering);

    await startServer();
    await _gattServer.startAdvertising();

    _startDutyCycledScan();
  }

  @override
  Future<void> stopDiscovery() async {
    _scanTimer?.cancel();
    _scanTimer = null;
    _scanSubscription?.cancel();
    _scanSubscription = null;

    try {
      await FlutterBluePlus.stopScan();
    } catch (_) {}

    await _gattServer.stopAdvertising();

    if (_connections.isEmpty) {
      _setState(P2PConnectionState.disconnected);
    }
  }

  @override
  Future<void> connectToPeer(P2PPeer peer) async {
    if (_connections.containsKey(peer.deviceId)) return;
    _setState(P2PConnectionState.connecting);

    try {
      final bleId = _extractBleId(peer.deviceId);
      final device = BluetoothDevice.fromId(bleId);

      await device.connect(
        timeout: BleConstants.connectionTimeout,
        autoConnect: false,
      );

      final mtu = await device.requestMtu(BleConstants.preferredMtu);
      final services = await device.discoverServices();

      final service = services.firstWhere(
        (s) => s.uuid == Guid(BleConstants.serviceUuid),
        orElse: () => throw Exception('Tiptap service not found'),
      );

      BluetoothCharacteristic? writeChar;
      BluetoothCharacteristic? notifyChar;
      BluetoothCharacteristic? infoChar;

      for (final c in service.characteristics) {
        final uuid = c.uuid.toString().toLowerCase();
        if (uuid == BleConstants.messageWriteCharUuid) writeChar = c;
        if (uuid == BleConstants.messageNotifyCharUuid) notifyChar = c;
        if (uuid == BleConstants.deviceInfoCharUuid) infoChar = c;
      }

      String remoteName = peer.displayName;
      String remoteDeviceId = peer.deviceId;

      if (infoChar != null) {
        final infoBytes = await infoChar.read();
        final info = utf8.decode(infoBytes);
        final parts = info.split('|');
        if (parts.length >= 2) {
          remoteDeviceId = parts[0];
          remoteName = parts[1];
        }
      }

      final connectedPeer = P2PPeer(
        deviceId: remoteDeviceId,
        displayName: remoteName,
        platform: 'ble',
        lastSeen: DateTime.now(),
        isConnected: true,
      );

      final connection = _BleConnection(
        device: device,
        peer: connectedPeer,
        writeChar: writeChar,
        notifyChar: notifyChar,
        negotiatedMtu: mtu,
      );

      _connections[remoteDeviceId] = connection;

      if (notifyChar != null) {
        await notifyChar.setNotifyValue(true);
        notifyChar.onValueReceived.listen(
          (data) => _onBleDataReceived(
              remoteDeviceId, Uint8List.fromList(data)),
        );
      }

      device.connectionState.listen((state) {
        if (state == BluetoothConnectionState.disconnected) {
          _handleDisconnect(remoteDeviceId);
        }
      });

      final handshake = P2PMessage.handshake(
        deviceId: deviceId,
        displayName: displayName,
      );
      await _sendViaGatt(connection, handshake);

      _setState(P2PConnectionState.connected);
      _notifyConnectedPeers();
    } catch (e) {
      _setState(
        _connections.isEmpty
            ? P2PConnectionState.disconnected
            : P2PConnectionState.connected,
      );
      throw Exception('BLE connection failed: $e');
    }
  }

  @override
  Future<void> disconnectFromPeer(String peerDeviceId) async {
    final connection = _connections.remove(peerDeviceId);
    if (connection != null) {
      try {
        final msg = P2PMessage.disconnect(deviceId: deviceId);
        await _sendViaGatt(connection, msg);
        await Future.delayed(const Duration(milliseconds: 100));
      } catch (_) {}
      try {
        await connection.device.disconnect();
      } catch (_) {}
      connection.assembler.clear();
      _notifyConnectedPeers();
    }
    if (_connections.isEmpty) {
      _setState(P2PConnectionState.disconnected);
    }
  }

  @override
  Future<void> sendMessage(String peerDeviceId, P2PMessage message) async {
    final connection = _connections[peerDeviceId];
    if (connection != null) {
      await _sendViaGatt(connection, message);
      return;
    }

    await _sendViaGattServer(peerDeviceId, message);
  }

  @override
  Future<void> broadcastMessage(P2PMessage message) async {
    final encoded = message.encode();
    for (final connection in _connections.values) {
      await _sendChunked(connection, encoded);
    }
    await _broadcastViaGattServer(encoded);
  }

  Future<void> _sendViaGatt(_BleConnection connection, P2PMessage message) async {
    final encoded = message.encode();
    await _sendChunked(connection, encoded);
  }

  Future<void> _sendChunked(_BleConnection connection, Uint8List data) async {
    final writeChar = connection.writeChar;
    if (writeChar == null) return;

    final allowNoResponse = writeChar.properties.writeWithoutResponse;
    final chunks = BleChunker.split(data, connection.negotiatedMtu);
    for (final chunk in chunks) {
      try {
        await writeChar
            .write(chunk.encode().toList(), withoutResponse: allowNoResponse)
            .timeout(const Duration(seconds: 5));
      } catch (e) {
        throw Exception('BLE write failed: $e');
      }
    }
  }

  Future<void> _sendViaGattServer(String peerDeviceId, P2PMessage message) async {
    final encoded = message.encode();
    final chunks = BleChunker.split(encoded, BleConstants.defaultMtu);
    for (final chunk in chunks) {
      await _gattServer.sendNotification(
        chunk.encode(),
        targetDeviceId: peerDeviceId,
      );
    }
  }

  Future<void> _broadcastViaGattServer(Uint8List data) async {
    final chunks = BleChunker.split(data, BleConstants.defaultMtu);
    for (final chunk in chunks) {
      await _gattServer.sendNotification(chunk.encode());
    }
  }

  void _onBleDataReceived(String peerId, Uint8List data) {
    final chunk = BleChunk.decode(data);
    if (chunk == null) return;

    final connection = _connections[peerId];
    if (connection == null) return;

    final assembled = connection.assembler.addChunk(chunk);
    if (assembled == null) return;

    _processAssembledMessage(peerId, assembled);
  }

  void _onGattDataReceived(GattIncomingData incoming) {
    final chunk = BleChunk.decode(incoming.data);
    if (chunk == null) return;

    final assembler =
        _gattAssemblers.putIfAbsent(incoming.centralId, BleChunkAssembler.new);

    final assembled = assembler.addChunk(chunk);
    if (assembled == null) return;

    _processAssembledMessage(incoming.centralId, assembled);
  }

  void _processAssembledMessage(String peerId, Uint8List data) {
    final message = P2PMessage.decodeFrom(data);
    if (message == null) return;

    switch (message.type) {
      case P2PMessageType.handshake:
        _handleHandshake(peerId, message);
      case P2PMessageType.handshakeAck:
        _handleHandshakeAck(peerId, message);
      case P2PMessageType.disconnect:
        _handleDisconnect(peerId);
      case P2PMessageType.heartbeat:
        break;
      default:
        _incomingMessageController.add(message);
    }
  }

  void _handleHandshake(String rawPeerId, P2PMessage message) {
    final peerName = message.payload['displayName'] as String? ?? 'Unknown';

    final oldConn = _connections.remove(rawPeerId);

    final peer = P2PPeer(
      deviceId: message.senderId,
      displayName: peerName,
      platform: 'ble',
      lastSeen: DateTime.now(),
      isConnected: true,
    );

    if (oldConn != null) {
      _connections[message.senderId] = _BleConnection(
        device: oldConn.device,
        peer: peer,
        writeChar: oldConn.writeChar,
        notifyChar: oldConn.notifyChar,
        negotiatedMtu: oldConn.negotiatedMtu,
      );
    } else {
      _connections[message.senderId] = _BleConnection(
        device: BluetoothDevice.fromId(_extractBleId(rawPeerId)),
        peer: peer,
      );
    }

    final ack = P2PMessage.handshakeAck(
      deviceId: deviceId,
      displayName: displayName,
    );
    sendMessage(message.senderId, ack);

    _setState(P2PConnectionState.connected);
    _notifyConnectedPeers();
  }

  void _handleHandshakeAck(String rawPeerId, P2PMessage message) {
    final peerName = message.payload['displayName'] as String? ?? 'Unknown';

    final oldConn = _connections.remove(rawPeerId);

    final peer = P2PPeer(
      deviceId: message.senderId,
      displayName: peerName,
      platform: 'ble',
      lastSeen: DateTime.now(),
      isConnected: true,
    );

    if (oldConn != null) {
      _connections[message.senderId] = _BleConnection(
        device: oldConn.device,
        peer: peer,
        writeChar: oldConn.writeChar,
        notifyChar: oldConn.notifyChar,
        negotiatedMtu: oldConn.negotiatedMtu,
      );
    }

    _setState(P2PConnectionState.connected);
    _notifyConnectedPeers();
  }

  void _handleDisconnect(String peerId) {
    final connection = _connections.remove(peerId);
    if (connection != null) {
      connection.assembler.clear();
      try {
        connection.device.disconnect();
      } catch (_) {}
    }
    _gattAssemblers.remove(peerId);
    _notifyConnectedPeers();

    if (_connections.isEmpty && _state != P2PConnectionState.discovering) {
      _setState(P2PConnectionState.disconnected);
    }
  }

  void _startDutyCycledScan() {
    _runScanCycle();
    _scanTimer = Timer.periodic(
      BleConstants.scanDuration + BleConstants.scanPause,
      (_) => _runScanCycle(),
    );
  }

  Future<void> _runScanCycle() async {
    _scanSubscription?.cancel();
    _scanSubscription = FlutterBluePlus.onScanResults.listen(_onScanResults);

    try {
      await FlutterBluePlus.startScan(
        withServices: [Guid(BleConstants.serviceUuid)],
        timeout: BleConstants.scanDuration,
        androidScanMode: AndroidScanMode.lowPower,
      );
    } catch (_) {}
  }

  void _onScanResults(List<ScanResult> results) {
    for (final result in results) {
      final bleAddr = result.device.remoteId.str;
      if (bleAddr == deviceId) continue;

      final name = result.device.platformName.isNotEmpty
          ? result.device.platformName
          : 'BLE Device';

      final peer = P2PPeer(
        deviceId: 'ble:$bleAddr',
        displayName: name,
        platform: 'ble',
        lastSeen: DateTime.now(),
      );

      _discoveredPeers[peer.deviceId] = peer;
    }

    _cleanStalePeers();
    _discoveredPeersController.add(_discoveredPeers.values.toList());
  }

  void _cleanStalePeers() {
    final cutoff = DateTime.now().subtract(const Duration(seconds: 30));
    _discoveredPeers.removeWhere((_, peer) => peer.lastSeen.isBefore(cutoff));
  }

  void _listenToGattServer() {
    _gattDataSubscription = _gattServer.incomingData.listen(_onGattDataReceived);
    _gattDeviceSubscription = _gattServer.connectedDevices.listen((_) {});
  }

  void _startHeartbeat() {
    _heartbeatTimer?.cancel();
    _heartbeatTimer = Timer.periodic(BleConstants.heartbeatInterval, (_) {
      final hb = P2PMessage.heartbeat(deviceId: deviceId);
      broadcastMessage(hb);
    });
  }

  String _extractBleId(String peerId) {
    if (peerId.startsWith('ble:')) return peerId.substring(4);
    return peerId;
  }

  void _notifyConnectedPeers() {
    _connectedPeersController
        .add(_connections.values.map((c) => c.peer).toList());
  }

  @override
  Future<void> dispose() async {
    _scanTimer?.cancel();
    _heartbeatTimer?.cancel();
    _scanSubscription?.cancel();
    _gattDataSubscription?.cancel();
    _gattDeviceSubscription?.cancel();

    try {
      await FlutterBluePlus.stopScan();
    } catch (_) {}

    for (final connection in _connections.values) {
      try {
        await connection.device.disconnect();
      } catch (_) {}
      connection.assembler.clear();
    }
    _connections.clear();
    _gattAssemblers.clear();

    await _gattServer.stop();
    _gattServer.dispose();

    _connectionStateController.close();
    _discoveredPeersController.close();
    _connectedPeersController.close();
    _incomingMessageController.close();
  }
}
