import 'dart:math';
import 'package:flutter/material.dart';
import 'package:tugas_kelompok_dpm/screens/login_screen.dart';
import 'package:tugas_kelompok_dpm/services/local_auth_service.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final _formKey = GlobalKey<FormState>();
  final _authService = LocalAuthService();

  final _emailController = TextEditingController();
  final _otpController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  String _generatedOtp = '';
  bool _isOtpSent = false;
  bool _isOtpVerified = false;
  bool _isLoading = false;

  bool _isPasswordVisible = false;
  bool _isConfirmPasswordVisible = false;

  void _handleMainButtonAction() {
    if (!_isOtpSent) {
      _sendOtp();
    } else if (!_isOtpVerified) {
      _verifyOtp();
    } else {
      _updatePassword();
    }
  }

  Future<void> _sendOtp() async {
    if (!_formKey.currentState!.validate()) {
      final email = _emailController.text;
      if (email.isEmpty || !email.contains('@')) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Masukkan format email yang benar.'),
            backgroundColor: Colors.red,
          ),
        );
        return;
      }
    }

    setState(() => _isLoading = true);
    final emailExists = await _authService.checkEmailExists(
      _emailController.text.trim(),
    );

    if (mounted) {
      if (emailExists) {
        setState(() {
          _generatedOtp = (Random().nextInt(9000) + 1000).toString();
          _isOtpSent = true;
        });
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Kode OTP (simulasi) telah dikirim: $_generatedOtp'),
            backgroundColor: Colors.green,
          ),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Email tidak terdaftar.'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
    if (mounted) setState(() => _isLoading = false);
  }

  void _verifyOtp() {
    if (_otpController.text == _generatedOtp) {
      setState(() {
        _isOtpVerified = true;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('OTP benar! Silakan buat password baru.'),
          backgroundColor: Colors.green,
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Kode OTP salah!'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  Future<void> _updatePassword() async {
    if (!_formKey.currentState!.validate()) return;
    if (_passwordController.text != _confirmPasswordController.text) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Konfirmasi password tidak cocok!'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    setState(() => _isLoading = true);
    final success = await _authService.updatePassword(
      _emailController.text.trim(),
      _passwordController.text,
    );

    if (mounted) {
      if (success) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Password berhasil diperbarui! Silakan login.'),
            backgroundColor: Colors.blue,
          ),
        );
        Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (context) => const LoginScreen()),
          (Route<dynamic> route) => false,
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Gagal memperbarui password.'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
    if (mounted) setState(() => _isLoading = false);
  }

  @override
  void dispose() {
    _emailController.dispose();
    _otpController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final String buttonText = !_isOtpSent
        ? 'Kirim Kode OTP'
        : !_isOtpVerified
        ? 'Verifikasi OTP'
        : 'Update Password';

    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    final logoAsset = isDarkMode
        ? 'assets/img/logo_white.png'
        : 'assets/img/Logo-mikirluk.png';

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Image.asset(logoAsset, height: 50),
              const SizedBox(height: 48),
              const Text(
                'Lupa Password',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
              ),
              const SizedBox(height: 40),

              TextFormField(
                controller: _emailController,
                keyboardType: TextInputType.emailAddress,
                decoration: const InputDecoration(labelText: 'Email'),
                enabled: !_isOtpSent,
                validator: (value) => (value == null || !value.contains('@'))
                    ? 'Format email tidak valid'
                    : null,
              ),
              const SizedBox(height: 16),

              Visibility(
                visible: _isOtpSent,
                child: Column(
                  children: [
                    TextFormField(
                      controller: _otpController,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        labelText: 'Kode OTP',
                        enabled: !_isOtpVerified,
                      ),
                      validator: (value) =>
                          (_isOtpSent &&
                              !_isOtpVerified &&
                              (value == null || value.isEmpty))
                          ? 'Kode OTP harus diisi'
                          : null,
                    ),
                    const SizedBox(height: 16),
                  ],
                ),
              ),

              Visibility(
                visible: _isOtpVerified,
                child: Column(
                  children: [
                    TextFormField(
                      controller: _passwordController,
                      obscureText: !_isPasswordVisible,
                      decoration: InputDecoration(
                        labelText: 'Password Baru',
                        suffixIcon: IconButton(
                          icon: Icon(
                            _isPasswordVisible
                                ? Icons.visibility_off
                                : Icons.visibility,
                          ),
                          onPressed: () => setState(
                            () => _isPasswordVisible = !_isPasswordVisible,
                          ),
                        ),
                      ),
                      validator: (value) =>
                          (_isOtpVerified && (value == null || value.isEmpty))
                          ? 'Password baru harus diisi'
                          : null,
                    ),
                    const SizedBox(height: 16),
                    TextFormField(
                      controller: _confirmPasswordController,
                      obscureText: !_isConfirmPasswordVisible,
                      decoration: InputDecoration(
                        labelText: 'Konfirmasi Password Baru',
                        suffixIcon: IconButton(
                          icon: Icon(
                            _isConfirmPasswordVisible
                                ? Icons.visibility_off
                                : Icons.visibility,
                          ),
                          onPressed: () => setState(
                            () => _isConfirmPasswordVisible =
                                !_isConfirmPasswordVisible,
                          ),
                        ),
                      ),
                      validator: (value) {
                        if (_isOtpVerified &&
                            (value == null || value.isEmpty)) {
                          return 'Konfirmasi password harus diisi';
                        }
                        if (_isOtpVerified &&
                            value != _passwordController.text) {
                          return 'Password tidak cocok';
                        }
                        return null;
                      },
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 32),

              if (_isLoading)
                const Center(child: CircularProgressIndicator())
              else
                OutlinedButton(
                  onPressed: _handleMainButtonAction,
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
                    buttonText,
                    style: TextStyle(
                      fontSize: 16,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
