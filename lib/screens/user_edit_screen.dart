import 'package:flutter/material.dart';
import 'package:tugas_kelompok_dpm/models/user_model.dart';

// Mengganti nama kelas agar konsisten
class EditProfileScreen extends StatefulWidget {
  final User user;

  const EditProfileScreen({super.key, required this.user});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _nameController;
  late final TextEditingController _emailController;
  late final TextEditingController _noHpController;

  @override
  void initState() {
    super.initState();
    // Inisialisasi controller dengan data user yang ada
    _nameController = TextEditingController(text: widget.user.name);
    _emailController = TextEditingController(text: widget.user.email);
    _noHpController = TextEditingController(text: widget.user.noHp);
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _noHpController.dispose();
    super.dispose();
  }

  // Fungsi untuk menyimpan perubahan
  void _saveProfile() {
    // Validasi form dulu
    if (_formKey.currentState!.validate()) {
      final updatedUser = User(
        name: _nameController.text,
        email: _emailController.text,
        noHp: _noHpController.text,
        password: widget.user.password, // Password tidak diubah di sini
        profilePicture: widget.user.profilePicture, // Gambar profil tetap sama
      );
      // Kembali ke halaman sebelumnya dan kirim data user yang baru
      Navigator.pop(context, updatedUser);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Profile'),
        backgroundColor: const Color(0xFF004AAD),
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextFormField(
                controller: _nameController,
                decoration: const InputDecoration(
                  labelText: 'Nama',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.person_outline),
                ),
                validator: (value) => (value == null || value.isEmpty) ? 'Nama tidak boleh kosong' : null,
              ),
              const SizedBox(height: 16.0),

              TextFormField(
                controller: _emailController,
                decoration: const InputDecoration(
                  labelText: 'Email',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.email_outlined),
                ),
                keyboardType: TextInputType.emailAddress,
                validator: (value) => (value == null || !value.contains('@')) ? 'Masukkan email yang valid' : null,
              ),
              const SizedBox(height: 16.0),

              TextFormField(
                controller: _noHpController,
                decoration: const InputDecoration(
                  labelText: 'Nomor Hp',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.phone_outlined),
                ),
                keyboardType: TextInputType.phone,
                validator: (value) => (value == null || value.isEmpty) ? 'Nomor Hp tidak boleh kosong' : null,
              ),
              const SizedBox(height: 32.0),

              ElevatedButton(
                onPressed: _saveProfile,
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF004AAD),
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 16.0),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
                ),
                child: const Text('Simpan Perubahan'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
