import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:tiptap_tour/application/providers/database_provider.dart';
import 'package:tiptap_tour/domain/entities/p2p_peer.dart';
import 'package:tiptap_tour/domain/enums/connection_state.dart';
import 'package:tiptap_tour/infrastructure/p2p/composite_transport.dart';
import 'package:tiptap_tour/infrastructure/sync/sync_engine.dart';

final p2pServiceProvider = Provider<CompositeTransport>((ref) {
  final settingsBox = Hive.box('settings');
  final userId = settingsBox.get('userId', defaultValue: 'unknown') as String;
  final displayName =
      settingsBox.get('displayName', defaultValue: 'Unknown') as String;
  final wifiEnabled =
      settingsBox.get('p2pWifiEnabled', defaultValue: true) as bool;
  final bleEnabled =
      settingsBox.get('p2pBleEnabled', defaultValue: true) as bool;

  final service = CompositeTransport(
    deviceId: userId,
    displayName: displayName,
    enableWifi: wifiEnabled,
    enableBle: bleEnabled,
  );
  ref.onDispose(() => service.dispose());
  return service;
});

final syncEngineProvider = Provider<SyncEngine>((ref) {
  final db = ref.watch(databaseProvider);
  final transport = ref.watch(p2pServiceProvider);
  final settingsBox = Hive.box('settings');
  final userId = settingsBox.get('userId', defaultValue: 'unknown') as String;

  final engine = SyncEngine(
    db: db,
    p2pService: transport,
    localDeviceId: userId,
  );
  engine.start();
  ref.onDispose(() => engine.dispose());
  return engine;
});

final p2pConnectionStateProvider =
    StreamProvider<P2PConnectionState>((ref) {
  final transport = ref.watch(p2pServiceProvider);
  return transport.connectionState;
});

final discoveredPeersProvider = StreamProvider<List<P2PPeer>>((ref) {
  final transport = ref.watch(p2pServiceProvider);
  return transport.discoveredPeers;
});

final connectedPeersProvider = StreamProvider<List<P2PPeer>>((ref) {
  final transport = ref.watch(p2pServiceProvider);
  return transport.connectedPeers;
});

final syncProgressProvider = StreamProvider<SyncProgress>((ref) {
  final engine = ref.watch(syncEngineProvider);
  return engine.syncProgress;
});

class P2PController extends StateNotifier<P2PControllerState> {
  final CompositeTransport _service;
  final SyncEngine _syncEngine;

  P2PController(this._service, this._syncEngine)
      : super(P2PControllerState(
          wifiEnabled: _service.wifiEnabled,
          bleEnabled: _service.bleEnabled,
        ));

  Future<void> startDiscovery() async {
    state = state.copyWith(isScanning: true, error: null);
    try {
      await _service.startDiscovery();
    } catch (e) {
      state = state.copyWith(isScanning: false, error: e.toString());
    }
  }

  Future<void> stopDiscovery() async {
    await _service.stopDiscovery();
    state = state.copyWith(isScanning: false);
  }

  Future<void> connectToPeer(P2PPeer peer) async {
    state = state.copyWith(connectingTo: peer.deviceId, error: null);
    try {
      await _service.connectToPeer(peer);
      state = state.copyWith(connectingTo: null);
    } catch (e) {
      state = state.copyWith(connectingTo: null, error: e.toString());
    }
  }

  Future<void> disconnectFromPeer(String peerDeviceId) async {
    await _service.disconnectFromPeer(peerDeviceId);
  }

  Future<void> syncWithPeer(String peerDeviceId) async {
    state = state.copyWith(syncingWith: peerDeviceId, error: null);
    try {
      await _syncEngine.syncWithPeer(peerDeviceId);
      state = state.copyWith(syncingWith: null);
    } catch (e) {
      state = state.copyWith(syncingWith: null, error: e.toString());
    }
  }

  void setWifiEnabled(bool enabled) {
    _service.setWifiEnabled(enabled);
    Hive.box('settings').put('p2pWifiEnabled', enabled);
    state = state.copyWith(wifiEnabled: enabled);
  }

  void setBleEnabled(bool enabled) {
    _service.setBleEnabled(enabled);
    Hive.box('settings').put('p2pBleEnabled', enabled);
    state = state.copyWith(bleEnabled: enabled);
  }

  void clearError() {
    state = state.copyWith(error: null);
  }
}

class P2PControllerState {
  final bool isScanning;
  final String? connectingTo;
  final String? syncingWith;
  final String? error;
  final bool wifiEnabled;
  final bool bleEnabled;

  const P2PControllerState({
    this.isScanning = false,
    this.connectingTo,
    this.syncingWith,
    this.error,
    this.wifiEnabled = true,
    this.bleEnabled = true,
  });

  P2PControllerState copyWith({
    bool? isScanning,
    String? connectingTo,
    String? syncingWith,
    String? error,
    bool? wifiEnabled,
    bool? bleEnabled,
  }) {
    return P2PControllerState(
      isScanning: isScanning ?? this.isScanning,
      connectingTo: connectingTo,
      syncingWith: syncingWith,
      error: error,
      wifiEnabled: wifiEnabled ?? this.wifiEnabled,
      bleEnabled: bleEnabled ?? this.bleEnabled,
    );
  }
}

final p2pControllerProvider =
    StateNotifierProvider<P2PController, P2PControllerState>((ref) {
  final service = ref.watch(p2pServiceProvider);
  final syncEngine = ref.watch(syncEngineProvider);
  return P2PController(service, syncEngine);
});
