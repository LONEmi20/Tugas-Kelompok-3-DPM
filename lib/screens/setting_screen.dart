import 'package:flutter/material.dart';

void main() {
  runApp(const SettingsApp());
}

class SettingsApp extends StatelessWidget {
  const SettingsApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Pengaturan',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        appBarTheme: const AppBarTheme(
          backgroundColor: Color(0xFF0D47A1),
          foregroundColor: Colors.white,
        ),
      ),
      darkTheme: ThemeData.dark().copyWith(
        appBarTheme: const AppBarTheme(
          backgroundColor: Color(0xFF0D47A1),
          foregroundColor: Colors.white,
        ),
      ),
      themeMode: ThemeMode.light, // Ganti ini untuk mengetes dark mode
      home: const SettingsScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}

// Halaman utama Pengaturan
class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  // Variabel untuk mengelola state dari setiap pengaturan
  bool _isDarkMode = false;
  bool _notificationsEnabled = true;
  double _fontSize = 16.0;

  @override
  Widget build(BuildContext context) {
    // Ikon yang digunakan di dalam list
    final iconColor = Theme.of(context).brightness == Brightness.dark
        ? Colors.white70
        : const Color(0xFF0D47A1);

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            // Cukup panggil pop untuk kembali ke halaman sebelumnya
            Navigator.pop(context);
          },
        ),
        title: const Text('Reward Coins'),
        backgroundColor: const Color(0xFF004AAD),
        foregroundColor: Colors.white,
      ),
      body: ListView(
        children: [
          // Pengaturan Mode Gelap/Terang
          ListTile(
            leading: Image.asset(
              'assets/img/list/mode_icon.png', // Ganti dengan nama file Anda
              width: 24,
              color: iconColor,
              errorBuilder: (_, __, ___) =>
                  Icon(Icons.brightness_6, color: iconColor),
            ),
            title: const Text('Mode Terang/Mode Gelap'),
            trailing: Switch(
              value: _isDarkMode,
              onChanged: (value) {
                setState(() {
                  _isDarkMode = value;
                  // Di aplikasi nyata, Anda akan mengubah tema aplikasi di sini
                  // Contoh: menggunakan provider atau state management lainnya.
                });
              },
            ),
          ),

          // Pengaturan Notifikasi
          ListTile(
            leading: Image.asset(
              'assets/img/list/notification_icon.png', // Ganti dengan nama file Anda
              width: 24,
              color: iconColor,
              errorBuilder: (_, __, ___) =>
                  Icon(Icons.notifications, color: iconColor),
            ),
            title: const Text('Notifikasi'),
            trailing: Switch(
              value: _notificationsEnabled,
              onChanged: (value) {
                setState(() {
                  _notificationsEnabled = value;
                });
              },
            ),
          ),

          // Pengaturan Ukuran Font dengan ExpansionTile
          ExpansionTile(
            leading: Image.asset(
              'assets/img/list/font_icon.png', // Ganti dengan nama file Anda
              width: 24,
              color: iconColor,
              errorBuilder: (_, __, ___) =>
                  Icon(Icons.format_size, color: iconColor),
            ),
            title: const Text('Ukuran font'),
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16.0,
                  vertical: 8.0,
                ),
                child: Row(
                  children: [
                    Image.asset(
                      'assets/img/list/search_icon_small.png', // Ganti dengan nama file Anda
                      width: 18,
                      color: iconColor,
                      errorBuilder: (_, __, ___) =>
                          Icon(Icons.format_size, size: 18, color: iconColor),
                    ),
                    Expanded(
                      child: Slider(
                        value: _fontSize,
                        min: 12.0,
                        max: 24.0,
                        divisions: 4,
                        label: _fontSize.round().toString(),
                        onChanged: (value) {
                          setState(() {
                            _fontSize = value;
                          });
                        },
                      ),
                    ),
                    Image.asset(
                      'assets/img/list/search_icon_large.png', // Ganti dengan nama file Anda
                      width: 24,
                      color: iconColor,
                      errorBuilder: (_, __, ___) =>
                          Icon(Icons.format_size, size: 24, color: iconColor),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
