import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sms_owner/core/storage/preferences.dart';

class ThemeCubit extends Cubit<ThemeMode> {
  ThemeCubit() : super(ThemeMode.system) {
    loadTheme();
  }

  /// Load saved theme from SharedPreferences
  Future<void> loadTheme() async {
    bool? isDarkMode = SharedPreferenceService.getBool('themeMode');

    emit(
      isDarkMode == null
          ? ThemeMode.system
          : isDarkMode
          ? ThemeMode.dark
          : ThemeMode.light,
    );
  }

  /// Toggle theme and save preference
  Future<void> toggleTheme() async {
    bool isCurrentlyDark = state == ThemeMode.dark;
    bool newTheme = !isCurrentlyDark;

    await SharedPreferenceService.setBool('themeMode', newTheme);
    emit(newTheme ? ThemeMode.dark : ThemeMode.light);
  }
}
