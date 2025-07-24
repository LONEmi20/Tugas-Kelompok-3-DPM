import 'package:flutter/material.dart';

class RewardScreen extends StatelessWidget {
  const RewardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Reward Coins'),
        backgroundColor: const Color(0xFF004AAD),
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Bagian Jumlah Koin
            _buildCoinBalance(),
            const SizedBox(height: 24),
            const Divider(),
            const SizedBox(height: 24),
            // Bagian Informasi Koin
            _buildCoinInfo(),
          ],
        ),
      ),
    );
  }

  Widget _buildCoinBalance() {
    return Row(
      children: [
        Image.asset(
          'assets/img/list/star_icon.png',
          width: 32,
          height: 32,
          errorBuilder: (context, error, stackTrace) => const Icon(Icons.star, size: 32, color: Colors.amber),
        ),
        const SizedBox(width: 12),
        const Text(
          '0 Koin', // Nanti bisa diganti dengan data asli
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.black87),
        ),
      ],
    );
  }

  Widget _buildCoinInfo() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 2.0),
          child: Image.asset(
            'assets/img/list/info_icon.png',
            width: 20,
            height: 20,
            color: Colors.blue.shade700,
            errorBuilder: (context, error, stackTrace) => Icon(Icons.info_outline, color: Colors.blue.shade700),
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Koin didapatkan dengan cara membaca berita dengan syarat dan ketentuan dan berikut:',
                style: TextStyle(fontSize: 15, color: Colors.black54, height: 1.5),
              ),
              const SizedBox(height: 12),
              _buildInfoPoint('Membaca selama 2 menit mendapatkan 20 koin.'),
              const SizedBox(height: 8),
              _buildInfoPoint('Kemudian, koin bisa ditukar dengan jumlah berikut:'),
              const SizedBox(height: 8),
              Padding(
                padding: const EdgeInsets.only(left: 20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildSubInfoPoint('Satu hari: 50 koin'),
                    _buildSubInfoPoint('Tiga hari: 150 koin'),
                    _buildSubInfoPoint('Tujuh hari: 340 koin'),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildInfoPoint(String text) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('• ', style: TextStyle(fontSize: 15, color: Colors.black54)),
        Expanded(child: Text(text, style: const TextStyle(fontSize: 15, color: Colors.black54, height: 1.5))),
      ],
    );
  }

  Widget _buildSubInfoPoint(String text) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('- ', style: TextStyle(fontSize: 15, color: Colors.black54)),
        Expanded(child: Text(text, style: const TextStyle(fontSize: 15, color: Colors.black54, height: 1.5))),
      ],
    );
  }
}
