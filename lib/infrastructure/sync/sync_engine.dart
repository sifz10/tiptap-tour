import 'dart:async';
import 'dart:convert';

import 'package:drift/drift.dart';
import 'package:tiptap_tour/core/utils/hlc.dart';
import 'package:tiptap_tour/infrastructure/database/app_database.dart';
import 'package:tiptap_tour/infrastructure/p2p/p2p_message.dart';
import 'package:tiptap_tour/infrastructure/p2p/transport.dart';

class SyncProgress {
  final String peerDeviceId;
  final String tableName;
  final int totalRecords;
  final int syncedRecords;
  final bool isComplete;

  const SyncProgress({
    required this.peerDeviceId,
    required this.tableName,
    this.totalRecords = 0,
    this.syncedRecords = 0,
    this.isComplete = false,
  });

  double get progress =>
      totalRecords > 0 ? syncedRecords / totalRecords : 0.0;
}

class SyncEngine {
  final AppDatabase db;
  final P2PTransport p2pService;
  final String localDeviceId;

  SyncEngine({
    required this.db,
    required this.p2pService,
    required this.localDeviceId,
  });

  StreamSubscription<P2PMessage>? _messageSubscription;

  final _progressController = StreamController<SyncProgress>.broadcast();
  Stream<SyncProgress> get syncProgress => _progressController.stream;

  bool _isSyncing = false;
  bool get isSyncing => _isSyncing;

  static const _syncableTables = [
    'users',
    'trips',
    'trip_members',
    'expenses',
    'expense_splits',
    'settlements',
    'messages',
  ];

  void start() {
    _messageSubscription = p2pService.incomingMessages.listen(_handleMessage);
  }

  void stop() {
    _messageSubscription?.cancel();
    _messageSubscription = null;
  }

  Future<void> syncWithPeer(String peerDeviceId) async {
    if (_isSyncing) return;
    _isSyncing = true;

    try {
      for (final tableName in _syncableTables) {
        final peerState =
            await db.syncDao.getPeerSyncState(peerDeviceId, tableName);
        final afterHlc = peerState?.lastSyncedHlc;

        final request = P2PMessage.syncRequest(
          deviceId: localDeviceId,
          tableName: tableName,
          afterHlc: afterHlc,
        );

        await p2pService.sendMessage(peerDeviceId, request);

        _progressController.add(SyncProgress(
          peerDeviceId: peerDeviceId,
          tableName: tableName,
        ));
      }

      final unsyncedItems = await db.syncDao.getUnsyncedItems();
      if (unsyncedItems.isNotEmpty) {
        await _sendUnsyncedItems(peerDeviceId, unsyncedItems);
      }
    } finally {
      _isSyncing = false;
    }
  }

  Future<void> _sendUnsyncedItems(
    String peerDeviceId,
    List<SyncQueueData> items,
  ) async {
    final grouped = <String, List<SyncQueueData>>{};
    for (final item in items) {
      grouped.putIfAbsent(item.syncTableName, () => []).add(item);
    }

    for (final entry in grouped.entries) {
      final records = entry.value
          .map((item) => {
                'recordId': item.recordId,
                'operation': item.operation,
                'payload': jsonDecode(item.payload),
                'hlcTimestamp': item.hlcTimestamp,
              })
          .toList();

      final latestHlc = entry.value
          .map((e) => e.hlcTimestamp)
          .reduce((a, b) {
        final hlcA = HLC.fromString(a);
        final hlcB = HLC.fromString(b);
        return hlcA > hlcB ? a : b;
      });

      final response = P2PMessage.syncResponse(
        deviceId: localDeviceId,
        tableName: entry.key,
        records: records,
        latestHlc: latestHlc,
      );

      await p2pService.sendMessage(peerDeviceId, response);
    }
  }

  void _handleMessage(P2PMessage message) {
    switch (message.type) {
      case P2PMessageType.syncRequest:
        _handleSyncRequest(message);
      case P2PMessageType.syncResponse:
        _handleSyncResponse(message);
      default:
        break;
    }
  }

  Future<void> _handleSyncRequest(P2PMessage message) async {
    final tableName = message.payload['tableName'] as String;
    final afterHlc = message.payload['afterHlc'] as String?;

    List<SyncQueueData> items;
    if (afterHlc != null) {
      items = await db.syncDao.getItemsAfterHlc(afterHlc);
      items = items
          .where((item) => item.syncTableName == tableName)
          .toList();
    } else {
      final allItems = await db.syncDao.getUnsyncedItems();
      items = allItems
          .where((item) => item.syncTableName == tableName)
          .toList();
    }

    if (items.isEmpty) {
      final response = P2PMessage.syncResponse(
        deviceId: localDeviceId,
        tableName: tableName,
        records: [],
        latestHlc: '',
      );
      await p2pService.sendMessage(message.senderId, response);
      return;
    }

    final records = items
        .map((item) => {
              'recordId': item.recordId,
              'operation': item.operation,
              'payload': jsonDecode(item.payload),
              'hlcTimestamp': item.hlcTimestamp,
            })
        .toList();

    final latestHlc = items.map((e) => e.hlcTimestamp).reduce((a, b) {
      final hlcA = HLC.fromString(a);
      final hlcB = HLC.fromString(b);
      return hlcA > hlcB ? a : b;
    });

    final response = P2PMessage.syncResponse(
      deviceId: localDeviceId,
      tableName: tableName,
      records: records,
      latestHlc: latestHlc,
    );

    await p2pService.sendMessage(message.senderId, response);
  }

