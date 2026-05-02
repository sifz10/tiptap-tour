class BleConstants {
  BleConstants._();

  static const serviceUuid = 'a1b2c3d4-e5f6-7890-abcd-ef1234567890';
  static const messageWriteCharUuid = 'a1b2c3d4-e5f6-7890-abcd-ef1234567891';
  static const messageNotifyCharUuid = 'a1b2c3d4-e5f6-7890-abcd-ef1234567892';
  static const deviceInfoCharUuid = 'a1b2c3d4-e5f6-7890-abcd-ef1234567893';

  static const defaultMtu = 20;
  static const preferredMtu = 512;
  static const chunkHeaderSize = 5;

  static const scanDuration = Duration(seconds: 10);
  static const scanPause = Duration(seconds: 20);
  static const connectionTimeout = Duration(seconds: 15);
  static const heartbeatInterval = Duration(seconds: 30);

  static const methodChannel = 'com.ryven.tiptap_tour/ble_gatt_server';
}
