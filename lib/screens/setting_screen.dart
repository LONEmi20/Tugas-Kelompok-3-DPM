import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tugas_kelompok_dpm/providers/settings_provider.dart';
import 'package:tugas_kelompok_dpm/screens/login_admin_screen.dart'; 

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
            secondary: Icon(settingsProvider.themeMode == ThemeMode.dark ? Icons.dark_mode : Icons.light_mode, color: iconColor),
            title: const Text('Mode Gelap'),
            value: settingsProvider.themeMode == ThemeMode.dark,
            onChanged: (value) {
              final newTheme = value ? ThemeMode.dark : ThemeMode.light;
              settingsProvider.setTheme(newTheme);
            },
          ),
          SwitchListTile(
            secondary: Icon(Icons.notifications, color: iconColor),
            title: const Text('Notifikasi'),
            value: true, 
            onChanged: (value) {
            },
          ),
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
          ),
        ],
      ),
    );
  }
}
