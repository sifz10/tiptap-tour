import 'dart:convert';
import 'dart:typed_data';

enum P2PMessageType {
  discovery,
  handshake,
  handshakeAck,
  syncRequest,
  syncResponse,
  chatMessage,
  ack,
  heartbeat,
  disconnect,
}

class P2PMessage {
  final P2PMessageType type;
  final String senderId;
  final String? targetId;
  final Map<String, dynamic> payload;
  final String timestamp;

  const P2PMessage({
    required this.type,
    required this.senderId,
    this.targetId,
    this.payload = const {},
    required this.timestamp,
  });

  Map<String, dynamic> toJson() => {
        'type': type.name,
        'senderId': senderId,
        if (targetId != null) 'targetId': targetId,
        'payload': payload,
        'timestamp': timestamp,
      };

  factory P2PMessage.fromJson(Map<String, dynamic> json) {
    return P2PMessage(
      type: P2PMessageType.values.firstWhere(
        (t) => t.name == json['type'],
        orElse: () => P2PMessageType.ack,
      ),
      senderId: json['senderId'] as String,
      targetId: json['targetId'] as String?,
      payload: Map<String, dynamic>.from(json['payload'] ?? {}),
      timestamp: json['timestamp'] as String,
    );
  }

  Uint8List encode() {
    final jsonBytes = utf8.encode(jsonEncode(toJson()));
    final length = jsonBytes.length;
    final buffer = ByteData(4);
    buffer.setUint32(0, length, Endian.big);
    return Uint8List.fromList([
      ...buffer.buffer.asUint8List(),
      ...jsonBytes,
    ]);
  }

  static P2PMessage? decodeFrom(Uint8List data) {
    try {
      final jsonStr = utf8.decode(data);
      final json = jsonDecode(jsonStr) as Map<String, dynamic>;
      return P2PMessage.fromJson(json);
    } catch (_) {
      return null;
    }
  }

  factory P2PMessage.discovery({
    required String deviceId,
    required String displayName,
    required int tcpPort,
    String? platform,
  }) {
    return P2PMessage(
      type: P2PMessageType.discovery,
      senderId: deviceId,
      timestamp: DateTime.now().millisecondsSinceEpoch.toString(),
      payload: {
        'displayName': displayName,
        'tcpPort': tcpPort,
        'platform': platform ?? _currentPlatform,
      },
    );
  }

  factory P2PMessage.handshake({
    required String deviceId,
    required String displayName,
    List<String>? tripIds,
  }) {
    return P2PMessage(
      type: P2PMessageType.handshake,
      senderId: deviceId,
      timestamp: DateTime.now().millisecondsSinceEpoch.toString(),
      payload: {
        'displayName': displayName,
        if (tripIds != null) 'tripIds': tripIds,
      },
    );
  }

  factory P2PMessage.handshakeAck({
    required String deviceId,
    required String displayName,
    List<String>? tripIds,
  }) {
    return P2PMessage(
      type: P2PMessageType.handshakeAck,
      senderId: deviceId,
      timestamp: DateTime.now().millisecondsSinceEpoch.toString(),
      payload: {
        'displayName': displayName,
        if (tripIds != null) 'tripIds': tripIds,
      },
    );
  }

  factory P2PMessage.syncRequest({
    required String deviceId,
    required String tableName,
    String? afterHlc,
  }) {
    return P2PMessage(
      type: P2PMessageType.syncRequest,
      senderId: deviceId,
      timestamp: DateTime.now().millisecondsSinceEpoch.toString(),
      payload: {
        'tableName': tableName,
        if (afterHlc != null) 'afterHlc': afterHlc,
      },
    );
  }

  factory P2PMessage.syncResponse({
    required String deviceId,
    required String tableName,
    required List<Map<String, dynamic>> records,
    required String latestHlc,
  }) {
    return P2PMessage(
      type: P2PMessageType.syncResponse,
      senderId: deviceId,
      timestamp: DateTime.now().millisecondsSinceEpoch.toString(),
      payload: {
        'tableName': tableName,
        'records': records,
        'latestHlc': latestHlc,
      },
    );
  }

  factory P2PMessage.chat({
    required String deviceId,
    required Map<String, dynamic> messageData,
  }) {
    return P2PMessage(
      type: P2PMessageType.chatMessage,
      senderId: deviceId,
      timestamp: DateTime.now().millisecondsSinceEpoch.toString(),
      payload: messageData,
    );
  }

  factory P2PMessage.heartbeat({required String deviceId}) {
    return P2PMessage(
      type: P2PMessageType.heartbeat,
      senderId: deviceId,
      timestamp: DateTime.now().millisecondsSinceEpoch.toString(),
    );
  }

  factory P2PMessage.ack({
    required String deviceId,
    required String originalTimestamp,
  }) {
    return P2PMessage(
      type: P2PMessageType.ack,
      senderId: deviceId,
      timestamp: DateTime.now().millisecondsSinceEpoch.toString(),
      payload: {'originalTimestamp': originalTimestamp},
    );
  }

  factory P2PMessage.disconnect({required String deviceId}) {
    return P2PMessage(
      type: P2PMessageType.disconnect,
      senderId: deviceId,
      timestamp: DateTime.now().millisecondsSinceEpoch.toString(),
    );
  }

  static String get _currentPlatform {
    return 'unknown';
  }
}
