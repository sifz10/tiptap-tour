import 'dart:async';

import 'package:flutter/services.dart';

import 'package:tiptap_tour/infrastructure/p2p/ble/ble_constants.dart';

class BleGattServer {
  static const _channel = MethodChannel(BleConstants.methodChannel);

  final _incomingDataController = StreamController<GattIncomingData>.broadcast();
  final _connectedDevicesController = StreamController<List<String>>.broadcast();

  Stream<GattIncomingData> get incomingData => _incomingDataController.stream;
  Stream<List<String>> get connectedDevices => _connectedDevicesController.stream;

  final Set<String> _connectedCentrals = {};

  BleGattServer() {
    _channel.setMethodCallHandler(_handleNativeCall);
  }

  Future<void> start({
    required String deviceId,
    required String displayName,
  }) async {
    await _channel.invokeMethod('startServer', {
      'serviceUuid': BleConstants.serviceUuid,
      'messageWriteCharUuid': BleConstants.messageWriteCharUuid,
      'messageNotifyCharUuid': BleConstants.messageNotifyCharUuid,
      'deviceInfoCharUuid': BleConstants.deviceInfoCharUuid,
      'deviceId': deviceId,
      'displayName': displayName,
    });
  }

  Future<void> stop() async {
    await _channel.invokeMethod('stopServer');
    _connectedCentrals.clear();
  }

  Future<void> startAdvertising() async {
    await _channel.invokeMethod('startAdvertising', {
      'serviceUuid': BleConstants.serviceUuid,
    });
  }

  Future<void> stopAdvertising() async {
    await _channel.invokeMethod('stopAdvertising');
  }

  Future<void> sendNotification(Uint8List data, {String? targetDeviceId}) async {
    await _channel.invokeMethod('sendNotification', {
      'data': data,
      'targetDeviceId': targetDeviceId,
    });
  }

  Set<String> get connectedCentrals => Set.unmodifiable(_connectedCentrals);

  Future<dynamic> _handleNativeCall(MethodCall call) async {
    switch (call.method) {
      case 'onDataReceived':
        final args = call.arguments as Map;
        _incomingDataController.add(GattIncomingData(
          centralId: args['centralId'] as String,
          data: Uint8List.fromList(List<int>.from(args['data'])),
        ));
      case 'onCentralConnected':
        final centralId = call.arguments as String;
        _connectedCentrals.add(centralId);
        _connectedDevicesController.add(_connectedCentrals.toList());
      case 'onCentralDisconnected':
        final centralId = call.arguments as String;
        _connectedCentrals.remove(centralId);
        _connectedDevicesController.add(_connectedCentrals.toList());
    }
  }

  void dispose() {
    _channel.setMethodCallHandler(null);
    _incomingDataController.close();
    _connectedDevicesController.close();
  }
}

class GattIncomingData {
  final String centralId;
  final Uint8List data;

  const GattIncomingData({required this.centralId, required this.data});
}
