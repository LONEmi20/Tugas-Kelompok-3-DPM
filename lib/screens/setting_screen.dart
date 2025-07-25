import 'package:flutter/material.dart';
<<<<<<< HEAD
import 'package:tugas_kelompok_dpm/screens/login_admin_screen.dart';
=======
import 'package:provider/provider.dart';
import 'package:tugas_kelompok_dpm/providers/settings_provider.dart';
import 'package:tugas_kelompok_dpm/screens/login_admin_screen.dart'; 
>>>>>>> 8da38e30eaff57305e73c3c4ba10cfd1578d8129

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final settingsProvider = Provider.of<SettingsProvider>(context);
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
          SwitchListTile(
<<<<<<< HEAD
            secondary: Image.asset(
              'assets/img/list/brightness.png',
              width: 24,
              color: iconColor,
            ),
=======
            secondary: Icon(settingsProvider.themeMode == ThemeMode.dark ? Icons.dark_mode : Icons.light_mode, color: iconColor),
>>>>>>> 8da38e30eaff57305e73c3c4ba10cfd1578d8129
            title: const Text('Mode Gelap'),
            value: settingsProvider.themeMode == ThemeMode.dark,
            onChanged: (value) {
              final newTheme = value ? ThemeMode.dark : ThemeMode.light;
              settingsProvider.setTheme(newTheme);
            },
          ),
          SwitchListTile(
<<<<<<< HEAD
            secondary: Image.asset(
              'assets/img/list/notifications_active.png',
              width: 24,
              color: iconColor,
            ),
=======
            secondary: Icon(Icons.notifications, color: iconColor),
>>>>>>> 8da38e30eaff57305e73c3c4ba10cfd1578d8129
            title: const Text('Notifikasi'),
            value: true, 
            onChanged: (value) {
            },
          ),
<<<<<<< HEAD

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
=======
          ListTile(
            leading: Icon(Icons.font_download, color: iconColor),
            title: const Text('Ukuran Font'),
            subtitle: Slider(
              value: settingsProvider.fontScale,
              min: 0.8,
              max: 1.4,
              divisions: 3,
              label: settingsProvider.fontScale == 0.8 ? 'Kecil' : settingsProvider.fontScale == 1.0 ? 'Normal' : settingsProvider.fontScale == 1.2 ? 'Besar' : 'Sangat Besar',
              onChanged: (value) {
                double newScale;
                if (value < 0.9) newScale = 0.8;
                else if (value < 1.1) newScale = 1.0;
                else if (value < 1.3) newScale = 1.2;
                else newScale = 1.4;
                settingsProvider.setFontScale(newScale);
              },
            ),
          ),
          const Divider(),
          ListTile(
            leading: Image.asset(
              'assets/img/list/report_problem.png',
              width: 30, 
              color: iconColor,
            ),
            title: const Text('Manajemen Berita'),
            subtitle: const Text('Tambah atau edit berita (Khusus Admin)'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const LoginAdminScreen()),
              );
            },
>>>>>>> 8da38e30eaff57305e73c3c4ba10cfd1578d8129
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
