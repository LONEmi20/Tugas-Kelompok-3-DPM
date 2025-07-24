import 'package:flutter/material.dart';
// Pastikan path import ini sesuai dengan struktur proyek Anda
import 'package:tugas_kelompok_dpm/models/user_model.dart';
import 'package:tugas_kelompok_dpm/screens/user_edit_screen.dart';

// Nama kelas di user_screen.dart adalah AccountView
class AccountView extends StatefulWidget {
  const AccountView({super.key});

  @override
  State<AccountView> createState() => _AccountViewState();
}

class _AccountViewState extends State<AccountView> {
  // Data user dijadikan state agar bisa diperbarui
  late User user;

  @override
  void initState() {
    super.initState();
    // Inisialisasi data user awal (parameter note dihapus)
    user = User(
      name: 'Mic',
      noHp: '6282212345678',
      email: 'micgredy@gmail.com',
      password: 'supersecretpassword',
      profilePicture: 'assets/img/profile_mic.jpg',
    );
  }

  // Fungsi untuk navigasi ke halaman edit dan menerima data kembali
  void _navigateToEditScreen(BuildContext context) async {
    // Navigasi ke UserEditScreen dan tunggu hasilnya
    final result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => EditProfileView(user: user)),
    );

    // Jika ada data yang dikembalikan, perbarui state
    if (result != null && result is User) {
      setState(() {
        user = result;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            // Cukup panggil pop untuk kembali ke halaman sebelumnya
            Navigator.pop(context);
          },
        ),
        title: const Text('Account'),
        backgroundColor: const Color(0xFF004AAD),
        foregroundColor: Colors.white,
      ),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 24.0),
          child: Card(
            elevation: 5.0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15.0),
            ),
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Center(
                    child: CircleAvatar(
                      radius: 50,
                      backgroundImage: AssetImage(user.profilePicture),
                      backgroundColor: Colors.grey[200],
                    ),
                  ),
                  const SizedBox(height: 16.0),
                  Center(
                    child: Text(
                      user.name,
                      style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  const SizedBox(height: 32.0),
                  _buildInfoRow('Nomor Hp', user.noHp),
                  const SizedBox(height: 16.0),
                  _buildInfoRow('Email', user.email),
                  const SizedBox(height: 32.0),
                  _buildInfoRow('Note', '', isNote: true),
                  const SizedBox(height: 32.0), // SizedBox disesuaikan
                  ElevatedButton(
                    onPressed: () {
                      // Panggil fungsi navigasi saat tombol ditekan
                      _navigateToEditScreen(context);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.grey[200],
                      foregroundColor: Colors.black87,
                      side: BorderSide(color: Colors.grey[400]!),
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      padding: const EdgeInsets.symmetric(vertical: 14.0),
                    ),
                    child: const Text(
                      'Edit Profile',
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  // Widget helper untuk menampilkan info (parameter isNote dihapus)
  Widget _buildInfoRow(String label, String value, {bool isNote = false}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: TextStyle(color: Colors.grey[600], fontSize: 12)),
        const SizedBox(height: 4.0),
        if (isNote)
          const TextField(
            maxLines: 3,
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              contentPadding: EdgeInsets.all(12.0),
            ),
          )
        else
          Text(
            value,
            style: const TextStyle(fontSize: 16, color: Colors.black87),
          ),
      ],
    );
  }
}
