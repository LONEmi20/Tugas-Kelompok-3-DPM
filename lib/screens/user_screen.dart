import 'dart:io';
import 'package:flutter/material.dart';
import 'package:tugas_kelompok_dpm/models/user_model.dart';
import 'package:tugas_kelompok_dpm/screens/user_edit_screen.dart';

class AccountScreen extends StatefulWidget {
  final User currentUser;
  const AccountScreen({super.key, required this.currentUser});

  @override
  State<AccountScreen> createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {
  late User _user;

  @override
  void initState() {
    super.initState();
<<<<<<< HEAD
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
=======
    _user = widget.currentUser;
>>>>>>> 8da38e30eaff57305e73c3c4ba10cfd1578d8129
  }

  void _navigateToEditScreen() async {
    final updatedUser = await Navigator.push<User>(
      context,
      MaterialPageRoute(builder: (context) => EditProfileScreen(user: _user)),
    );

    if (updatedUser != null) {
      setState(() {
        _user = updatedUser;
      });
    }
  }

  Widget _buildProfilePicture() {
    if (_user.profilePicture.isEmpty) {
      return CircleAvatar(
        radius: 50,
        backgroundColor: Colors.grey[200],
        child: Icon(Icons.person, size: 50, color: Colors.grey[600]),
      );
    } else {
      return CircleAvatar(
        radius: 50,
        backgroundImage: FileImage(File(_user.profilePicture)),
        backgroundColor: Colors.grey[200],
      );
    }
  }

  @override
  Widget build(BuildContext context) {
<<<<<<< HEAD
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
=======
    return WillPopScope(
      onWillPop: () async {
        Navigator.pop(context, _user);
        return false; 
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Akun Saya'),
          backgroundColor: const Color(0xFF004AAD),
          foregroundColor: Colors.white,
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 24.0),
          child: Card(
            elevation: 4.0,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  _buildProfilePicture(),
                  const SizedBox(height: 16.0),
                  Text(
                    _user.name,
                    style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center,
>>>>>>> 8da38e30eaff57305e73c3c4ba10cfd1578d8129
                  ),
                  const SizedBox(height: 32.0),
                  _buildInfoRow(label: 'Nomor Hp', value: _user.noHp),
                  const SizedBox(height: 16.0),
                  _buildInfoRow(label: 'Email', value: _user.email),
                  const SizedBox(height: 32.0),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: _navigateToEditScreen,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF004AAD),
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(vertical: 14.0),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
                      ),
                      child: const Text('Edit Profile', style: TextStyle(fontSize: 16)),
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
