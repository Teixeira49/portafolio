// lib/providers/app_provider.dart
import 'package:flutter/material.dart';

class AppProvider extends ChangeNotifier {
  Locale? _locale;

  AppProvider(this._locale);

  Locale? get locale => _locale;

  void setLocale(Locale? newLocale) {
    if (_locale == newLocale) return;

    _locale = newLocale;

    notifyListeners();
  }
}
