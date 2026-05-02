import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tiptap_tour/application/providers/settings_providers.dart';
import 'package:tiptap_tour/core/router/app_router.dart';
import 'package:tiptap_tour/presentation/theme/app_theme.dart';

class TiptapTourApp extends ConsumerWidget {
  final bool isFirstLaunch;

  const TiptapTourApp({super.key, this.isFirstLaunch = true});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeMode = ref.watch(themeProvider);
    final router = createRouter(isFirstLaunch: isFirstLaunch);

    return MaterialApp.router(
      title: 'Tiptap Tour',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.light,
      darkTheme: AppTheme.dark,
      themeMode: themeMode,
      routerConfig: router,
    );
  }
}
