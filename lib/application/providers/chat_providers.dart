import 'dart:async';

import 'package:drift/drift.dart' show Value;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:tiptap_tour/application/providers/database_provider.dart';
import 'package:tiptap_tour/application/providers/p2p_providers.dart';
import 'package:tiptap_tour/core/utils/hlc.dart';
import 'package:tiptap_tour/infrastructure/database/app_database.dart';
import 'package:tiptap_tour/infrastructure/p2p/p2p_message.dart';
import 'package:uuid/uuid.dart';

final messagesByTripProvider =
    StreamProvider.family<List<Message>, String>((ref, tripId) {
  final db = ref.watch(databaseProvider);
  return db.chatDao.watchMessagesByTripId(tripId);
});

class SendMessageNotifier extends StateNotifier<AsyncValue<void>> {
  final AppDatabase _db;
  final Ref _ref;

  SendMessageNotifier(this._db, this._ref) : super(const AsyncValue.data(null));

  Future<void> sendTextMessage({
    required String tripId,
    required String content,
    String? replyToId,
  }) async {
    state = const AsyncValue.loading();
    try {
      final settingsBox = Hive.box('settings');
      final userId =
          settingsBox.get('userId', defaultValue: 'unknown') as String;
      final uuid = const Uuid();
      final messageId = uuid.v4();
      final now = DateTime.now().millisecondsSinceEpoch;
      final hlc = HLC.send(HLC.now(userId)).toString();

      final companion = MessagesCompanion(
        id: Value(messageId),
        tripId: Value(tripId),
        senderId: Value(userId),
        content: Value(content),
        messageType: const Value('text'),
        replyToId: Value(replyToId),
        sentAt: Value(now),
        hlcTimestamp: Value(hlc),
      );

      await _db.chatDao.insertMessage(companion);

      _relayViaP2P(
        tripId: tripId,
        messageId: messageId,
        senderId: userId,
        messageType: 'text',
        sentAt: now,
        hlc: hlc,
        content: content,
      );

      final syncEngine = _ref.read(syncEngineProvider);
      await syncEngine.recordChange(
        tableName: 'messages',
        recordId: messageId,
        operation: 'insert',
        data: {
          'id': messageId,
          'tripId': tripId,
          'senderId': userId,
          'content': content,
          'messageType': 'text',
          'replyToId': replyToId,
          'sentAt': now,
          'hlcTimestamp': hlc,
        },
      );

      state = const AsyncValue.data(null);
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }

  Future<void> sendImageMessage({
    required String tripId,
    required String imagePath,
    String? thumbnailPath,
  }) async {
    state = const AsyncValue.loading();
    try {
      final settingsBox = Hive.box('settings');
      final userId =
          settingsBox.get('userId', defaultValue: 'unknown') as String;
      final uuid = const Uuid();
      final messageId = uuid.v4();
      final now = DateTime.now().millisecondsSinceEpoch;
      final hlc = HLC.send(HLC.now(userId)).toString();

      final companion = MessagesCompanion(
        id: Value(messageId),
        tripId: Value(tripId),
        senderId: Value(userId),
        messageType: const Value('image'),
        imagePath: Value(imagePath),
        imageThumbnailPath: Value(thumbnailPath),
        sentAt: Value(now),
        hlcTimestamp: Value(hlc),
      );

      await _db.chatDao.insertMessage(companion);

      _relayViaP2P(
        tripId: tripId,
        messageId: messageId,
        senderId: userId,
        messageType: 'image',
        sentAt: now,
        hlc: hlc,
        imagePath: imagePath,
      );

      final syncEngine = _ref.read(syncEngineProvider);
      await syncEngine.recordChange(
        tableName: 'messages',
        recordId: messageId,
        operation: 'insert',
        data: {
          'id': messageId,
          'tripId': tripId,
          'senderId': userId,
          'messageType': 'image',
          'imagePath': imagePath,
          'imageThumbnailPath': thumbnailPath,
          'sentAt': now,
          'hlcTimestamp': hlc,
        },
      );

      state = const AsyncValue.data(null);
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }

  Future<void> sendSystemMessage({
    required String tripId,
    required String content,
    String messageType = 'system',
  }) async {
    try {
      final settingsBox = Hive.box('settings');
      final userId =
          settingsBox.get('userId', defaultValue: 'unknown') as String;
      final uuid = const Uuid();
      final messageId = uuid.v4();
      final now = DateTime.now().millisecondsSinceEpoch;
      final hlc = HLC.send(HLC.now(userId)).toString();

      final companion = MessagesCompanion(
        id: Value(messageId),
        tripId: Value(tripId),
        senderId: Value(userId),
        content: Value(content),
        messageType: Value(messageType),
        sentAt: Value(now),
        hlcTimestamp: Value(hlc),
      );

      await _db.chatDao.insertMessage(companion);

      final syncEngine = _ref.read(syncEngineProvider);
      await syncEngine.recordChange(
        tableName: 'messages',
        recordId: messageId,
        operation: 'insert',
        data: {
          'id': messageId,
          'tripId': tripId,
          'senderId': userId,
          'content': content,
          'messageType': messageType,
          'sentAt': now,
          'hlcTimestamp': hlc,
        },
      );
    } catch (_) {}
  }

  void _relayViaP2P({
    required String tripId,
    required String messageId,
    required String senderId,
    required String messageType,
    required int sentAt,
    required String hlc,
    String? content,
    String? imagePath,
  }) {
    try {
      final p2pService = _ref.read(p2pServiceProvider);
      final chatMsg = P2PMessage.chat(
        deviceId: senderId,
        messageData: {
          'id': messageId,
          'tripId': tripId,
          'senderId': senderId,
          'content': content,
          'messageType': messageType,
          'imagePath': imagePath,
          'sentAt': sentAt,
          'hlcTimestamp': hlc,
        },
      );
      p2pService.broadcastMessage(chatMsg);
    } catch (_) {}
  }
}

final sendMessageProvider =
    StateNotifierProvider<SendMessageNotifier, AsyncValue<void>>((ref) {
  final db = ref.watch(databaseProvider);
  return SendMessageNotifier(db, ref);
});

class DeleteMessageNotifier extends StateNotifier<AsyncValue<void>> {
  final AppDatabase _db;

  DeleteMessageNotifier(this._db) : super(const AsyncValue.data(null));

  Future<void> deleteMessage(String messageId) async {
    state = const AsyncValue.loading();
    try {
      final hlc = HLC.send(HLC.now('local')).toString();
      await _db.chatDao.softDeleteMessage(messageId, hlc);
      state = const AsyncValue.data(null);
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }
}

final deleteMessageProvider =
    StateNotifierProvider<DeleteMessageNotifier, AsyncValue<void>>((ref) {
  final db = ref.watch(databaseProvider);
  return DeleteMessageNotifier(db);
});

final chatP2PListenerProvider = Provider.family<void, String>((ref, tripId) {
  final p2pService = ref.watch(p2pServiceProvider);
  final db = ref.watch(databaseProvider);
  final settingsBox = Hive.box('settings');
  final localUserId =
      settingsBox.get('userId', defaultValue: 'unknown') as String;

  final subscription = p2pService.incomingMessages.listen((message) {
    if (message.type != P2PMessageType.chatMessage) return;

    final payload = message.payload;
    if (payload['tripId'] != tripId) return;

    final senderId = payload['senderId'] as String?;
    if (senderId == localUserId) return;

    final companion = MessagesCompanion(
      id: Value(payload['id'] as String),
      tripId: Value(payload['tripId'] as String),
      senderId: Value(senderId ?? ''),
      content: Value(payload['content'] as String?),
      messageType: Value(payload['messageType'] as String? ?? 'text'),
      imagePath: Value(payload['imagePath'] as String?),
      sentAt: Value(payload['sentAt'] as int),
      hlcTimestamp: Value(payload['hlcTimestamp'] as String),
    );

    db.chatDao.upsertMessage(companion).catchError((_) {});
  });

  ref.onDispose(() => subscription.cancel());
});
