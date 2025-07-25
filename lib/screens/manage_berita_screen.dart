import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';
import 'package:tugas_kelompok_dpm/models/berita_model.dart';
import 'package:tugas_kelompok_dpm/screens/form_berita_screen.dart';
import 'package:intl/intl.dart';

class ManageBeritaScreen extends StatefulWidget {
  const ManageBeritaScreen({super.key});

  @override
  State<ManageBeritaScreen> createState() => _ManageBeritaScreenState();
}

class _ManageBeritaScreenState extends State<ManageBeritaScreen> {
  final _searchController = TextEditingController();
  List<Berita> _listBerita = [];
  List<Berita> _filteredBerita = [];

  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadBerita();
    _searchController.addListener(_filterBerita);
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _filterBerita() {
    final query = _searchController.text.toLowerCase();
    setState(() {
      _filteredBerita = _listBerita.where((berita) {
        return berita.judul.toLowerCase().contains(query);
      }).toList();
    });
  }

  // --- [REVISI UTAMA] Logika untuk memuat berita dari DUA sumber ---
  Future<void> _loadBerita() async {
    if (!mounted) return;
    setState(() => _isLoading = true);

    try {
      // 1. Muat berita bawaan dari assets
      final String assetJsonString = await rootBundle.loadString(
        'assets/data/berita.json',
      );
      final List<dynamic> assetData = json.decode(assetJsonString);
      List<Berita> assetBerita = assetData
          .map((json) => Berita.fromJson(json))
          .toList();

      // 2. Muat berita buatan pengguna dari local storage
      final directory = await getApplicationDocumentsDirectory();
      final localFile = File('${directory.path}/berita.json');
      List<Berita> localBerita = [];
      if (await localFile.exists()) {
        final contents = await localFile.readAsString();
        if (contents.isNotEmpty) {
          final List<dynamic> localData = json.decode(contents);
          localBerita = localData.map((json) => Berita.fromJson(json)).toList();
        }
      }

      // 3. Gabungkan keduanya dan hilangkan duplikat (prioritaskan data lokal)
      final Map<String, Berita> combinedBeritaMap = {};
      // Masukkan berita aset dulu
      for (var berita in assetBerita) {
        combinedBeritaMap[berita.id] = berita;
      }
      // Timpa dengan berita lokal jika ada ID yang sama (hasil editan)
      for (var berita in localBerita) {
        combinedBeritaMap[berita.id] = berita;
      }

      // Jadikan list kembali dan urutkan berdasarkan tanggal terbaru
      _listBerita = combinedBeritaMap.values.toList();
      _listBerita.sort((a, b) => b.tanggal.compareTo(a.tanggal));

      _filteredBerita = List.from(_listBerita);
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('Gagal memuat berita: $e')));
      }
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
          _filterBerita();
        });
      }
    }
  }

  Future<void> _hapusBerita(String id) async {
    final konfirmasi = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Konfirmasi'),
        content: const Text('Apakah Anda yakin ingin menghapus berita ini?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('Batal'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, true),
            child: const Text('Hapus', style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );

    if (konfirmasi ?? false) {
      try {
        final appDir = await getApplicationDocumentsDirectory();
        final file = File('${appDir.path}/berita.json');

        // Baca berita lokal yang sudah ada
        List<Berita> localBerita = [];
        if (await file.exists()) {
          final contents = await file.readAsString();
          if (contents.isNotEmpty) {
            final List<dynamic> jsonData = json.decode(contents);
            localBerita = jsonData.map((e) => Berita.fromJson(e)).toList();
          }
        }

        // Hapus berita dari list lokal
        localBerita.removeWhere((b) => b.id == id);

        final List<Map<String, dynamic>> jsonList = localBerita
            .map((b) => b.toJson())
            .toList();
        await file.writeAsString(json.encode(jsonList));

        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Berita berhasil dihapus!'),
              backgroundColor: Colors.green,
            ),
          );
        }
        await _loadBerita(); // Muat ulang semua berita
      } catch (e) {
        if (mounted) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text('Gagal menghapus berita: $e')));
        }
      }
    }
  }

  void _navigasiKeFormTambah() async {
    final result = await Navigator.push<bool>(
      context,
      MaterialPageRoute(builder: (context) => const FormBeritaScreen()),
    );
    if (result == true) _loadBerita();
  }

  void _navigasiKeFormEdit(Berita berita) async {
    final result = await Navigator.push<bool>(
      context,
      MaterialPageRoute(builder: (context) => FormBeritaScreen(berita: berita)),
    );
    if (result == true) _loadBerita();
  }

  @override
  Widget build(BuildContext context) {
    final appBarTheme = Theme.of(context).appBarTheme;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF004AAD),
        foregroundColor: Colors.white,
        title: TextField(
          controller: _searchController,
          style: TextStyle(color: appBarTheme.foregroundColor),
          cursorColor: appBarTheme.foregroundColor,
          decoration: InputDecoration(
            hintText: 'Cari judul berita...',
            hintStyle: TextStyle(
              color: appBarTheme.foregroundColor?.withOpacity(0.7),
            ),
            border: InputBorder.none,
            suffixIcon: _searchController.text.isNotEmpty
                ? IconButton(
                    icon: Icon(Icons.clear, color: appBarTheme.foregroundColor),
                    onPressed: () => _searchController.clear(),
                  )
                : Icon(
                    Icons.search,
                    color: appBarTheme.foregroundColor?.withOpacity(0.7),
                  ),
          ),
        ),
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : _filteredBerita.isEmpty
          ? Center(
              child: Text(
                _searchController.text.isEmpty
                    ? 'Belum ada berita. Tekan + untuk menambah.'
                    : 'Berita tidak ditemukan.',
              ),
            )
          : ListView.builder(
              itemCount: _filteredBerita.length,
              itemBuilder: (context, index) {
                final berita = _filteredBerita[index];
                final tglFormatted = DateFormat(
                  'd MMMM yyyy',
                  'id_ID',
                ).format(berita.tanggal);

                Widget imageWidget;
                if (berita.gambar.startsWith('assets/')) {
                  imageWidget = Image.asset(
                    berita.gambar,
                    width: 80,
                    height: 80,
                    fit: BoxFit.cover,
                    errorBuilder: (c, e, s) => Container(
                      color: Colors.grey[200],
                      width: 80,
                      height: 80,
                      child: Icon(Icons.broken_image, color: Colors.grey[400]),
                    ),
                  );
                } else {
                  imageWidget = Image.file(
                    File(berita.gambar),
                    width: 80,
                    height: 80,
                    fit: BoxFit.cover,
                    errorBuilder: (c, e, s) => Container(
                      color: Colors.grey[200],
                      width: 80,
                      height: 80,
                      child: Icon(Icons.broken_image, color: Colors.grey[400]),
                    ),
                  );
                }

                return Card(
                  margin: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 8,
                  ),
                  child: ListTile(
                    leading: ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: imageWidget,
                    ),
                    title: Text(
                      berita.judul,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    subtitle: Text('${berita.editor} • $tglFormatted'),
                    trailing: PopupMenuButton<String>(
                      onSelected: (value) {
                        if (value == 'edit')
                          _navigasiKeFormEdit(berita);
                        else if (value == 'hapus')
                          _hapusBerita(berita.id);
                      },
                      itemBuilder: (context) => [
                        const PopupMenuItem(value: 'edit', child: Text('Edit')),
                        const PopupMenuItem(
                          value: 'hapus',
                          child: Text('Hapus'),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: _navigasiKeFormTambah,
        child: const Icon(Icons.add),
      ),
    );
  }
}
