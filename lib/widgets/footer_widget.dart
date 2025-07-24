import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class FooterWidget extends StatelessWidget {
  const FooterWidget({super.key});

  void _launchURL(String url) async {
    final Uri uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    } else {
      print('Tidak bisa membuka $url');
    }
  }

  @override
  Widget build(BuildContext context) {
    const textColor = Color(0xFF224699);
    const titleStyle = TextStyle(
      fontFamily: 'League Spartan',
      fontWeight: FontWeight.w700,
      fontSize: 15,
      color: textColor,
    );
    const linkStyle = TextStyle(
      fontFamily: 'League Spartan',
      fontWeight: FontWeight.w400,
      fontSize: 12,
      color: textColor,
    );

    return Container(
      padding: const EdgeInsets.all(20),
      color: Colors.white, // Pastikan ada background color
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Site Map', style: titleStyle),
          const SizedBox(height: 8),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Text('Berita', style: linkStyle),
                    SizedBox(height: 4),
                    Text('Publishing', style: linkStyle),
                    SizedBox(height: 4),
                    Text('Tentang Kami', style: linkStyle),
                  ],
                ),
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Text('Karir', style: linkStyle),
                    SizedBox(height: 4),
                    Text('Kontak', style: linkStyle),
                    SizedBox(height: 4),
                    Text('Beriklan', style: linkStyle),
                  ],
                ),
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Text('Pedoman Media', style: linkStyle),
                    Text('Siber', style: linkStyle),
                  ],
                ),
              ),
            ],
          ),
          const Divider(height: 24, color: Color(0xFF6380EA)),
          const Center(
            child: Text(
              'Ikuti Kami di',
              style: TextStyle(
                fontFamily: 'League Spartan',
                fontWeight: FontWeight.w700,
                fontSize: 16,
                color: textColor,
              ),
            ),
          ),
          const SizedBox(height: 8),
          Positioned(
            left: 100,
            top: 100,
            child: GestureDetector(
              onTap: () {
                _launchURL('https://www.facebook.com/micgredy.micgredy.31/');
              },
              child: Container(
                width: 30,
                height: 30,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/img/FACEBOOK ICON.png'),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
          ),
          const Divider(height: 24, color: Color(0xFF6380EA)),
          const Text('Informasi', style: titleStyle),
          const SizedBox(height: 8),
          Row(
            children: [
              Image.asset('assets/img/local_phone.png', width: 16),
              const SizedBox(width: 8),
              const Text('0812-7429-0160', style: linkStyle),
            ],
          ),
          const SizedBox(height: 4),
          Row(
            children: [
              Image.asset('assets/img/local_post_office.png', width: 16),
              const SizedBox(width: 8),
              const Text('mikirluk@mikirindonesia.com', style: linkStyle),
            ],
          ),
          const SizedBox(height: 32),
          const Center(
            child: Text(
              'Copyright @ 2024 Mikir Group - mikirluk.com . All Rights Reserverd',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 11,
                color: textColor,
                fontFamily: 'League Spartan',
              ),
            ),
          ),
        ],
      ),
    );
  }
}
