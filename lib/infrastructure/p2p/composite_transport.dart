import 'dart:async';

import 'package:tiptap_tour/domain/entities/p2p_peer.dart';
import 'package:tiptap_tour/domain/enums/connection_state.dart';
import 'package:tiptap_tour/domain/enums/transport_type.dart';
import 'package:tiptap_tour/infrastructure/p2p/ble/ble_transport.dart';
import 'package:tiptap_tour/infrastructure/p2p/p2p_message.dart';
import 'package:tiptap_tour/infrastructure/p2p/transport.dart';
import 'package:tiptap_tour/infrastructure/p2p/wifi_transport.dart';

class CompositeTransport implements P2PTransport {
  @override
  final String deviceId;
  @override
  final String displayName;

  late final WifiTransport _wifi;
  late final BleTransport _ble;

  bool _wifiEnabled;
  bool _bleEnabled;

  final _connectionStateController =
      StreamController<P2PConnectionState>.broadcast();
  final _discoveredPeersController =
      StreamController<List<P2PPeer>>.broadcast();
  final _connectedPeersController =
      StreamController<List<P2PPeer>>.broadcast();
  final _incomingMessageController = StreamController<P2PMessage>.broadcast();

  final Map<String, TransportType> _peerTransport = {};

  StreamSubscription<P2PConnectionState>? _wifiStateSub;
  StreamSubscription<P2PConnectionState>? _bleStateSub;
  StreamSubscription<List<P2PPeer>>? _wifiDiscoveredSub;
  StreamSubscription<List<P2PPeer>>? _bleDiscoveredSub;
  StreamSubscription<List<P2PPeer>>? _wifiConnectedSub;
  StreamSubscription<List<P2PPeer>>? _bleConnectedSub;
  StreamSubscription<P2PMessage>? _wifiMessageSub;
  StreamSubscription<P2PMessage>? _bleMessageSub;

  P2PConnectionState _state = P2PConnectionState.disconnected;

  CompositeTransport({
    required this.deviceId,
    required this.displayName,
    bool enableWifi = true,
    bool enableBle = true,
  })  : _wifiEnabled = enableWifi,
        _bleEnabled = enableBle {
    _wifi = WifiTransport(deviceId: deviceId, displayName: displayName);
    _ble = BleTransport(deviceId: deviceId, displayName: displayName);
    _subscribeToTransports();
  }

  bool get wifiEnabled => _wifiEnabled;
  bool get bleEnabled => _bleEnabled;
  Map<String, TransportType> get peerTransportMap =>
      Map.unmodifiable(_peerTransport);

  @override
  P2PConnectionState get currentState => _state;

  @override
  List<P2PPeer> get currentDiscoveredPeers => _mergeDiscovered();

  @override
  List<P2PPeer> get currentConnectedPeers => _mergeConnected();

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

  void _subscribeToTransports() {
    _wifiStateSub = _wifi.connectionState.listen((_) => _emitState());
    _bleStateSub = _ble.connectionState.listen((_) => _emitState());

    _wifiDiscoveredSub =
        _wifi.discoveredPeers.listen((_) => _emitDiscovered());
    _bleDiscoveredSub =
        _ble.discoveredPeers.listen((_) => _emitDiscovered());

    _wifiConnectedSub = _wifi.connectedPeers.listen((peers) {
      for (final p in peers) {
        _peerTransport[p.deviceId] = TransportType.wifi;
      }
      _emitConnected();
    });
    _bleConnectedSub = _ble.connectedPeers.listen((peers) {
      for (final p in peers) {
        _peerTransport.putIfAbsent(p.deviceId, () => TransportType.ble);
      }
      _emitConnected();
    });

    _wifiMessageSub =
        _wifi.incomingMessages.listen(_incomingMessageController.add);
    _bleMessageSub =
        _ble.incomingMessages.listen(_incomingMessageController.add);
  }

  void _emitState() {
    final wifiState = _wifiEnabled ? _wifi.currentState : P2PConnectionState.disconnected;
    final bleState = _bleEnabled ? _ble.currentState : P2PConnectionState.disconnected;

    final newState = _resolveState(wifiState, bleState);
    if (newState != _state) {
      _state = newState;
      _connectionStateController.add(_state);
    }
  }

  P2PConnectionState _resolveState(
      P2PConnectionState a, P2PConnectionState b) {
    const priority = [
      P2PConnectionState.syncing,
      P2PConnectionState.connected,
      P2PConnectionState.connecting,
      P2PConnectionState.discovering,
      P2PConnectionState.error,
      P2PConnectionState.disconnected,
    ];
    for (final s in priority) {
      if (a == s || b == s) return s;
    }
    return P2PConnectionState.disconnected;
  }

  void _emitDiscovered() {
    _discoveredPeersController.add(_mergeDiscovered());
  }

