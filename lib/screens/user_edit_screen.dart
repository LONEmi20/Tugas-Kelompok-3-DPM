import 'dart:io';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart';
import 'package:tugas_kelompok_dpm/models/user_model.dart';
import 'package:tugas_kelompok_dpm/services/local_auth_service.dart';

class EditProfileScreen extends StatefulWidget {
  final User user;
  const EditProfileScreen({super.key, required this.user});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final _formKey = GlobalKey<FormState>();
  final _authService = LocalAuthService();

  late final TextEditingController _nameController;
  late final TextEditingController _noHpController;
  late final TextEditingController _emailController;

  late String _originalNoHp;
  late String _originalEmail;

  File? _selectedImage;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.user.name);
    _noHpController = TextEditingController(text: widget.user.noHp);
    _emailController = TextEditingController(text: widget.user.email);

    _originalNoHp = widget.user.noHp;
    _originalEmail = widget.user.email;
  }

  @override
  void dispose() {
    _nameController.dispose();
    _noHpController.dispose();
    _emailController.dispose();
    super.dispose();
  }

  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(
      source: ImageSource.gallery,
      imageQuality: 50,
    );
    if (pickedFile != null) {
      setState(() => _selectedImage = File(pickedFile.path));
    }
  }

  Future<void> _handleSave() async {
    if (!_formKey.currentState!.validate()) return;

    final bool noHpChanged = _noHpController.text != _originalNoHp;
    final bool emailChanged = _emailController.text != _originalEmail;

    if (noHpChanged && emailChanged) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Harap ubah email dan nomor HP satu per satu.'),
          backgroundColor: Colors.orange,
        ),
      );
      return;
    }

    if (noHpChanged) {
      _showVerificationDialog(
        verificationType: 'Email',
        target: _originalEmail,
      );
    } else if (emailChanged) {
      _showVerificationDialog(
        verificationType: 'Nomor HP',
        target: _originalNoHp,
      );
    } else {
      _performUpdate();
    }
  }

  Future<void> _showVerificationDialog({
    required String verificationType,
    required String target,
  }) async {
    final otp = (Random().nextInt(9000) + 1000).toString();
    final otpController = TextEditingController();

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Kode OTP (simulasi) dikirim ke $target: $otp'),
        duration: const Duration(seconds: 6),
      ),
    );

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Verifikasi Perubahan $verificationType'),
          content: TextField(
            controller: otpController,
            keyboardType: TextInputType.number,
            decoration: const InputDecoration(labelText: 'Masukkan Kode OTP'),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Batal'),
            ),
            TextButton(
              onPressed: () {
                if (otpController.text == otp) {
                  Navigator.pop(context);
                  _performUpdate();
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Kode OTP salah!'),
                      backgroundColor: Colors.red,
                    ),
                  );
                }
              },
              child: const Text('Verifikasi'),
            ),
          ],
        );
      },
    );
  }

  Future<void> _performUpdate() async {
    setState(() => _isLoading = true);

    String newImagePath = widget.user.profilePicture;
    if (_selectedImage != null) {
      try {
        final appDir = await getApplicationDocumentsDirectory();
        final fileName = path.basename(_selectedImage!.path);
        final savedImage = await _selectedImage!.copy(
          '${appDir.path}/$fileName',
        );
        newImagePath = savedImage.path;
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Gagal menyimpan gambar.'),
            backgroundColor: Colors.red,
          ),
        );
        setState(() => _isLoading = false);
        return;
      }
    }

    final updatedUser = User(
      name: _nameController.text,
      noHp: _noHpController.text,
      email: _emailController.text,
      profilePicture: newImagePath,
      password: widget.user.password,
    );

    final success = await _authService.updateUser(updatedUser, _originalEmail);

    if (mounted) {
      if (success) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Profil berhasil diperbarui!'),
            backgroundColor: Colors.green,
          ),
        );
        Navigator.pop(context, updatedUser);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Gagal memperbarui profil.'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }

    if (mounted) setState(() => _isLoading = false);
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
              Center(
                child: GestureDetector(
                  onTap: _pickImage,
                  child: CircleAvatar(
                    radius: 60,
                    backgroundColor: Colors.grey[200],
                    backgroundImage: _selectedImage != null
                        ? FileImage(_selectedImage!)
                        : (widget.user.profilePicture.isNotEmpty
                                  ? FileImage(File(widget.user.profilePicture))
                                  : null)
                              as ImageProvider?,
                    child:
                        widget.user.profilePicture.isEmpty &&
                            _selectedImage == null
                        ? Icon(
                            Icons.camera_alt,
                            color: Colors.grey[800],
                            size: 30,
                          )
                        : null,
                  ),
                ),
              ),
              const SizedBox(height: 8),
              const Center(child: Text("Ketuk gambar untuk mengubah")),
              const SizedBox(height: 32.0),
              TextFormField(
                controller: _nameController,
                decoration: const InputDecoration(
                  labelText: 'Nama',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.person_outline),
                ),
                validator: (value) => (value == null || value.isEmpty)
                    ? 'Nama tidak boleh kosong'
                    : null,
              ),
              const SizedBox(height: 16.0),
              TextFormField(
                controller: _emailController,
                decoration: const InputDecoration(
                  labelText: 'Email',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.email_outlined),
                ),
                validator: (value) => (value == null || !value.contains('@'))
                    ? 'Email tidak valid'
                    : null,
              ),
              const SizedBox(height: 16.0),
              TextFormField(
                controller: _noHpController,
                decoration: const InputDecoration(
                  labelText: 'Nomor HP',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.phone_outlined),
                ),
                keyboardType: TextInputType.phone,
              ),
              const SizedBox(height: 32.0),
              ElevatedButton(
                onPressed: _isLoading ? null : _handleSave,
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size(double.infinity, 50),
                  backgroundColor: const Color(0xFF004AAD),
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                ),
                child: _isLoading
                    ? const CircularProgressIndicator(color: Colors.white)
                    : const Text('Simpan Perubahan'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
