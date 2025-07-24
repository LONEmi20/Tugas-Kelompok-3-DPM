import 'package:flutter/material.dart';

class GoogleLoginOverlay extends StatelessWidget {
  // Callback sekarang menerima email yang dipilih
  final Function(String email) onAccountSelected;

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
            // Aku tambahin akun dummy sesuai database awal kita
            _buildAccountTile(
              context,
              name: 'Akun User',
              email: 'akunuser@gmail.com', 
              avatarAsset: 'assets/img/bob.png', 
            ),
            _buildAccountTile(
              context,
              name: 'Evan Verlanma',
              email: 'everlanma@email.com',
              avatarAsset: 'assets/img/profile_evan.jpg', 
            ),
            _buildAccountTile(
              context,
              name: 'Firefly',
              email: 'hotaru@hsr.com', 
              avatarAsset: 'assets/img/firefly.png', 
            ),
             _buildAccountTile(
              context,
              name: 'Spring',
              email: 'spring@example.com',
              avatarAsset: 'assets/img/profile_mic.jpg', 
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
        // Kirim email yang dipilih ke halaman login
        onAccountSelected(email); 
      },
    );
  }
}
