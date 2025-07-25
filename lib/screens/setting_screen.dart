import 'package:flutter/material.dart';
import 'package:tugas_kelompok_dpm/screens/login_admin_screen.dart';

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
    final iconColor = Theme.of(context).brightness == Brightness.dark
        ? Colors.white70
        : const Color(0xFF224699);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Pengaturan'),
        backgroundColor: const Color(0xFF004AAD),
        foregroundColor: Colors.white,
      ),
      body: ListView(
        children: [
          // Pengaturan Mode Gelap/Terang
          SwitchListTile(
            secondary: Image.asset(
              'assets/img/list/brightness.png',
              width: 24,
              color: iconColor,
            ),
            title: const Text('Mode Gelap'),
            value: _isDarkMode,
            onChanged: (value) {
              setState(() {
                _isDarkMode = value;
                // Di aplikasi nyata, di sini kita akan mengubah tema aplikasi
              });
            },
          ),

          // Pengaturan Notifikasi
          SwitchListTile(
            secondary: Image.asset(
              'assets/img/list/notifications_active.png',
              width: 24,
              color: iconColor,
            ),
            title: const Text('Notifikasi'),
            value: _notificationsEnabled,
            onChanged: (value) {
              setState(() {
                _notificationsEnabled = value;
              });
            },
          ),

          // Pengaturan Ukuran Font
          ExpansionTile(
            leading: Image.asset(
              'assets/img/list/zoom_in.png',
              width: 24,
              color: iconColor,
            ),
            title: const Text('Ukuran Font'),
            subtitle: Text('Sekarang: ${_fontSize.round()}'),
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16.0,
                  vertical: 8.0,
                ),
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
            ],
          ),

          // --- AWAL PERUBAHAN ---
          // Tombol Manajemen Berita
          ListTile(
            leading: Image.asset(
              'assets/img/list/report_problem.png', // <-- Ganti dengan path ikon yang sesuai
              width: 24,
              color: iconColor,
            ),
            title: const Text('Manajemen Berita'),
            onTap: () {
              Navigator.pop(context); // Tutup drawer dulu
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const LoginAdminScreen(),
                ),
              );
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Navigasi ke Manajemen Berita')),
              );
            },
          ),
          // --- AKHIR PERUBAHAN ---
        ],
      ),
    );
  }
}
