import 'dart:convert';
import 'dart:typed_data';

import 'package:uuid/uuid.dart';

const _uuid = Uuid();

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
  routeAnnounce,
}

class MeshMetadata {
  final String originId;
  final int ttl;
  final List<String> hopPath;

  const MeshMetadata({
    required this.originId,
    this.ttl = 5,
    this.hopPath = const [],
  });

  MeshMetadata copyWithHop(String nodeId) {
    return MeshMetadata(
      originId: originId,
      ttl: ttl - 1,
      hopPath: [...hopPath, nodeId],
    );
  }

  bool get isExpired => ttl <= 0;

  bool hasVisited(String nodeId) => hopPath.contains(nodeId);

  Map<String, dynamic> toJson() => {
        'originId': originId,
        'ttl': ttl,
        'hopPath': hopPath,
      };

  factory MeshMetadata.fromJson(Map<String, dynamic> json) {
    return MeshMetadata(
      originId: json['originId'] as String,
      ttl: json['ttl'] as int? ?? 5,
      hopPath: (json['hopPath'] as List?)?.cast<String>() ?? [],
    );
  }
}

class P2PMessage {
  final P2PMessageType type;
  final String senderId;
  final String? targetId;
  final String messageId;
  final Map<String, dynamic> payload;
  final String timestamp;

  const P2PMessage({
    required this.type,
    required this.senderId,
    this.targetId,
    required this.messageId,
    this.payload = const {},
    required this.timestamp,
  });

  MeshMetadata? get mesh {
    final meshJson = payload['_mesh'] as Map<String, dynamic>?;
    if (meshJson == null) return null;
    return MeshMetadata.fromJson(meshJson);
  }

  bool get isBroadcast => targetId == null;

  bool get isRelayable => targetId != null && targetId!.isNotEmpty;

  P2PMessage withMesh(MeshMetadata metadata) {
    return P2PMessage(
      type: type,
      senderId: senderId,
      targetId: targetId,
      messageId: messageId,
      payload: {...payload, '_mesh': metadata.toJson()},
      timestamp: timestamp,
    );
  }

  P2PMessage forRelay({required String relaySenderId}) {
    return P2PMessage(
      type: type,
      senderId: relaySenderId,
      targetId: targetId,
      messageId: messageId,
      payload: payload,
      timestamp: timestamp,
    );
  }

  Map<String, dynamic> toJson() => {
        'type': type.name,
        'senderId': senderId,
        if (targetId != null) 'targetId': targetId,
        'messageId': messageId,
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
      messageId: json['messageId'] as String? ?? _uuid.v4(),
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

  // --- Factory constructors ---

  factory P2PMessage.discovery({
    required String deviceId,
    required String displayName,
    required int tcpPort,
    String? platform,
  }) {
    return P2PMessage(
      type: P2PMessageType.discovery,
      senderId: deviceId,
      messageId: _uuid.v4(),
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
    String? publicKey,
  }) {
    return P2PMessage(
      type: P2PMessageType.handshake,
      senderId: deviceId,
      messageId: _uuid.v4(),
      timestamp: DateTime.now().millisecondsSinceEpoch.toString(),
      payload: {
        'displayName': displayName,
        if (tripIds != null) 'tripIds': tripIds,
        if (publicKey != null) 'publicKey': publicKey,
      },
    );
  }

  factory P2PMessage.handshakeAck({
    required String deviceId,
    required String displayName,
    List<String>? tripIds,
    String? publicKey,
  }) {
    return P2PMessage(
      type: P2PMessageType.handshakeAck,
      senderId: deviceId,
      messageId: _uuid.v4(),
      timestamp: DateTime.now().millisecondsSinceEpoch.toString(),
      payload: {
        'displayName': displayName,
        if (tripIds != null) 'tripIds': tripIds,
        if (publicKey != null) 'publicKey': publicKey,
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
      messageId: _uuid.v4(),
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
      messageId: _uuid.v4(),
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
    String? targetId,
  }) {
    return P2PMessage(
      type: P2PMessageType.chatMessage,
      senderId: deviceId,
      targetId: targetId,
      messageId: _uuid.v4(),
      timestamp: DateTime.now().millisecondsSinceEpoch.toString(),
      payload: messageData,
    );
  }

  factory P2PMessage.heartbeat({required String deviceId}) {
    return P2PMessage(
      type: P2PMessageType.heartbeat,
      senderId: deviceId,
      messageId: _uuid.v4(),
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
      messageId: _uuid.v4(),
      timestamp: DateTime.now().millisecondsSinceEpoch.toString(),
      payload: {'originalTimestamp': originalTimestamp},
    );
  }

  factory P2PMessage.disconnect({required String deviceId}) {
    return P2PMessage(
      type: P2PMessageType.disconnect,
      senderId: deviceId,
      messageId: _uuid.v4(),
      timestamp: DateTime.now().millisecondsSinceEpoch.toString(),
    );
  }

  factory P2PMessage.routeAnnounce({
    required String deviceId,
    required Map<String, int> reachablePeers,
  }) {
    return P2PMessage(
      type: P2PMessageType.routeAnnounce,
      senderId: deviceId,
      messageId: _uuid.v4(),
      timestamp: DateTime.now().millisecondsSinceEpoch.toString(),
      payload: {
        'reachable': reachablePeers,
      },
    );
  }

  static String get _currentPlatform {
    return 'unknown';
  }
}
