import 'package:flutter/material.dart';
import 'package:tugas_kelompok_dpm/models/user_model.dart';
import 'package:tugas_kelompok_dpm/screens/main_screen.dart';
import 'package:tugas_kelompok_dpm/screens/login_screen.dart';
import 'package:tugas_kelompok_dpm/services/local_auth_service.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _checkLoginStatus();
  }

  Future<void> _checkLoginStatus() async {
    final authService = LocalAuthService();
    await Future.delayed(const Duration(seconds: 2));

    final User? loggedInUser = await authService.getLoggedInUser();

    if (mounted) {
      if (loggedInUser != null) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => HomeScreen(currentUser: loggedInUser),
          ),
        );
      } else {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const LoginScreen()),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDarkMode =
        MediaQuery.of(context).platformBrightness == Brightness.dark;
    final logoAsset = isDarkMode
        ? 'assets/img/logo_white.png'
        : 'assets/img/Logo-mikirluk.png';
    final backgroundColor = isDarkMode ? const Color(0xFF121212) : Colors.white;

    return Scaffold(
      backgroundColor: backgroundColor,
      body: Center(child: Image.asset(logoAsset, width: 280)),
    );
  }
}
