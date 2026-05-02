import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';

/// Manages the app theme mode (system, light, dark) backed by Hive storage.
class ThemeNotifier extends StateNotifier<ThemeMode> {
  ThemeNotifier() : super(_loadInitialTheme());

  static ThemeMode _loadInitialTheme() {
    final box = Hive.box('settings');
    final stored = box.get('themeMode', defaultValue: 'system') as String;
    return _parseThemeMode(stored);
  }

  static ThemeMode _parseThemeMode(String value) {
    switch (value) {
      case 'light':
        return ThemeMode.light;
      case 'dark':
        return ThemeMode.dark;
      default:
        return ThemeMode.system;
    }
  }

  static String _themeModeToString(ThemeMode mode) {
    switch (mode) {
      case ThemeMode.light:
        return 'light';
      case ThemeMode.dark:
        return 'dark';
      case ThemeMode.system:
        return 'system';
    }
  }

  Future<void> setThemeMode(ThemeMode mode) async {
    final box = Hive.box('settings');
    await box.put('themeMode', _themeModeToString(mode));
    state = mode;
  }
}

final themeProvider = StateNotifierProvider<ThemeNotifier, ThemeMode>((ref) {
  return ThemeNotifier();
});

/// Manages the default currency preference backed by Hive storage.
class CurrencyNotifier extends StateNotifier<String> {
  CurrencyNotifier() : super(_loadInitialCurrency());

  static String _loadInitialCurrency() {
    final box = Hive.box('settings');
    return box.get('defaultCurrency', defaultValue: 'BDT') as String;
  }

  Future<void> setCurrency(String currency) async {
    final box = Hive.box('settings');
    await box.put('defaultCurrency', currency);
    state = currency;
  }
}

final currencyProvider =
    StateNotifierProvider<CurrencyNotifier, String>((ref) {
  return CurrencyNotifier();
});
