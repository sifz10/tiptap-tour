import 'dart:typed_data';

import 'package:tiptap_tour/infrastructure/p2p/ble/ble_constants.dart';

class BleChunk {
  final int messageHash;
  final int sequenceNumber;
  final int totalChunks;
  final Uint8List data;

  const BleChunk({
    required this.messageHash,
    required this.sequenceNumber,
    required this.totalChunks,
    required this.data,
  });

  Uint8List encode() {
    final buffer = ByteData(BleConstants.chunkHeaderSize + data.length);
    buffer.setUint16(0, messageHash, Endian.big);
    buffer.setUint8(2, sequenceNumber);
    buffer.setUint8(3, totalChunks);
    buffer.setUint8(4, data.length);
    final result = Uint8List(BleConstants.chunkHeaderSize + data.length);
    result.setRange(0, BleConstants.chunkHeaderSize,
        buffer.buffer.asUint8List(0, BleConstants.chunkHeaderSize));
    result.setRange(BleConstants.chunkHeaderSize, result.length, data);
    return result;
  }

  static BleChunk? decode(Uint8List raw) {
    if (raw.length < BleConstants.chunkHeaderSize) return null;
    final view = ByteData.sublistView(raw);
    final messageHash = view.getUint16(0, Endian.big);
    final seq = view.getUint8(2);
    final total = view.getUint8(3);
    final dataLen = view.getUint8(4);
    if (raw.length < BleConstants.chunkHeaderSize + dataLen) return null;
    return BleChunk(
      messageHash: messageHash,
      sequenceNumber: seq,
      totalChunks: total,
      data: Uint8List.fromList(
          raw.sublist(BleConstants.chunkHeaderSize,
              BleConstants.chunkHeaderSize + dataLen)),
    );
  }
}

class BleChunker {
  BleChunker._();

  static List<BleChunk> split(Uint8List data, int mtu) {
    final chunkDataSize = mtu - BleConstants.chunkHeaderSize;
    if (chunkDataSize <= 0) return [];

    final messageHash = _hash16(data);
    final totalChunks = (data.length / chunkDataSize).ceil();
    if (totalChunks > 255) return [];

    final chunks = <BleChunk>[];
    for (var i = 0; i < totalChunks; i++) {
      final start = i * chunkDataSize;
      final end =
          (start + chunkDataSize > data.length) ? data.length : start + chunkDataSize;
      chunks.add(BleChunk(
        messageHash: messageHash,
        sequenceNumber: i,
        totalChunks: totalChunks,
        data: Uint8List.fromList(data.sublist(start, end)),
      ));
    }
    return chunks;
  }

  static int _hash16(Uint8List data) {
    var hash = 0xFFFF;
    for (final byte in data) {
      hash ^= byte;
      for (var i = 0; i < 8; i++) {
        if (hash & 1 == 1) {
          hash = (hash >> 1) ^ 0xA001;
        } else {
          hash >>= 1;
        }
      }
    }
    return hash & 0xFFFF;
  }
}

class BleChunkAssembler {
  final Map<int, Map<int, BleChunk>> _pending = {};

  Uint8List? addChunk(BleChunk chunk) {
    final bucket = _pending.putIfAbsent(chunk.messageHash, () => {});
    bucket[chunk.sequenceNumber] = chunk;

    if (bucket.length < chunk.totalChunks) return null;

    final builder = BytesBuilder();
    for (var i = 0; i < chunk.totalChunks; i++) {
      final part = bucket[i];
      if (part == null) return null;
      builder.add(part.data);
    }

    _pending.remove(chunk.messageHash);
    return builder.toBytes();
  }

  void clear() => _pending.clear();
}