  Future<void> _handleSyncResponse(P2PMessage message) async {
    final tableName = message.payload['tableName'] as String;
    final records =
        (message.payload['records'] as List?)?.cast<Map<String, dynamic>>() ??
            [];
    final latestHlc = message.payload['latestHlc'] as String? ?? '';

    if (records.isEmpty) {
      _progressController.add(SyncProgress(
        peerDeviceId: message.senderId,
        tableName: tableName,
        isComplete: true,
      ));
      return;
    }

    int synced = 0;
    for (final record in records) {
      await _applyRecord(tableName, record);
      synced++;
      _progressController.add(SyncProgress(
        peerDeviceId: message.senderId,
        tableName: tableName,
        totalRecords: records.length,
        syncedRecords: synced,
      ));
    }

    if (latestHlc.isNotEmpty) {
      await db.syncDao.updatePeerSyncState(PeerSyncStateCompanion(
        peerDeviceId: Value(message.senderId),
        syncTableName: Value(tableName),
        lastSyncedHlc: Value(latestHlc),
        lastSyncAt: Value(DateTime.now().millisecondsSinceEpoch),
      ));
    }

    _progressController.add(SyncProgress(
      peerDeviceId: message.senderId,
      tableName: tableName,
      totalRecords: records.length,
      syncedRecords: records.length,
      isComplete: true,
    ));
  }

  Future<void> _applyRecord(
    String tableName,
    Map<String, dynamic> record,
  ) async {
    final operation = record['operation'] as String;
    final payload =
        record['payload'] as Map<String, dynamic>? ?? {};
    final remoteHlc = record['hlcTimestamp'] as String? ?? '';

    if (remoteHlc.isEmpty) return;

    final shouldApply = await _shouldApplyChange(
      tableName,
      record['recordId'] as String,
      remoteHlc,
    );

    if (!shouldApply) return;

    switch (operation) {
      case 'insert':
      case 'update':
        await _upsertRecord(tableName, payload);
      case 'delete':
        await _softDeleteRecord(
          tableName,
          record['recordId'] as String,
        );
    }
  }

  Future<bool> _shouldApplyChange(
    String tableName,
    String recordId,
    String remoteHlcStr,
  ) async {
    try {
      final remoteHlc = HLC.fromString(remoteHlcStr);
      final localHlc = HLC.now(localDeviceId);
      return remoteHlc > localHlc ? false : true;
    } catch (_) {
      return true;
    }
  }

  Future<void> _upsertRecord(
    String tableName,
    Map<String, dynamic> payload,
  ) async {
    switch (tableName) {
      case 'users':
        await _upsertUser(payload);
      case 'trips':
        await _upsertTrip(payload);
      case 'expenses':
        await _upsertExpense(payload);
      case 'expense_splits':
        await _upsertExpenseSplit(payload);
      case 'settlements':
        await _upsertSettlement(payload);
      case 'messages':
        await _upsertMessage(payload);
      case 'trip_members':
        await _upsertTripMember(payload);
    }
  }

  Future<void> _upsertUser(Map<String, dynamic> data) async {
    final companion = UsersCompanion(
      id: Value(data['id'] as String),
      displayName: Value(data['displayName'] as String? ?? ''),
      avatarPath: Value(data['avatarPath'] as String?),
      deviceId: Value(data['deviceId'] as String? ?? ''),
      createdAt: Value(data['createdAt'] as int? ?? 0),
      hlcTimestamp: Value(data['hlcTimestamp'] as String? ?? ''),
    );
    await db.into(db.users).insertOnConflictUpdate(companion);
  }

  Future<void> _upsertTrip(Map<String, dynamic> data) async {
    final companion = TripsCompanion(
      id: Value(data['id'] as String),
      name: Value(data['name'] as String? ?? ''),
      description: Value(data['description'] as String?),
      baseCurrency: Value(data['baseCurrency'] as String? ?? 'BDT'),
      createdBy: Value(data['createdBy'] as String? ?? ''),
      startDate: Value(data['startDate'] as int?),
      endDate: Value(data['endDate'] as int?),
      createdAt: Value(data['createdAt'] as int? ?? 0),
      updatedAt: Value(data['updatedAt'] as int? ?? 0),
      hlcTimestamp: Value(data['hlcTimestamp'] as String? ?? ''),
    );
    await db.into(db.trips).insertOnConflictUpdate(companion);
  }

