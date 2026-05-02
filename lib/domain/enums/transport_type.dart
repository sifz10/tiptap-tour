enum TransportType {
  wifi,
  ble;

  String get label {
    switch (this) {
      case TransportType.wifi:
        return 'Wi-Fi';
      case TransportType.ble:
        return 'Bluetooth';
    }
  }
}
