class RoutingEntry {
  final String nextHopId;
  final int hopCount;
  final DateTime lastUpdated;

  const RoutingEntry({
    required this.nextHopId,
    required this.hopCount,
    required this.lastUpdated,
  });
}

class RoutingTable {
  final Duration entryExpiry;
  final Map<String, RoutingEntry> _routes = {};

  RoutingTable({this.entryExpiry = const Duration(seconds: 60)});

  void updateRoute(String targetId, String nextHopId, int hopCount) {
    final existing = _routes[targetId];

    if (existing != null &&
        existing.nextHopId == nextHopId &&
        existing.hopCount <= hopCount) {
      _routes[targetId] = RoutingEntry(
        nextHopId: nextHopId,
        hopCount: existing.hopCount,
        lastUpdated: DateTime.now(),
      );
      return;
    }

    if (existing == null || hopCount < existing.hopCount) {
      _routes[targetId] = RoutingEntry(
        nextHopId: nextHopId,
        hopCount: hopCount,
        lastUpdated: DateTime.now(),
      );
    }
  }

  String? getNextHop(String targetId) {
    final entry = _routes[targetId];
    if (entry == null) return null;

    if (DateTime.now().difference(entry.lastUpdated) > entryExpiry) {
      _routes.remove(targetId);
      return null;
    }
    return entry.nextHopId;
  }

  Map<String, int> getReachablePeers() {
    removeStaleEntries();
    return {
      for (final entry in _routes.entries) entry.key: entry.value.hopCount,
    };
  }

  void removeRoutesVia(String peerDeviceId) {
    _routes.removeWhere((_, entry) => entry.nextHopId == peerDeviceId);
  }

  void removeStaleEntries() {
    final now = DateTime.now();
    _routes.removeWhere(
      (_, entry) => now.difference(entry.lastUpdated) > entryExpiry,
    );
  }

  void clear() => _routes.clear();

  bool hasRoute(String targetId) => getNextHop(targetId) != null;

  int get length {
    removeStaleEntries();
    return _routes.length;
  }
}