  Future<void> _upsertExpense(Map<String, dynamic> data) async {
    final now = DateTime.now().millisecondsSinceEpoch;
    final companion = ExpensesCompanion(
      id: Value(data['id'] as String),
      tripId: Value(data['tripId'] as String? ?? ''),
      paidBy: Value(data['paidBy'] as String? ?? ''),
      title: Value(data['title'] as String? ?? ''),
      amount: Value((data['amount'] as num?)?.toDouble() ?? 0),
      currency: Value(data['currency'] as String? ?? 'BDT'),
      category: Value(data['category'] as String? ?? 'other'),
      splitType: Value(data['splitType'] as String? ?? 'equal'),
      notes: Value(data['notes'] as String?),
      expenseDate: Value(data['expenseDate'] as int? ?? now),
      createdAt: Value(data['createdAt'] as int? ?? now),
      updatedAt: Value(data['updatedAt'] as int? ?? now),
      hlcTimestamp: Value(data['hlcTimestamp'] as String? ?? ''),
      isDeleted: Value(data['isDeleted'] as bool? ?? false),
    );
    await db.into(db.expenses).insertOnConflictUpdate(companion);
  }

  Future<void> _upsertExpenseSplit(Map<String, dynamic> data) async {
    final companion = ExpenseSplitsCompanion(
      id: Value(data['id'] as String),
      expenseId: Value(data['expenseId'] as String? ?? ''),
      userId: Value(data['userId'] as String? ?? ''),
      amount: Value((data['amount'] as num?)?.toDouble() ?? 0),
      isSettled: Value(data['isSettled'] as bool? ?? false),
      hlcTimestamp: Value(data['hlcTimestamp'] as String? ?? ''),
    );
    await db.into(db.expenseSplits).insertOnConflictUpdate(companion);
  }

  Future<void> _upsertSettlement(Map<String, dynamic> data) async {
    final companion = SettlementsCompanion(
      id: Value(data['id'] as String),
      tripId: Value(data['tripId'] as String? ?? ''),
      payerId: Value(data['payerId'] as String? ?? ''),
      payeeId: Value(data['payeeId'] as String? ?? ''),
      amount: Value((data['amount'] as num?)?.toDouble() ?? 0),
      currency: Value(data['currency'] as String? ?? 'BDT'),
      settledAt: Value(data['settledAt'] as int? ?? 0),
      notes: Value(data['notes'] as String?),
      hlcTimestamp: Value(data['hlcTimestamp'] as String? ?? ''),
      isDeleted: Value(data['isDeleted'] as bool? ?? false),
    );
    await db.into(db.settlements).insertOnConflictUpdate(companion);
  }

  Future<void> _upsertMessage(Map<String, dynamic> data) async {
    final companion = MessagesCompanion(
      id: Value(data['id'] as String),
      tripId: Value(data['tripId'] as String? ?? ''),
      senderId: Value(data['senderId'] as String? ?? ''),
      content: Value(data['content'] as String?),
      messageType: Value(data['messageType'] as String? ?? 'text'),
      imagePath: Value(data['imagePath'] as String?),
      sentAt: Value(data['sentAt'] as int? ?? 0),
      hlcTimestamp: Value(data['hlcTimestamp'] as String? ?? ''),
      isDeleted: Value(data['isDeleted'] as bool? ?? false),
    );
    await db.into(db.messages).insertOnConflictUpdate(companion);
  }

  Future<void> _upsertTripMember(Map<String, dynamic> data) async {
    final companion = TripMembersCompanion(
      tripId: Value(data['tripId'] as String? ?? ''),
      userId: Value(data['userId'] as String? ?? ''),
      role: Value(data['role'] as String? ?? 'member'),
      joinedAt: Value(data['joinedAt'] as int? ?? 0),
    );
    await db.into(db.tripMembers).insertOnConflictUpdate(companion);
  }

  Future<void> _softDeleteRecord(String tableName, String recordId) async {
    final hlc = HLC.send(HLC.now(localDeviceId)).toString();
    switch (tableName) {
      case 'expenses':
        await db.expenseDao.softDeleteExpense(recordId, hlc);
      case 'messages':
        await db.chatDao.softDeleteMessage(recordId, hlc);
    }
  }

  Future<void> recordChange({
    required String tableName,
    required String recordId,
    required String operation,
    required Map<String, dynamic> data,
  }) async {
    final hlc = HLC.send(HLC.now(localDeviceId));
    await db.syncDao.addToSyncQueue(SyncQueueCompanion(
      syncTableName: Value(tableName),
      recordId: Value(recordId),
      operation: Value(operation),
      payload: Value(jsonEncode(data)),
      hlcTimestamp: Value(hlc.toString()),
      createdAt: Value(DateTime.now().millisecondsSinceEpoch),
    ));
  }

  void dispose() {
    stop();
    _progressController.close();
  }
}
