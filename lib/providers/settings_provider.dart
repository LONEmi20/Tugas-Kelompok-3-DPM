import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

// Ini adalah "Remote Control" kita
class SettingsProvider with ChangeNotifier {
  ThemeMode _themeMode = ThemeMode.light; // Defaultnya mode terang
  double _fontScale = 1.0; // Defaultnya ukuran font normal

  ThemeMode get themeMode => _themeMode;
  double get fontScale => _fontScale;

  SettingsProvider() {
    // Langsung load settingan pas aplikasi pertama kali jalan
    _loadSettings();
  }

  // Fungsi buat ganti tema
  void setTheme(ThemeMode themeMode) async {
    _themeMode = themeMode;
    notifyListeners(); // Kasih tau semua halaman buat ganti tampilan
    
    // Simpen pilihan tema
    final prefs = await SharedPreferences.getInstance();
    prefs.setInt('theme', themeMode.index);
  }

  // Fungsi buat ganti ukuran font
  void setFontScale(double scale) async {
    _fontScale = scale;
    notifyListeners(); // Kasih tau semua halaman buat ganti ukuran font
    
    // Simpen pilihan ukuran font
    final prefs = await SharedPreferences.getInstance();
    prefs.setDouble('fontScale', scale);
  }

  // Fungsi buat ngambil settingan yang tersimpan
  Future<void> _loadSettings() async {
    final prefs = await SharedPreferences.getInstance();
    
    // Ambil tema, kalo gak ada pake default (terang)
    final themeIndex = prefs.getInt('theme') ?? 0;
    _themeMode = ThemeMode.values[themeIndex];
    
    // Ambil ukuran font, kalo gak ada pake default (normal)
    _fontScale = prefs.getDouble('fontScale') ?? 1.0;
    
    notifyListeners();
  }
}
