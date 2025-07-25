import 'dart:io';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:tugas_kelompok_dpm/models/berita_model.dart';
import 'package:tugas_kelompok_dpm/widgets/footer_widget.dart';

class DetailBeritaScreen extends StatelessWidget {
  final Berita berita;

  const DetailBeritaScreen({super.key, required this.berita});

  // Widget helper untuk menampilkan gambar dari assets atau file lokal
  Widget _buildImage(String imagePath) {
    bool isAsset = imagePath.startsWith('assets/');

    ImageProvider imageProvider;
    if (isAsset) {
      imageProvider = AssetImage(imagePath);
    } else {
      // Pastikan file ada sebelum mencoba menampilkannya
      final file = File(imagePath);
      if (file.existsSync()) {
        imageProvider = FileImage(file);
      } else {
        // Fallback jika file tidak ditemukan
        return Container(
          height: 250,
          color: Colors.grey[300],
          child: const Center(
            child: Icon(Icons.broken_image, color: Colors.grey),
          ),
        );
      }
    }

    return Image(
      image: imageProvider,
      width: double.infinity,
      height: 250,
      fit: BoxFit.cover,
      errorBuilder: (context, error, stackTrace) {
        return Container(
          height: 250,
          color: Colors.grey[300],
          child: const Center(
            child: Icon(Icons.image_not_supported, color: Colors.grey),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    // Mengambil text style dan color scheme dari tema yang aktif
    final textTheme = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(
        // AppBar dibuat standar agar sesuai dengan halaman lain
        title: const Text("Detail Berita"),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // --- KONTEN UTAMA BERITA ---
            Padding(
              padding: const EdgeInsets.fromLTRB(16.0, 24.0, 16.0, 16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // 1. Kategori Berita
                  if (berita.tags.isNotEmpty)
                    Chip(
                      label: Text(berita.tags.first),
                      backgroundColor: colorScheme.primary.withOpacity(0.1),
                      labelStyle: TextStyle(
                        color: colorScheme.primary,
                        fontWeight: FontWeight.bold,
                      ),
                      side: BorderSide.none,
                    ),
                  const SizedBox(height: 12),

                  // 2. Judul Berita
                  Text(
                    berita.judul,
                    style: textTheme.headlineMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 16),

                  // 3. Gambar Berita
                  ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: _buildImage(berita.gambar),
                  ),
                  const SizedBox(height: 16),

                  // 4. Info Editor dan Tanggal
                  Row(
                    children: [
                      Text(
                        'Oleh: ${berita.editor}',
                        style: textTheme.bodySmall,
                      ),
                      const Spacer(),
                      Text(
                        DateFormat(
                          'd MMMM yyyy, HH:mm',
                          'id_ID',
                        ).format(berita.tanggal),
                        style: textTheme.bodySmall,
                      ),
                    ],
                  ),
                  const Divider(height: 32),

                  // 5. Isi Berita
                  Text(
                    berita.isi,
                    style: textTheme.bodyLarge?.copyWith(height: 1.6),
                  ),
                ],
              ),
            ),

            // --- FOOTER WIDGET ---
            const SizedBox(height: 24),
            const Divider(height: 1),
            const FooterWidget(),
          ],
        ),
      ),
    );
  }
}
