// lib/providers/app_provider.dart
import 'package:flutter/material.dart';

class AppProvider extends ChangeNotifier {
  Locale? _locale;

  AppProvider(this._locale);

  Locale? get locale => _locale;

  ThemeMode _themeMode = ThemeMode.system;

  ThemeMode get themeMode => _themeMode;

  void setThemeMode(ThemeMode mode) {
    _themeMode = mode;
    notifyListeners();
  }

  void toggleTheme() {
    if (_themeMode == ThemeMode.dark) {
      setThemeMode(ThemeMode.light);
    } else {
      setThemeMode(ThemeMode.dark);
    }
  }

  void setLocale(Locale? newLocale) {
    if (_locale == newLocale) return;

    _locale = newLocale;

    notifyListeners();
  }
}
