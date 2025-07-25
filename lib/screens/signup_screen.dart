import 'dart:math';
import 'package:flutter/material.dart';
import 'package:tugas_kelompok_dpm/models/user_model.dart';
import 'package:tugas_kelompok_dpm/screens/main_screen.dart';
import 'package:tugas_kelompok_dpm/screens/otp_screen.dart';
import 'package:tugas_kelompok_dpm/services/local_auth_service.dart';
import 'package:tugas_kelompok_dpm/widgets/apple_login_overlay.dart';
import 'package:tugas_kelompok_dpm/widgets/facebook_login_overlay.dart';
import 'package:tugas_kelompok_dpm/widgets/google_login_overlay.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _phoneController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _localAuthService = LocalAuthService();
  
  bool _isLoading = false;
  bool _isPasswordVisible = false;

  Future<void> _performSignUp() async {
    if (!_formKey.currentState!.validate()) return;
    
    setState(() => _isLoading = true);

    final newUser = User(
      name: _nameController.text,
      noHp: _phoneController.text,
      email: _emailController.text,
      password: _passwordController.text,
    );

    final success = await _localAuthService.signUp(newUser);

    if (mounted) {
      if (success) {
        final otp = (Random().nextInt(9000) + 1000).toString();
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Kode OTP Anda (simulasi): $otp'), duration: const Duration(seconds: 5)),
        );
        
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => OtpScreen(
              phoneNumber: _phoneController.text,
              correctOtp: otp,
            ),
          ),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Email sudah terdaftar!'), backgroundColor: Colors.red),
        );
      }
    }
    
    if (mounted) setState(() => _isLoading = false);
  }

  Future<void> _performSocialDummyLogin() async {
    if (_isLoading) return;
    setState(() => _isLoading = true);
    await Future.delayed(const Duration(milliseconds: 1500));

    final dummyUser = User(
      name: "Social Media User", 
      noHp: "081234567890", 
      email: "social.user@example.com", 
      password: "",
      profilePicture: ""
    );

    if (mounted) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => HomeScreen(currentUser: dummyUser)),
      );
    }
  }
  
  void _showGoogleOverlay() {
    showDialog(
      context: context,
      builder: (context) => GoogleLoginOverlay(onAccountSelected: _performSocialDummyLogin),
    );
  }

  void _showFacebookOverlay() {
    showDialog(
      context: context,
      builder: (context) => FacebookLoginOverlay(onLoginPressed: _performSocialDummyLogin),
    );
  }

  void _showAppleOverlay() {
    showDialog(
      context: context,
      builder: (context) => AppleLoginOverlay(onLoginPressed: _performSocialDummyLogin),
    );
  }

  @override
  void dispose() {
    _nameController.dispose();
    _phoneController.dispose();
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
      foregroundColor: Theme.of(context).colorScheme.onSurface,
    );

    // [FIX] Logika untuk memilih logo berdasarkan tema
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    final logoAsset = isDarkMode ? 'assets/img/logo_white.png' : 'assets/img/Logo-mikirluk.png';

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
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
              children: <Widget>[
                // [FIX] Menggunakan logo yang dinamis
                Image.asset(logoAsset, height: 50),
                const SizedBox(height: 48),
                const Text('Selamat Datang!', textAlign: TextAlign.center, style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600)),
                const SizedBox(height: 40),
                TextFormField(
                  controller: _nameController,
                  decoration: const InputDecoration(labelText: 'Nama'),
                  validator: (value) => value!.isEmpty ? 'Nama tidak boleh kosong' : null,
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: _phoneController,
                  decoration: const InputDecoration(labelText: 'No. Hp'),
                  keyboardType: TextInputType.phone,
                  validator: (value) => value!.isEmpty ? 'No. Hp tidak boleh kosong' : null,
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: _emailController,
                  decoration: const InputDecoration(labelText: 'Email'),
                  keyboardType: TextInputType.emailAddress,
                  validator: (value) {
                    if (value == null || value.isEmpty) return 'Email tidak boleh kosong';
                    if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) return 'Format email tidak valid';
                    return null;
                  },
                ),
                const SizedBox(height: 16),
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
                    onPressed: _performSignUp,
                    style: OutlinedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      side: BorderSide(color: Theme.of(context).colorScheme.primary, width: 1.5),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
                    ),
                    child: Text('Sign Up', style: TextStyle(fontSize: 16, color: Theme.of(context).colorScheme.primary)),
                  ),
                const SizedBox(height: 32),
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
