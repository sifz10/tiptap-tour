import 'dart:math';

class HLC implements Comparable<HLC> {
  final int timestamp;
  final int counter;
  final String nodeId;

  const HLC({
    required this.timestamp,
    required this.counter,
    required this.nodeId,
  });

  factory HLC.now(String nodeId) {
    return HLC(
      timestamp: DateTime.now().millisecondsSinceEpoch,
      counter: 0,
      nodeId: nodeId,
    );
  }

  factory HLC.send(HLC local) {
    final now = DateTime.now().millisecondsSinceEpoch;
    if (now > local.timestamp) {
      return HLC(timestamp: now, counter: 0, nodeId: local.nodeId);
    }
    return HLC(
      timestamp: local.timestamp,
      counter: local.counter + 1,
      nodeId: local.nodeId,
    );
  }

  factory HLC.receive(HLC local, HLC remote) {
    final now = DateTime.now().millisecondsSinceEpoch;
    final maxTs = max(now, max(local.timestamp, remote.timestamp));

    int nextCounter;
    if (maxTs == local.timestamp && maxTs == remote.timestamp) {
      nextCounter = max(local.counter, remote.counter) + 1;
    } else if (maxTs == local.timestamp) {
      nextCounter = local.counter + 1;
    } else if (maxTs == remote.timestamp) {
      nextCounter = remote.counter + 1;
    } else {
      nextCounter = 0;
    }

    return HLC(
      timestamp: maxTs,
      counter: nextCounter,
      nodeId: local.nodeId,
    );
  }

  factory HLC.fromString(String value) {
    final parts = value.split(':');
    if (parts.length < 3) {
      throw FormatException('Invalid HLC string: $value');
    }
    return HLC(
      timestamp: int.parse(parts[0]),
      counter: int.parse(parts[1]),
      nodeId: parts.sublist(2).join(':'),
    );
  }

  @override
  String toString() => '$timestamp:$counter:$nodeId';

  @override
  int compareTo(HLC other) {
    final tsCompare = timestamp.compareTo(other.timestamp);
    if (tsCompare != 0) return tsCompare;
    final counterCompare = counter.compareTo(other.counter);
    if (counterCompare != 0) return counterCompare;
    return nodeId.compareTo(other.nodeId);
  }

  bool operator >(HLC other) => compareTo(other) > 0;

  bool operator <(HLC other) => compareTo(other) < 0;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is HLC &&
          timestamp == other.timestamp &&
          counter == other.counter &&
          nodeId == other.nodeId;

  @override
  int get hashCode => Object.hash(timestamp, counter, nodeId);
}
