import 'package:flutter/material.dart';
import 'package:tugas_kelompok_dpm/screens/manage_berita_screen.dart';

// Class sederhana untuk merepresentasikan akun admin
class Admin {
  final String email;
  final String password;

  Admin({required this.email, required this.password});
}

class LoginAdminScreen extends StatefulWidget {
  const LoginAdminScreen({super.key});

  @override
  State<LoginAdminScreen> createState() => _LoginAdminScreenState();
}

class _LoginAdminScreenState extends State<LoginAdminScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  // Daftar akun admin (disimpan di dalam kode untuk sementara)
  final List<Admin> _adminAccounts = [
    Admin(email: 'admin@example.com', password: 'admin123'),
    Admin(email: 'mic@gmail.com', password: 'mic'),
    Admin(email: 'evan@gmail.com', password: 'evan123'),
  ];

  bool _isLoading = false;
  bool _isPasswordVisible = false;

  Future<void> _performLogin() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    setState(() => _isLoading = true);
    await Future.delayed(const Duration(seconds: 1));

    final email = _emailController.text.trim();
    final password = _passwordController.text.trim();

    // Cek apakah email dan password cocok dengan salah satu akun admin
    final bool isValidAdmin = _adminAccounts.any(
      (acc) =>
          acc.email.toLowerCase() == email.toLowerCase() &&
          acc.password == password,
    );

    if (isValidAdmin) {
      if (mounted) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const ManageBeritaScreen()),
        );
      }
    } else {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Email atau password admin salah!'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }

    if (mounted) {
      setState(() => _isLoading = false);
    }
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Logika untuk memilih logo berdasarkan tema
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    final logoAsset = isDarkMode
        ? 'assets/img/logo_white.png'
        : 'assets/img/Logo-mikirluk.png';

    return Scaffold(
      appBar: AppBar(
        // AppBar dibuat transparan agar menyatu dengan container di bawahnya
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: isDarkMode ? Colors.white : const Color(0xFF004AAD),
          ),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const SizedBox(height: 40),
                Image.asset(logoAsset, height: 80),
                const SizedBox(height: 40),
                const Text(
                  'Hanya khusus Admin!',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.w600),
                ),
                const SizedBox(height: 50),
                TextFormField(
                  controller: _emailController,
                  decoration: const InputDecoration(labelText: 'Email'),
                  keyboardType: TextInputType.emailAddress,
                  validator: (value) {
                    if (value == null || !value.contains('@')) {
                      return 'Format email tidak valid';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 24),
                TextFormField(
                  controller: _passwordController,
                  obscureText: !_isPasswordVisible,
                  decoration: InputDecoration(
                    labelText: 'Password',
                    suffixIcon: IconButton(
                      icon: Icon(
                        _isPasswordVisible
                            ? Icons.visibility_off
                            : Icons.visibility,
                      ),
                      onPressed: () {
                        setState(
                          () => _isPasswordVisible = !_isPasswordVisible,
                        );
                      },
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Password tidak boleh kosong';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 48),
                if (_isLoading)
                  const Center(child: CircularProgressIndicator())
                else
                  OutlinedButton(
                    onPressed: _performLogin,
                    style: OutlinedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      side: BorderSide(
                        color: Theme.of(context).colorScheme.primary,
                        width: 1.5,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                    ),
                    child: Text(
                      'Sign In',
                      style: TextStyle(
                        fontSize: 16,
                        color: Theme.of(context).colorScheme.primary,
                        fontWeight: FontWeight.bold,
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
}
