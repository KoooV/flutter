import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// Cubit для управления режимом темы приложения (светлая / тёмная).
///
/// Текущее состояние — это значение [ThemeMode]. Режим сохраняется в
/// `SharedPreferences`, чтобы при повторном запуске приложения сохранился
/// выбор пользователя.
class ThemeCubit extends Cubit<ThemeMode> {
  static const _prefsKey = 'theme_mode';

  ThemeCubit() : super(ThemeMode.dark) {
    _load();
  }

  Future<void> _load() async {
    final prefs = await SharedPreferences.getInstance();
    final index = prefs.getInt(_prefsKey);
    if (index != null) {
      emit(ThemeMode.values[index.clamp(0, ThemeMode.values.length - 1)]);
    }
  }

  /// Переключает тему между светлой и тёмной.
  Future<void> toggleTheme() async {
    final next = state == ThemeMode.light ? ThemeMode.dark : ThemeMode.light;
    await _set(next);
  }

  /// Устанавливает заданный режим темы.
  Future<void> setTheme(ThemeMode mode) async {
    if (state == mode) return;
    await _set(mode);
  }

  Future<void> _set(ThemeMode mode) async {
    emit(mode);
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt(_prefsKey, mode.index);
  }
}
