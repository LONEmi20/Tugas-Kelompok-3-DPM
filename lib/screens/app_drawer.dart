import 'dart:io';
import 'package:flutter/material.dart';
import 'package:tugas_kelompok_dpm/models/user_model.dart';
import 'package:tugas_kelompok_dpm/screens/category_screen.dart';
import 'package:tugas_kelompok_dpm/screens/login_screen.dart';
import 'package:tugas_kelompok_dpm/screens/reward_screen.dart';
import 'package:tugas_kelompok_dpm/screens/setting_screen.dart';
import 'package:tugas_kelompok_dpm/screens/support_screen.dart';
import 'package:tugas_kelompok_dpm/screens/user_screen.dart';
import 'package:tugas_kelompok_dpm/services/local_auth_service.dart';

class AppMenuDrawer extends StatelessWidget {
  final User currentUser;
  final Function(User) onProfileUpdated;

  const AppMenuDrawer({
    super.key, 
    required this.currentUser, 
    required this.onProfileUpdated
  });

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
  
  Future<void> _navigateToAccount(BuildContext context) async {
    Navigator.pop(context); 
    final result = await Navigator.push(
      context, 
      MaterialPageRoute(builder: (context) => AccountScreen(currentUser: currentUser))
    );

    if (result is User) {
      onProfileUpdated(result);
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textColor = theme.brightness == Brightness.dark ? Colors.white70 : const Color(0xFF224699);
    
    final textStyle = TextStyle(
      color: textColor,
      fontSize: 16,
      fontFamily: 'League Spartan',
      fontWeight: FontWeight.w600,
    );
    final subTextStyle = TextStyle(
      color: textColor,
      fontSize: 12,
      fontFamily: 'League Spartan',
      fontWeight: FontWeight.w600,
    );

    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
<<<<<<< HEAD
          _buildDrawerHeader(),
          _buildMenuItem(
            icon: Icons.account_circle, // Menggunakan Icon
            text: 'Akun',
            textStyle: textStyle,
            onTap: () {
              Navigator.pop(context); // Tutup drawer dulu
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const AccountScreen()),
              );
            },
          ),

=======
          _buildDrawerHeader(context),
          _buildMenuItem(
            icon: Icons.account_circle,
            text: 'Akun',
            textStyle: textStyle,
            onTap: () => _navigateToAccount(context),
          ),
>>>>>>> 8da38e30eaff57305e73c3c4ba10cfd1578d8129
          _buildMenuItem(
            imageAsset:
                'assets/img/list/monetization.png', // Menggunakan ImageAsset
            text: 'Support Admin',
            textStyle: textStyle,
<<<<<<< HEAD
            onTap: () {
              Navigator.pop(context); // Tutup drawer dulu
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const SupportScreen()),
              );
            },
          ),

          ExpansionTile(
            leading: Image.asset(
              'assets/img/list/extension.png',
              width: 30,
              color: textColor,
            ),
            title: const Text('Kategori berita', style: textStyle),
            trailing: const Icon(Icons.keyboard_arrow_down, color: textColor),
=======
            onTap: () => _navigateTo(context, const SupportScreen()),
          ),
          ExpansionTile(
            leading: Image.asset('assets/img/list/extension.png', width: 30, color: textColor),
            title: Text('Kategori berita', style: textStyle),
            trailing: Icon(Icons.keyboard_arrow_down, color: textColor),
>>>>>>> 8da38e30eaff57305e73c3c4ba10cfd1578d8129
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
<<<<<<< HEAD
            icon: Icons.card_giftcard, // Menggunakan Icon
            text: 'Reward',
            textStyle: textStyle,
            onTap: () {
              Navigator.pop(context); // Tutup drawer dulu
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const RewardApp()),
              );
            },
          ),
          _buildMenuItem(
            icon: Icons.settings, // Menggunakan Icon
            text: 'Pengaturan',
            textStyle: textStyle,
            onTap: () {
              Navigator.pop(context); // Tutup drawer dulu
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const SettingsScreen()),
              );
            },
=======
            icon: Icons.card_giftcard,
            text: 'Reward',
            textStyle: textStyle,
            onTap: () => _navigateTo(context, const RewardScreen()),
          ),
          _buildMenuItem(
            icon: Icons.settings,
            text: 'Pengaturan',
            textStyle: textStyle,
            onTap: () => _navigateTo(context, const SettingsScreen()),
>>>>>>> 8da38e30eaff57305e73c3c4ba10cfd1578d8129
          ),
          const Divider(height: 1, thickness: 0.5),
          _buildMenuItem(
            imageAsset: 'assets/img/list/logout.png', // Menggunakan ImageAsset
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

<<<<<<< HEAD
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
=======
  Widget _buildDrawerHeader(BuildContext context) {
    return GestureDetector(
      onTap: () => _navigateToAccount(context),
      child: Container(
        height: 120,
        padding: const EdgeInsets.fromLTRB(21, 40, 16, 16),
        decoration: const BoxDecoration(color: Color(0xFF004AAD)),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CircleAvatar(
              radius: 25,
              backgroundImage: currentUser.profilePicture.isNotEmpty
                  ? FileImage(File(currentUser.profilePicture))
                  : const AssetImage('assets/img/bob.png') as ImageProvider,
            ),
            const SizedBox(width: 13),
            Expanded(
              child: Text(
                currentUser.name, 
                style: const TextStyle(color: Colors.white, fontSize: 16, fontFamily: 'League Spartan', fontWeight: FontWeight.w700),
                overflow: TextOverflow.ellipsis,
              ),
            ),
            const Icon(Icons.arrow_forward_ios, color: Colors.white, size: 18),
          ],
        ),
>>>>>>> 8da38e30eaff57305e73c3c4ba10cfd1578d8129
      ),
    );
  }

<<<<<<< HEAD
  // --- FUNGSI YANG DIPERBAIKI ---
=======
>>>>>>> 8da38e30eaff57305e73c3c4ba10cfd1578d8129
  Widget _buildMenuItem({
    IconData? icon,
    String? imageAsset,
    required String text,
    required TextStyle textStyle,
    required VoidCallback onTap,
  }) {
<<<<<<< HEAD
    // Memastikan hanya salah satu dari icon atau imageAsset yang diberikan
    assert(
      icon != null || imageAsset != null,
      'Provide either an icon or an imageAsset.',
    );
    assert(
      icon == null || imageAsset == null,
      'Cannot provide both icon and imageAsset.',
    );

    Widget leadingWidget;
    const iconColor = Color(0xFF224699);

    if (imageAsset != null) {
      // Jika imageAsset ada, gunakan Image.asset
      leadingWidget = Image.asset(imageAsset, width: 30, color: iconColor);
    } else {
      // Jika tidak, gunakan Icon
=======
    assert(icon != null || imageAsset != null, 'Provide either an icon or an imageAsset.');
    assert(icon == null || imageAsset == null, 'Cannot provide both icon and imageAsset.');

    Widget leadingWidget;
    final iconColor = textStyle.color;

    if (imageAsset != null) {
      leadingWidget = Image.asset(imageAsset, width: 30, color: iconColor);
    } else {
>>>>>>> 8da38e30eaff57305e73c3c4ba10cfd1578d8129
      leadingWidget = Icon(icon, color: iconColor, size: 30);
    }

    return ListTile(
      leading: leadingWidget,
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
