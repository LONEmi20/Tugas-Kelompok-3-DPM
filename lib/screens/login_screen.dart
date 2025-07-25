import 'package:flutter/material.dart';
import 'package:tugas_kelompok_dpm/screens/forgot_password_screen.dart';
import 'package:tugas_kelompok_dpm/screens/main_screen.dart';
import 'package:tugas_kelompok_dpm/screens/signup_screen.dart';
import 'package:tugas_kelompok_dpm/services/local_auth_service.dart';
import 'package:tugas_kelompok_dpm/widgets/apple_login_overlay.dart';
import 'package:tugas_kelompok_dpm/widgets/facebook_login_overlay.dart';
import 'package:tugas_kelompok_dpm/widgets/google_login_overlay.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _localAuthService = LocalAuthService();

  bool _isLoading = false;
  bool _isPasswordVisible = false; // State untuk show/hide password

  // --- LOGIN UTAMA (via Email/pw) ---
  Future<void> _performLogin() async {
    if (!_formKey.currentState!.validate()) return;
    
    setState(() => _isLoading = true);

    final user = await _localAuthService.login(
      _emailController.text.trim(),
      _passwordController.text.trim(),
    );

    if (mounted) {
      if (user != null) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const HomeScreen()),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Email atau password salah!'), backgroundColor: Colors.red),
        );
      }
    }
    
    if (mounted) setState(() => _isLoading = false);
  }

  // --- Login Dummy Sosmed dengan TOKEN ---
  Future<void> _performSocialLogin(String email) async {
    if (_isLoading) return;
    setState(() => _isLoading = true);

    final success = await _localAuthService.loginWithSocial(email);

    if (mounted) {
      if(success) {
         Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const HomeScreen()),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Akun dengan email $email tidak ditemukan.'), backgroundColor: Colors.red),
        );
      }
    }
     if (mounted) setState(() => _isLoading = false);
  }

  // --- Tampilkan overlay sosmed ---
  void _showGoogleOverlay() {
    showDialog(
      context: context,
      builder: (context) => GoogleLoginOverlay(onAccountSelected: _performSocialLogin),
    );
  }

  void _showFacebookOverlay() {
    // Note: Facebook overlay masih dummy, perlu email asli untuk token
    // Untuk contoh, kita pakai email dummy
    showDialog(
      context: context,
      builder: (context) => FacebookLoginOverlay(onLoginPressed: () => _performSocialLogin("fb.user@example.com")),
    );
  }

  void _showAppleOverlay() {
    // Note: Apple overlay masih dummy, perlu email asli untuk token
    // Untuk contoh, kita pakai email dummy
    showDialog(
      context: context,
      builder: (context) => AppleLoginOverlay(onLoginPressed: () => _performSocialLogin("apple.user@example.com")),
    );
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final socialButtonStyle = OutlinedButton.styleFrom(
      padding: const EdgeInsets.symmetric(vertical: 14),
      side: BorderSide(color: Colors.grey.shade400),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
      foregroundColor: Colors.black,
    );

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {},
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Image.asset('assets/img/Logo-mikirluk.png', height: 50),
                const SizedBox(height: 48),
                const Text('Selamat Datang kembali!', textAlign: TextAlign.center, style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600)),
                const SizedBox(height: 40),
                TextFormField(
                  controller: _emailController,
                  decoration: const InputDecoration(label: Text('Email')),
                  keyboardType: TextInputType.emailAddress,
                  validator: (value) => (value == null || !value.contains('@')) ? 'Format email tidak valid' : null,
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: _passwordController,
                  obscureText: !_isPasswordVisible, // Terapkan state di sini
                  decoration: InputDecoration(
                    label: const Text('Password'),
                    // --- TOMBOL MATA ---
                    suffixIcon: IconButton(
                      icon: Icon(_isPasswordVisible ? Icons.visibility_off : Icons.visibility),
                      onPressed: () {
                        setState(() {
                          _isPasswordVisible = !_isPasswordVisible;
                        });
                      },
                    ),
                  ),
                  validator: (value) => value!.isEmpty ? 'Password tidak boleh kosong' : null,
                ),
                const SizedBox(height: 32),
                if (_isLoading)
                  const Center(child: CircularProgressIndicator())
                else
                  OutlinedButton(
                    onPressed: _performLogin,
                    style: OutlinedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      side: const BorderSide(color: Color(0xFF224699), width: 1.5),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
                    ),
                    child: const Text('Sign In', style: TextStyle(fontSize: 16, color: Color(0xFF224699))),
                  ),
                const SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text('Belum punya akun?'),
                    TextButton(
                      onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) => const SignUpScreen())),
                      child: const Text('Daftar', style: TextStyle(fontWeight: FontWeight.bold, color: Color(0xFF224699))),
                    ),
                  ],
                ),
                Align(
                  alignment: Alignment.center,
                  child: TextButton(
                    // --- NAVIGASI KE LUPA PASSWORD ---
                    onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) => const ForgotPasswordScreen())),
                    child: const Text('Lupa password?', style: TextStyle(color: Color(0xFF224699))),
                  ),
                ),
                const SizedBox(height: 24),
                Row(
                  children: [
                    const Expanded(child: Divider()),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10.0),
                      child: Text('atau', style: TextStyle(color: Colors.grey.shade600)),
                    ),
                    const Expanded(child: Divider()),
                  ],
                ),
                const SizedBox(height: 32),
                OutlinedButton.icon(
                  onPressed: _showGoogleOverlay,
                  icon: Image.asset('assets/img/google_icon.png', height: 24),
                  label: const Text('Masuk dengan Google'),
                  style: socialButtonStyle,
                ),
                const SizedBox(height: 16),
                OutlinedButton.icon(
                  onPressed: _showFacebookOverlay,
                  icon: const Icon(Icons.facebook, color: Colors.blue, size: 24),
                  label: const Text('Masuk dengan Facebook'),
                  style: socialButtonStyle,
                ),
                const SizedBox(height: 16),
                OutlinedButton.icon(
                  onPressed: _showAppleOverlay,
                  icon: const Icon(Icons.apple, color: Colors.black, size: 24),
                  label: const Text('Masuk dengan Apple'),
                  style: socialButtonStyle,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
