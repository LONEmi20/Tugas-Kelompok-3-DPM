import 'package:flutter/material.dart';
import 'package:tugas_kelompok_dpm/models/user_model.dart';
import 'package:tugas_kelompok_dpm/screens/user_edit_screen.dart';

// Mengganti nama kelas agar konsisten
class AccountScreen extends StatefulWidget {
  const AccountScreen({super.key});

  @override
  State<AccountScreen> createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {
  // Data user dijadikan state agar bisa diperbarui saat kembali dari halaman edit
  late User user;

  @override
  void initState() {
    super.initState();
    // Inisialisasi data user awal (dummy data)
    // Nanti ini bisa diganti dengan data user yang sedang login
    user = User(
      name: 'Spring', // Nama kamu, hehe
      noHp: '081234567890',
      email: 'spring@example.com',
      password: 'supersecretpassword',
      // Aku ganti foto profilnya pake Firefly, sesuai request! ;)
      profilePicture: 'assets/img/firefly.png',
    );
  }

  // Fungsi untuk navigasi ke halaman edit dan menerima data yang sudah diupdate
  void _navigateToEditScreen() async {
    final updatedUser = await Navigator.push<User>(
      context,
      MaterialPageRoute(builder: (context) => EditProfileScreen(user: user)),
    );

    // Jika ada data yang dikembalikan (artinya user menekan simpan), perbarui UI
    if (updatedUser != null) {
      setState(() {
        user = updatedUser;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Akun Saya'),
        backgroundColor: const Color(0xFF004AAD),
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 24.0),
        child: Card(
          elevation: 4.0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15.0),
          ),
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Foto Profil
                CircleAvatar(
                  radius: 50,
                  backgroundImage: AssetImage(user.profilePicture),
                  onBackgroundImageError:
                      (_, __) {}, // Handle error jika gambar tak ada
                  backgroundColor: Colors.grey[200],
                ),
                const SizedBox(height: 16.0),

                // Nama Pengguna
                Text(
                  user.name,
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 32.0),

                // Info Detail
                _buildInfoRow(label: 'Nomor Hp', value: user.noHp),
                const SizedBox(height: 16.0),
                _buildInfoRow(label: 'Email', value: user.email),
                const SizedBox(height: 32.0),

                // Tombol Edit
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: _navigateToEditScreen,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF004AAD),
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 14.0),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                    ),
                    child: const Text(
                      'Edit Profile',
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // Widget helper untuk menampilkan baris info
  Widget _buildInfoRow({required String label, required String value}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label.toUpperCase(),
          style: TextStyle(
            color: Colors.grey[600],
            fontSize: 12,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 4.0),
        Text(
          value,
          style: const TextStyle(fontSize: 16, color: Colors.black87),
        ),
        const SizedBox(height: 8.0),
        const Divider(),
      ],
    );
  }
}
