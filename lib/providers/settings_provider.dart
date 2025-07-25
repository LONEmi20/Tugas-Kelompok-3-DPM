import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingsProvider with ChangeNotifier {
  ThemeMode _themeMode = ThemeMode.light;
  double _fontScale = 1.0;

  ThemeMode get themeMode => _themeMode;
  double get fontScale => _fontScale;

  SettingsProvider() {
    _loadSettings();
  }

  void setTheme(ThemeMode themeMode) async {
    _themeMode = themeMode;
    notifyListeners();

    final prefs = await SharedPreferences.getInstance();
    prefs.setInt('theme', themeMode.index);
  }

  void setFontScale(double scale) async {
    _fontScale = scale;
    notifyListeners();

    final prefs = await SharedPreferences.getInstance();
    prefs.setDouble('fontScale', scale);
  }

  Future<void> _loadSettings() async {
    final prefs = await SharedPreferences.getInstance();

    final themeIndex = prefs.getInt('theme') ?? 0;
    _themeMode = ThemeMode.values[themeIndex];

    _fontScale = prefs.getDouble('fontScale') ?? 1.0;

    notifyListeners();
  }
}
