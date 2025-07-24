import 'package:flutter/material.dart';
import 'package:tugas_kelompok_dpm/screens/category_screen.dart';
import 'package:tugas_kelompok_dpm/screens/login_screen.dart';
import 'package:tugas_kelompok_dpm/screens/reward_screen.dart';
import 'package:tugas_kelompok_dpm/screens/setting_screen.dart';
import 'package:tugas_kelompok_dpm/screens/support_screen.dart';
import 'package:tugas_kelompok_dpm/screens/user_screen.dart';
import 'package:tugas_kelompok_dpm/services/local_auth_service.dart';

class AppMenuDrawer extends StatelessWidget {
  const AppMenuDrawer({super.key});

  void _navigateToCategory(BuildContext context, String categoryName) {
    Navigator.pop(context);
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => CategoryScreen(categoryName: categoryName),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    const textColor = Color(0xFF224699);
    const textStyle = TextStyle(
      color: textColor,
      fontSize: 16,
      fontFamily: 'League Spartan',
      fontWeight: FontWeight.w600,
    );
    const subTextStyle = TextStyle(
      color: textColor,
      fontSize: 12,
      fontFamily: 'League Spartan',
      fontWeight: FontWeight.w600,
    );

    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          _buildDrawerHeader(),
          _buildMenuItem(
            icon: Icons.account_circle,
            text: 'Akun',
            textStyle: textStyle,
            onTap: () {
              Navigator.pop(context); // Tutup drawer dulu
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const AccountView()),
              );
            },
          ),

          _buildMenuItem(
            icon: Icons.monetization_on,
            text: 'Support Admin',
            textStyle: textStyle,
            // --- 2. PERUBAHAN DI SINI ---
            onTap: () {
              Navigator.pop(context); // Tutup drawer dulu
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const SupportScreen()),
              );
            },
          ),

          ExpansionTile(
            leading: const Icon(Icons.extension, color: textColor, size: 30),
            title: const Text('Kategori berita', style: textStyle),
            trailing: const Icon(Icons.keyboard_arrow_down, color: textColor),
            children: [
              _buildSubMenuItem(
                text: 'Olahraga',
                style: subTextStyle,
                onTap: () => _navigateToCategory(context, 'Olahraga'),
              ),
              _buildSubMenuItem(
                text: 'Politik',
                style: subTextStyle,
                onTap: () => _navigateToCategory(context, 'Politik'),
              ),
              _buildSubMenuItem(
                text: 'Hiburan',
                style: subTextStyle,
                onTap: () => _navigateToCategory(context, 'Hiburan'),
              ),
              _buildSubMenuItem(
                text: 'Gaya Hidup',
                style: subTextStyle,
                onTap: () => _navigateToCategory(context, 'Gaya Hidup'),
              ),
              _buildSubMenuItem(
                text: 'Teknologi',
                style: subTextStyle,
                onTap: () => _navigateToCategory(context, 'Teknologi'),
              ),
            ],
          ),

          _buildMenuItem(
            icon: Icons.card_giftcard,
            text: 'Reward',
            textStyle: textStyle,
            onTap: () {
              Navigator.pop(context); // Tutup drawer dulu
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const RewardScreen()),
              );
            },
          ),
          _buildMenuItem(
            icon: Icons.settings,
            text: 'Pengaturan',
            textStyle: textStyle,
            onTap: () {
              Navigator.pop(context); // Tutup drawer dulu
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const SettingsScreen()),
              );
            },
          ),
          const Divider(height: 1, thickness: 0.5),
          _buildMenuItem(
            icon: Icons.logout,
            text: 'Log out',
            textStyle: textStyle,
            onTap: () async {
              final authService = LocalAuthService();
              await authService.clearLoginSession();

              if (context.mounted) {
                Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(builder: (context) => const LoginScreen()),
                  (Route<dynamic> route) => false,
                );
              }
            },
          ),
        ],
      ),
    );
  }

  Widget _buildDrawerHeader() {
    return Container(
      height: 114,
      padding: const EdgeInsets.fromLTRB(21, 40, 16, 0),
      decoration: const BoxDecoration(color: Color(0xFF004AAD)),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Stack(
            children: [
              const CircleAvatar(
                radius: 25,
                backgroundImage: AssetImage('assets/img/bob.png'),
              ),
              Positioned(
                right: 0,
                top: 0,
                child: Container(
                  width: 10,
                  height: 10,
                  decoration: BoxDecoration(
                    color: Colors.red,
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: const Color(0xFF004AAD),
                      width: 1,
                    ),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(width: 13),
          const Text(
            'Nama Pengguna',
            style: TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontFamily: 'League Spartan',
              fontWeight: FontWeight.w700,
            ),
          ),
          const Spacer(),
          const Icon(Icons.arrow_forward_ios, color: Colors.white, size: 18),
        ],
      ),
    );
  }

  Widget _buildMenuItem({
    required IconData icon,
    required String text,
    required TextStyle textStyle,
    required VoidCallback onTap,
  }) {
    return ListTile(
      leading: Icon(icon, color: const Color(0xFF224699), size: 30),
      title: Text(text, style: textStyle),
      onTap: onTap,
      dense: true,
    );
  }

  Widget _buildSubMenuItem({
    required String text,
    required TextStyle style,
    required VoidCallback onTap,
  }) {
    return Padding(
      padding: const EdgeInsets.only(left: 70),
      child: ListTile(
        title: Text(text, style: style),
        onTap: onTap,
        dense: true,
      ),
    );
  }
}
