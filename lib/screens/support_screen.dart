import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class SupportScreen extends StatelessWidget {
  const SupportScreen({super.key});

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
    return Scaffold(
      appBar: AppBar(
        title: const Text('Support Admin'),
        backgroundColor: const Color(0xFF004AAD),
        foregroundColor: Colors.white,
      ),

      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          _buildSupportCard(
            context,
            name: 'Spring',
            message: 'Mohon bantuannya kawan',
            imageUrl: 'assets/img/profile_evan.jpg',
            saweriaUrl: 'https://saweria.co/Spring',
          ),
          const SizedBox(height: 20),
          _buildSupportCard(
            context,
            name: 'LONEmi',
            message: 'Mohon bantuannya kawan',
            imageUrl: 'assets/img/profile_mic.jpg',
            saweriaUrl: 'https://saweria.co/LONEmi',
          ),
          const SizedBox(height: 20),
          _buildSupportCard(
            context,
            name: 'fofochn',
            message: 'Mohon bantuannya kawan',
            imageUrl: 'assets/img/profile_fofo.jpg',
            saweriaUrl: 'https://saweria.co/fofochn',
          ),
        ],
      ),
    );
  }

  Widget _buildSupportCard(
    BuildContext context, {
    required String name,
    required String message,
    required String imageUrl,
    required String saweriaUrl,
  }) {
    final cardColor = Theme.of(context).cardColor;
    final textColor =
        Theme.of(context).textTheme.bodyLarge?.color ?? Colors.black;
    final buttonTextColor = Theme.of(context).brightness == Brightness.dark
        ? Colors.white
        : Colors.black;
    final buttonBackgroundColor = Theme.of(context).colorScheme.surface;

    return Card(
      elevation: 4,
      shadowColor: Colors.black.withOpacity(0.25),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(5),
        side: BorderSide(width: 1, color: textColor.withOpacity(0.5)),
      ),
      color: cardColor,
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Row(
          children: [
            CircleAvatar(
              radius: 55,
              backgroundImage: AssetImage(imageUrl),
              onBackgroundImageError: (e, s) =>
                  const Icon(Icons.person, size: 55),
            ),
            const SizedBox(width: 15),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    name,
                    style: TextStyle(
                      color: textColor,
                      fontSize: 24,
                      fontFamily: 'League Spartan',
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    message,
                    style: TextStyle(
                      color: textColor,
                      fontSize: 14,
                      fontFamily: 'League Spartan',
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 15),
                  ElevatedButton(
                    onPressed: () => _launchURL(saweriaUrl),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: buttonBackgroundColor,
                      foregroundColor: buttonTextColor,
                      minimumSize: const Size(176, 44),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5),
                        side: const BorderSide(width: 1, color: Colors.black),
                      ),
                      elevation: 4,
                    ),
                    child: const Text(
                      'Saweria',
                      style: TextStyle(
                        fontSize: 24,
                        fontFamily: 'League Spartan',
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
