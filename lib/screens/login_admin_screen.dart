import 'package:flutter/material.dart';
import 'package:tugas_kelompok_dpm/screens/manage_berita_screen.dart';

<<<<<<< HEAD
// --- TAMBAHKAN CLASS UNTUK MEREPRESENTASIKAN AKUN ADMIN ---
=======
// Class sederhana untuk merepresentasikan akun admin
>>>>>>> 8da38e30eaff57305e73c3c4ba10cfd1578d8129
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

<<<<<<< HEAD
  // --- BUAT LIST AKUN ADMIN ---
  final List<Admin> _adminAccounts = [
    Admin(email: 'admin@example.com', password: 'admin123'),
    Admin(email: 'micgredy@gmail.com', password: 'mic'),
=======
  // Daftar akun admin (disimpan di dalam kode untuk sementara)
  final List<Admin> _adminAccounts = [
    Admin(email: 'admin@example.com', password: 'admin123'),
    Admin(email: 'mic@gmail.com', password: 'mic'),
>>>>>>> 8da38e30eaff57305e73c3c4ba10cfd1578d8129
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

<<<<<<< HEAD
=======
    // Cek apakah email dan password cocok dengan salah satu akun admin
>>>>>>> 8da38e30eaff57305e73c3c4ba10cfd1578d8129
    final bool isValidAdmin = _adminAccounts.any(
      (acc) =>
          acc.email.toLowerCase() == email.toLowerCase() &&
          acc.password == password,
    );

    if (isValidAdmin) {
<<<<<<< HEAD
      // Jika akun ditemukan di list
=======
>>>>>>> 8da38e30eaff57305e73c3c4ba10cfd1578d8129
      if (mounted) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const ManageBeritaScreen()),
        );
      }
    } else {
<<<<<<< HEAD
      // Jika akun tidak ditemukan
=======
>>>>>>> 8da38e30eaff57305e73c3c4ba10cfd1578d8129
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
<<<<<<< HEAD
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Container(
              color: const Color(0xFF004AAD),
              child: SafeArea(
                bottom: false,
                child: Row(
                  children: [
                    IconButton(
                      icon: const Icon(Icons.arrow_back, color: Colors.white),
                      onPressed: () => Navigator.of(context).pop(),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 24.0,
                vertical: 16.0,
              ),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const SizedBox(height: 40),
                    Image.asset('assets/img/Logo-mikirluk.png', height: 80),
                    const SizedBox(height: 40),
                    const Text(
                      'Hanya khusus Admin!',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.w600,
                        color: Colors.black87,
                      ),
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
                            setState(() {
                              _isPasswordVisible = !_isPasswordVisible;
                            });
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
                          side: const BorderSide(
                            color: Color(0xFF224699),
                            width: 1.5,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                        ),
                        child: const Text(
                          'Sign In',
                          style: TextStyle(
                            fontSize: 16,
                            color: Color(0xFF224699),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                  ],
                ),
              ),
            ),
          ],
=======
    // Logika untuk memilih logo berdasarkan tema
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    final logoAsset = isDarkMode ? 'assets/img/logo_white.png' : 'assets/img/Logo-mikirluk.png';

    return Scaffold(
      appBar: AppBar(
        // AppBar dibuat transparan agar menyatu dengan container di bawahnya
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: isDarkMode ? Colors.white : const Color(0xFF004AAD)),
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
                        _isPasswordVisible ? Icons.visibility_off : Icons.visibility,
                      ),
                      onPressed: () {
                        setState(() => _isPasswordVisible = !_isPasswordVisible);
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
                      side: BorderSide(color: Theme.of(context).colorScheme.primary, width: 1.5),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
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
>>>>>>> 8da38e30eaff57305e73c3c4ba10cfd1578d8129
        ),
      ),
    );
  }
}
