import 'package:flutter/material.dart';
import 'package:tugas_kelompok_dpm/models/user_model.dart';
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
  bool _isPasswordVisible = false;

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
          MaterialPageRoute(builder: (context) => HomeScreen(currentUser: user)),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Email atau password salah!'), backgroundColor: Colors.red),
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
                // [FIX] Menggunakan logo yang dinamis
                Image.asset(logoAsset, height: 50),
                const SizedBox(height: 48),
                const Text('Selamat Datang kembali!', textAlign: TextAlign.center, style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600)),
                const SizedBox(height: 40),
                TextFormField(
                  controller: _emailController,
                  decoration: const InputDecoration(label: Text('Email')),
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
                    label: const Text('Password'),
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
                    onPressed: _performLogin,
                    style: OutlinedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      side: BorderSide(color: Theme.of(context).colorScheme.primary, width: 1.5),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
                    ),
                    child: Text('Sign In', style: TextStyle(fontSize: 16, color: Theme.of(context).colorScheme.primary)),
                  ),
                const SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text('Belum punya akun?'),
                    TextButton(
                      onPressed: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context) => const SignUpScreen()));
                      },
                      child: Text('Daftar', style: TextStyle(fontWeight: FontWeight.bold, color: Theme.of(context).colorScheme.primary)),
                    ),
                  ],
                ),
                Align(
                  alignment: Alignment.center,
                  child: TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const ForgotPasswordScreen()),
                      );
                    },
                    child: Text('Lupa password?', style: TextStyle(color: Theme.of(context).colorScheme.primary)),
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
