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

  // Helper untuk navigasi biar kode lebih rapi
  void _navigateTo(BuildContext context, Widget screen) {
    Navigator.pop(context); // Tutup drawer
    Navigator.push(context, MaterialPageRoute(builder: (context) => screen));
  }

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
          _buildDrawerHeader(context),
          
          // --- SEMUA MENU SUDAH DIUPDATE ---
          _buildMenuItem(
            imageAsset: 'assets/img/list/ACC.png', 
            text: 'Akun', 
            textStyle: textStyle, 
            onTap: () => _navigateTo(context, const AccountScreen())
          ),
          
          _buildMenuItem(
            imageAsset: 'assets/img/list/monetization.png',
            text: 'Support Admin',
            textStyle: textStyle, 
            onTap: () => _navigateTo(context, const SupportScreen())
          ),
          
          ExpansionTile(
            leading: Image.asset('assets/img/list/extension.png', width: 30, color: textColor),
            title: const Text('Kategori berita', style: textStyle),
            trailing: const Icon(Icons.keyboard_arrow_down, color: textColor),
            children: [
              _buildSubMenuItem(text: 'Olahraga', style: subTextStyle, onTap: () => _navigateToCategory(context, 'Olahraga')),
              _buildSubMenuItem(text: 'Politik', style: subTextStyle, onTap: () => _navigateToCategory(context, 'Politik')),
              _buildSubMenuItem(text: 'Hiburan', style: subTextStyle, onTap: () => _navigateToCategory(context, 'Hiburan')),
              _buildSubMenuItem(text: 'Gaya Hidup', style: subTextStyle, onTap: () => _navigateToCategory(context, 'Gaya Hidup')),
              _buildSubMenuItem(text: 'Teknologi', style: subTextStyle, onTap: () => _navigateToCategory(context, 'Teknologi')),
            ],
          ),

          _buildMenuItem(
            imageAsset: 'assets/img/list/card_giftcard.png', 
            text: 'Reward', 
            textStyle: textStyle, 
            onTap: () => _navigateTo(context, const RewardScreen())
          ),
          _buildMenuItem(
            imageAsset: 'assets/img/list/settings.png', 
            text: 'Pengaturan', 
            textStyle: textStyle, 
            onTap: () => _navigateTo(context, const SettingsScreen())
          ),
          const Divider(height: 1, thickness: 0.5),
          _buildMenuItem(
            imageAsset: 'assets/img/list/logout.png',
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

  Widget _buildDrawerHeader(BuildContext context) {
    // Header ini sekarang bisa diklik untuk ke halaman profil juga
    return GestureDetector(
      onTap: () => _navigateTo(context, const AccountScreen()),
      child: Container(
        height: 114,
        padding: const EdgeInsets.fromLTRB(21, 40, 16, 0),
        decoration: const BoxDecoration(color: Color(0xFF004AAD)),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Stack(
              children: [
                // Ganti dengan foto profil user asli nanti
                const CircleAvatar(radius: 25, backgroundImage: AssetImage('assets/img/bob.png')),
                Positioned(
                  right: 0,
                  top: 0,
                  child: Container(
                    width: 10,
                    height: 10,
                    decoration: BoxDecoration(
                      color: Colors.red,
                      shape: BoxShape.circle,
                      border: Border.all(color: const Color(0xFF004AAD), width: 1),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(width: 13),
            // Ganti dengan nama user asli nanti
            const Text('Nama Pengguna', style: TextStyle(color: Colors.white, fontSize: 16, fontFamily: 'League Spartan', fontWeight: FontWeight.w700)),
            const Spacer(),
            const Icon(Icons.arrow_forward_ios, color: Colors.white, size: 18),
          ],
        ),
      ),
    );
  }

  Widget _buildMenuItem({required String imageAsset, required String text, required TextStyle textStyle, required VoidCallback onTap}) {
    return ListTile(
      leading: Image.asset(imageAsset, width: 30, color: const Color(0xFF224699)),
      title: Text(text, style: textStyle),
      onTap: onTap,
      dense: true,
    );
  }

  Widget _buildSubMenuItem({required String text, required TextStyle style, required VoidCallback onTap}) {
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
