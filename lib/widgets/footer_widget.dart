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
    // [FIX] Mengambil warna dari tema yang sedang aktif
    final Color textColor = Theme.of(context).colorScheme.primary;
    final Color linkColor = Theme.of(context).textTheme.bodyLarge?.color ?? Colors.black;
    
    final TextStyle titleStyle = TextStyle(fontFamily: 'League Spartan', fontWeight: FontWeight.w700, fontSize: 15, color: textColor);
    final TextStyle linkStyle = TextStyle(fontFamily: 'League Spartan', fontWeight: FontWeight.w400, fontSize: 12, color: linkColor);

    return Container(
      padding: const EdgeInsets.all(20),
      // [FIX] Hapus warna manual agar background mengikuti tema Scaffold
      // color: Colors.white, 
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Site Map', style: titleStyle),
          const SizedBox(height: 8),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Berita', style: linkStyle),
                    const SizedBox(height: 4),
                    Text('Publishing', style: linkStyle),
                    const SizedBox(height: 4),
                    Text('Tentang Kami', style: linkStyle),
                  ],
                ),
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Karir', style: linkStyle),
                    const SizedBox(height: 4),
                    Text('Kontak', style: linkStyle),
                    const SizedBox(height: 4),
                    Text('Beriklan', style: linkStyle),
                  ],
                ),
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Pedoman Media', style: linkStyle),
                    Text('Siber', style: linkStyle),
                  ],
                ),
              ),
            ],
          ),
          const Divider(height: 24, color: Color(0xFF6380EA)),
          Center(child: Text('Ikuti Kami di', style: TextStyle(fontFamily: 'League Spartan', fontWeight: FontWeight.w700, fontSize: 16, color: textColor))),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              GestureDetector(
                onTap: () =>
                    _launchURL('https://www.facebook.com/share/19ThVsbqfG/'),
                child: Image.asset('assets/img/FACEBOOK ICON.png', width: 30),
              ),
              const SizedBox(width: 12),
              GestureDetector(
                onTap: () => _launchURL('https://wa.me/62895605091222'),
                child: Image.asset('assets/img/WA ICON.png', width: 30),
              ),
              const SizedBox(width: 12),
              GestureDetector(
                onTap: () => _launchURL('https://twitter.com/mikirluk/'),
                child: Image.asset('assets/img/X ICON.png', width: 30),
              ),
              const SizedBox(width: 12),
              GestureDetector(
                onTap: () => _launchURL('https://instagram.com/mikirluk/'),
                child: Image.asset('assets/img/IG ICON.png', width: 30),
              ),
            ],
          ),
          const Divider(height: 24, color: Color(0xFF6380EA)),
          Text('Informasi', style: titleStyle),
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
=======
          Row(children: [Image.asset('assets/img/local_phone.png', width: 16), const SizedBox(width: 8), Text('0812-7429-0160', style: linkStyle)]),
          const SizedBox(height: 4),
          Row(children: [Image.asset('assets/img/local_post_office.png', width: 16), const SizedBox(width: 8), Text('mikirluk@mikirindonesia.com', style: linkStyle)]),
          const SizedBox(height: 32),
          Center(child: Text('Copyright @ 2024 Mikir Group - mikirluk.com . All Rights Reserverd', textAlign: TextAlign.center, style: TextStyle(fontSize: 11, color: linkColor, fontFamily: 'League Spartan')));
  