  void _emitConnected() {
    _connectedPeersController.add(_mergeConnected());
  }

  List<P2PPeer> _mergeDiscovered() {
    final map = <String, P2PPeer>{};

    if (_wifiEnabled) {
      for (final p in _wifi.currentDiscoveredPeers) {
        map[p.deviceId] = p.copyWith(platform: 'Wi-Fi');
      }
    }
    if (_bleEnabled) {
      for (final p in _ble.currentDiscoveredPeers) {
        map.putIfAbsent(p.deviceId, () => p.copyWith(platform: 'Bluetooth'));
      }
    }
    return map.values.toList();
  }

  List<P2PPeer> _mergeConnected() {
    final map = <String, P2PPeer>{};

    if (_wifiEnabled) {
      for (final p in _wifi.currentConnectedPeers) {
        map[p.deviceId] = p.copyWith(platform: 'Wi-Fi');
      }
    }
    if (_bleEnabled) {
      for (final p in _ble.currentConnectedPeers) {
        map.putIfAbsent(p.deviceId, () => p.copyWith(platform: 'Bluetooth'));
      }
    }

    _peerTransport.removeWhere((id, _) => !map.containsKey(id));
    return map.values.toList();
  }

  TransportType _transportFor(String peerDeviceId) {
    return _peerTransport[peerDeviceId] ?? TransportType.wifi;
  }

  P2PTransport _transportInstance(TransportType type) {
    return type == TransportType.ble ? _ble : _wifi;
  }

  @override
  Future<void> startServer() async {
    if (_wifiEnabled) {
      try { await _wifi.startServer(); } catch (_) {}
    }
    if (_bleEnabled) {
      try { await _ble.startServer(); } catch (_) {}
    }
  }

  @override
  Future<void> startDiscovery() async {
    if (_wifiEnabled) {
      try { await _wifi.startDiscovery(); } catch (_) {}
    }
    if (_bleEnabled) {
      try { await _ble.startDiscovery(); } catch (_) {}
    }
  }

  @override
  Future<void> stopDiscovery() async {
    if (_wifiEnabled) {
      try { await _wifi.stopDiscovery(); } catch (_) {}
    }
    if (_bleEnabled) {
      try { await _ble.stopDiscovery(); } catch (_) {}
    }
  }

  @override
  Future<void> connectToPeer(P2PPeer peer) async {
    final type = _guessTransport(peer);
    _peerTransport[peer.deviceId] = type;
    await _transportInstance(type).connectToPeer(peer);
  }

  @override
  Future<void> disconnectFromPeer(String peerDeviceId) async {
    final type = _transportFor(peerDeviceId);
    await _transportInstance(type).disconnectFromPeer(peerDeviceId);
    _peerTransport.remove(peerDeviceId);
  }

  @override
  Future<void> sendMessage(String peerDeviceId, P2PMessage message) async {
    final type = _transportFor(peerDeviceId);
    await _transportInstance(type).sendMessage(peerDeviceId, message);
  }

  @override
  Future<void> broadcastMessage(P2PMessage message) async {
    if (_wifiEnabled) await _wifi.broadcastMessage(message);
    if (_bleEnabled) await _ble.broadcastMessage(message);
  }

  TransportType _guessTransport(P2PPeer peer) {
    if (peer.platform == 'Bluetooth' || peer.platform == 'ble') {
      return TransportType.ble;
    }
    if (peer.deviceId.startsWith('ble:')) return TransportType.ble;
    return TransportType.wifi;
  }

  void setWifiEnabled(bool enabled) {
    if (_wifiEnabled == enabled) return;
    _wifiEnabled = enabled;
    if (!enabled) {
      _wifi.stopDiscovery();
      _peerTransport.removeWhere((_, t) => t == TransportType.wifi);
    }
    _emitState();
    _emitDiscovered();
    _emitConnected();
  }

  void setBleEnabled(bool enabled) {
    if (_bleEnabled == enabled) return;
    _bleEnabled = enabled;
    if (!enabled) {
      _ble.stopDiscovery();
      _peerTransport.removeWhere((_, t) => t == TransportType.ble);
    }
    _emitState();
    _emitDiscovered();
    _emitConnected();
  }

  @override
  Future<void> dispose() async {
    _wifiStateSub?.cancel();
    _bleStateSub?.cancel();
    _wifiDiscoveredSub?.cancel();
    _bleDiscoveredSub?.cancel();
    _wifiConnectedSub?.cancel();
    _bleConnectedSub?.cancel();
    _wifiMessageSub?.cancel();
    _bleMessageSub?.cancel();

    await _wifi.dispose();
    await _ble.dispose();

    _connectionStateController.close();
    _discoveredPeersController.close();
    _connectedPeersController.close();
    _incomingMessageController.close();
  }
}
