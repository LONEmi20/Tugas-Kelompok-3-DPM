import 'dart:io';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:tugas_kelompok_dpm/models/berita_model.dart';

class DetailBeritaScreen extends StatelessWidget {
  final Berita berita;

  const DetailBeritaScreen({super.key, required this.berita});

  Widget _buildImage(String imagePath) {
    bool isAsset = imagePath.startsWith('assets/');
    
    ImageProvider imageProvider;
    if (isAsset) {
      imageProvider = AssetImage(imagePath);
    } else {
      imageProvider = FileImage(File(imagePath));
    }

    return Image(
      image: imageProvider,
      width: double.infinity,
      height: 250,
      fit: BoxFit.cover, 
      errorBuilder: (context, error, stackTrace) {
        print("Error loading image: $error"); 
        return Container(
          height: 250,
          color: Colors.grey[300],
          child: const Center(child: Icon(Icons.image_not_supported, color: Colors.grey)),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    // [FIX] Mengambil text style dari tema
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Detail Berita"),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildImage(berita.gambar), 
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    berita.judul,
                    // [FIX] Menggunakan style dari tema
                    style: textTheme.headlineLarge,
                  ),
                  const SizedBox(height: 12),
                  Row(
                    children: [
                      const Icon(Icons.person, size: 16, color: Colors.grey),
                      const SizedBox(width: 4),
                      Text(
                        'Editor: ${berita.editor}', 
                        // [FIX] Menggunakan style dari tema
                        style: textTheme.bodySmall?.copyWith(fontStyle: FontStyle.italic)
                      ),
                      const SizedBox(width: 16),
                      const Icon(Icons.calendar_today, size: 16, color: Colors.grey),
                      const SizedBox(width: 4),
                      Text(
                        DateFormat('d MMM yyyy', 'id_ID').format(berita.tanggal),
                        // [FIX] Menggunakan style dari tema
                        style: textTheme.bodySmall?.copyWith(fontStyle: FontStyle.italic),
                      ),
                    ],
                  ),
                  const Divider(height: 32),
                  Text(
                    berita.isi,
                    // [FIX] Menggunakan style dari tema
                    style: textTheme.bodyLarge,
                  ),
                  const SizedBox(height: 16),
                  Wrap(
                    spacing: 8.0,
                    runSpacing: 4.0,
                    children: berita.tags.map((tag) => Chip(label: Text(tag))).toList(),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
