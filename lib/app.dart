import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:tiptap_tour/application/providers/settings_providers.dart';
import 'package:tiptap_tour/core/router/app_router.dart';
import 'package:tiptap_tour/presentation/theme/app_theme.dart';

class TiptapTourApp extends ConsumerStatefulWidget {
  final bool isFirstLaunch;

  const TiptapTourApp({super.key, this.isFirstLaunch = true});

  @override
  ConsumerState<TiptapTourApp> createState() => _TiptapTourAppState();
}

class _TiptapTourAppState extends ConsumerState<TiptapTourApp> {
  late final GoRouter _router;

  @override
  void initState() {
    super.initState();
    _router = createRouter(isFirstLaunch: widget.isFirstLaunch);
  }

  @override
  void dispose() {
    _router.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final themeMode = ref.watch(themeProvider);

    return MaterialApp.router(
      title: 'Tip Tap Tour',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.light,
      darkTheme: AppTheme.dark,
      themeMode: themeMode,
      routerConfig: _router,
    );
  }
}
