// ignore_for_file: use_super_parameters

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../services/theme_service.dart';
import '../di/service_locator.dart';

class ThemeCubit extends Cubit<ThemeMode> {
  final ThemeService _service = getIt<ThemeService>();

  ThemeCubit(ThemeMode initial) : super(initial);

  static Future<ThemeCubit> create() async {
    final service = getIt<ThemeService>();
    final mode = await service.getSavedThemeMode();
    return ThemeCubit(mode);
  }

  Future<void> toggle() async {
    final next = state == ThemeMode.dark ? ThemeMode.light : ThemeMode.dark;
    emit(next);
    await _service.saveThemeMode(next);
  }

  Future<void> setMode(ThemeMode mode) async {
    emit(mode);
    await _service.saveThemeMode(mode);
  }
}
