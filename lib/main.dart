import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:tiptap_tour/app.dart';
import 'package:tiptap_tour/infrastructure/database/app_database.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Hive.initFlutter();

  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark,
      statusBarBrightness: Brightness.light,
    ),
  );

  final settingsBox = await Hive.openBox('settings');
  final isFirstLaunch = settingsBox.get('isFirstLaunch', defaultValue: true);

  // Migration: backfill displayName from database for users who onboarded
  // before the fix that persists it to Hive.
  if (!isFirstLaunch && !settingsBox.containsKey('displayName')) {
    final userId = settingsBox.get('userId') as String?;
    if (userId != null) {
      try {
        final db = AppDatabase();
        final user = await db.userDao.getUserById(userId);
        if (user != null) {
          await settingsBox.put('displayName', user.displayName);
        }
        await db.close();
      } catch (_) {}
    }
  }

  runApp(
    ProviderScope(
      child: TiptapTourApp(isFirstLaunch: isFirstLaunch),
    ),
  );
}
