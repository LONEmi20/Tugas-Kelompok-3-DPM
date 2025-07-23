import 'package:flutter/material.dart';

class GoogleLoginOverlay extends StatelessWidget {
  final VoidCallback onAccountSelected;

  const GoogleLoginOverlay({super.key, required this.onAccountSelected});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
      child: Container(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Image.asset('assets/img/google_icon.png', height: 24), 
            const SizedBox(height: 16),
            const Text(
              'Pilih akun',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            const Text(
              'untuk melanjutkan ke MikirLUK News',
              style: TextStyle(fontSize: 14, color: Colors.grey),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 24),
            // Daftar Akun Dummy
            _buildAccountTile(
              context,
              name: 'Evan Verlanma',
              email: 'everlanma@email.com',
              avatarAsset: 'assets/img/firefly.jpg', 
            ),
            _buildAccountTile(
              context,
              name: 'Firefly',
              email: 'HotaruAR26710@email.com', 
              avatarAsset: 'assets/img/firefly.png', 
            ),
             _buildAccountTile(
              context,
              name: 'Spring',
              email: 'spring@email.com',
              avatarAsset: 'assets/img/brt/firefly2.png', 
            ),
             _buildAccountTile(
              context,
              name: 'Another Account',
              email: 'another.account@email.com', 
              avatarAsset: 'assets/img/iklan1.png', 
            ),
          ],
        ),
      ),
    );
  }

  // Widget untuk satu baris akun
  Widget _buildAccountTile(BuildContext context, {required String name, required String email, required String avatarAsset}) {
    return ListTile(
      leading: CircleAvatar(
        backgroundImage: AssetImage(avatarAsset),
        onBackgroundImageError: (e, s) => const Icon(Icons.person), 
      ),
      title: Text(name),
      subtitle: Text(email),
      onTap: () {
        Navigator.of(context).pop(); 
        onAccountSelected(); 
      },
    );
  }
}
