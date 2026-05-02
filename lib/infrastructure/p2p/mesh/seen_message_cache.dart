import 'dart:collection';

class SeenMessageCache {
  final int maxSize;
  final Duration expiry;

  final LinkedHashMap<String, DateTime> _entries = LinkedHashMap();

  SeenMessageCache({
    this.maxSize = 1000,
    this.expiry = const Duration(minutes: 5),
  });

  bool contains(String messageId) {
    final timestamp = _entries[messageId];
    if (timestamp == null) return false;

    if (DateTime.now().difference(timestamp) > expiry) {
      _entries.remove(messageId);
      return false;
    }
    return true;
  }

  void add(String messageId) {
    _entries[messageId] = DateTime.now();
    _evict();
  }

  void _evict() {
    final now = DateTime.now();
    _entries.removeWhere((_, ts) => now.difference(ts) > expiry);

    while (_entries.length > maxSize) {
      _entries.remove(_entries.keys.first);
    }
  }

  void clear() => _entries.clear();

  int get length => _entries.length;
}
