import 'package:flutter/material.dart';
import '../storage/shared_prefs.dart';
import '../constants/storage_constant.dart';

class ThemeService {
  Future<ThemeMode> getSavedThemeMode() async {
    final value = SharedPrefs.getString(StorageKeys.themeMode);
    switch (value) {
      case 'light':
        return ThemeMode.light;
      case 'dark':
        return ThemeMode.dark;
      default:
        return ThemeMode.system;
    }
  }

  Future<void> saveThemeMode(ThemeMode mode) async {
    final value = mode == ThemeMode.light
        ? 'light'
        : mode == ThemeMode.dark
            ? 'dark'
            : 'system';
    await SharedPrefs.setString(StorageKeys.themeMode, value);
  }
}
