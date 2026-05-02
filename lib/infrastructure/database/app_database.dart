import 'dart:io';

import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';
import 'package:tiptap_tour/infrastructure/database/tables/budget_table.dart';
import 'package:tiptap_tour/infrastructure/database/tables/expenses_table.dart';
import 'package:tiptap_tour/infrastructure/database/tables/messages_table.dart';
import 'package:tiptap_tour/infrastructure/database/tables/settlements_table.dart';
import 'package:tiptap_tour/infrastructure/database/tables/sync_queue_table.dart';
import 'package:tiptap_tour/infrastructure/database/tables/trips_table.dart';
import 'package:tiptap_tour/infrastructure/database/tables/users_table.dart';
import 'package:tiptap_tour/infrastructure/database/daos/trip_dao.dart';
import 'package:tiptap_tour/infrastructure/database/daos/expense_dao.dart';
import 'package:tiptap_tour/infrastructure/database/daos/chat_dao.dart';
import 'package:tiptap_tour/infrastructure/database/daos/sync_dao.dart';
import 'package:tiptap_tour/infrastructure/database/daos/user_dao.dart';

part 'app_database.g.dart';

@DriftDatabase(
  tables: [
    Users,
    Trips,
    TripMembers,
    Expenses,
    ExpenseSplits,
    Settlements,
    Messages,
    BudgetPools,
    BudgetContributions,
    SyncQueue,
    PeerSyncState,
  ],
  daos: [
    TripDao,
    ExpenseDao,
    ChatDao,
    SyncDao,
    UserDao,
  ],
)
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(_openConnection());

  AppDatabase.forTesting(super.e);

  @override
  int get schemaVersion => 1;

  @override
  MigrationStrategy get migration {
    return MigrationStrategy(
      onCreate: (Migrator m) async {
        await m.createAll();
      },
      onUpgrade: (Migrator m, int from, int to) async {
        // Future migrations go here
      },
    );
  }
}

LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    final dbFolder = await getApplicationDocumentsDirectory();
    final file = File(p.join(dbFolder.path, 'tiptap_tour.sqlite'));
    return NativeDatabase.createInBackground(file);
  });
}
