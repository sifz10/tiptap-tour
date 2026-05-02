class P2PPeerDiagnostic {
  final String deviceId;
  final String displayName;
  final bool isDirect;
  final int hopCount;
  final String nextHopId;
  final String transportLabel;
  final bool encryptionReady;
  final DateTime lastUpdated;

  const P2PPeerDiagnostic({
    required this.deviceId,
    required this.displayName,
    required this.isDirect,
    required this.hopCount,
    required this.nextHopId,
    required this.transportLabel,
    required this.encryptionReady,
    required this.lastUpdated,
  });

  P2PPeerDiagnostic copyWith({bool? encryptionReady, String? transportLabel}) {
    return P2PPeerDiagnostic(
      deviceId: deviceId,
      displayName: displayName,
      isDirect: isDirect,
      hopCount: hopCount,
      nextHopId: nextHopId,
      transportLabel: transportLabel ?? this.transportLabel,
      encryptionReady: encryptionReady ?? this.encryptionReady,
      lastUpdated: lastUpdated,
    );
  }
}

class P2PDiagnostics {
  final bool wifiEnabled;
  final bool bleEnabled;
  final List<P2PPeerDiagnostic> peers;

  const P2PDiagnostics({
    required this.wifiEnabled,
    required this.bleEnabled,
    required this.peers,
  });

  int get directPeerCount => peers.where((peer) => peer.isDirect).length;
  int get meshPeerCount => peers.where((peer) => !peer.isDirect).length;
  int get encryptedPeerCount =>
      peers.where((peer) => peer.encryptionReady).length;

  static const empty = P2PDiagnostics(
    wifiEnabled: false,
    bleEnabled: false,
    peers: [],
  );
}
