import 'package:flutter/material.dart';

class FacebookLoginOverlay extends StatelessWidget {
  final VoidCallback onLoginPressed;

  const FacebookLoginOverlay({super.key, required this.onLoginPressed});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Container(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.facebook, color: Colors.blue, size: 40),
            const SizedBox(height: 20),
            const Text(
              'Masuk ke akun Facebook Anda untuk terhubung dengan MikirLUK News',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 14, color: Colors.grey),
            ),
            const SizedBox(height: 20),
            const TextField(
              decoration: InputDecoration(
                labelText: 'Email atau Nomor Telepon',
              ),
            ),
            const SizedBox(height: 10),
            const TextField(
              obscureText: true,
              decoration: InputDecoration(
                labelText: 'Kata Sandi',
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
                foregroundColor: Colors.white,
                minimumSize: const Size(double.infinity, 50),
              ),
              onPressed: () {
                Navigator.of(context).pop();
                onLoginPressed();
              },
              child: const Text('Masuk'),
            ),
          ],
        ),
      ),
    );
  }
}