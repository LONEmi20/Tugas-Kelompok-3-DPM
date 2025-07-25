import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';
import 'package:tugas_kelompok_dpm/models/berita_model.dart';
import 'package:tugas_kelompok_dpm/screens/detail_berita_screen.dart';
import 'package:tugas_kelompok_dpm/screens/search_screen.dart';
import 'package:tugas_kelompok_dpm/widgets/footer_widget.dart';

class CategoryScreen extends StatefulWidget {
  final String categoryName;

  const CategoryScreen({super.key, required this.categoryName});

  @override
  State<CategoryScreen> createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  bool _isLoading = true;
  List<Berita> _allBerita = [];
  List<Berita> _categoryBerita = [];
  int _currentPage = 0;
  final int _itemsPerPage = 10;

  @override
  void initState() {
    super.initState();
    _loadBerita();
  }

  Future<void> _loadBerita() async {
    if (!mounted) return;
    setState(() => _isLoading = true);

    try {
      final String assetJsonString = await rootBundle.loadString(
        'assets/data/berita.json',
      );
      final List<dynamic> assetData = json.decode(assetJsonString);
      List<Berita> assetBerita = assetData
          .map((json) => Berita.fromJson(json))
          .toList();

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

      _allBerita = [...localBerita, ...assetBerita];
      final ids = <String>{};
      _allBerita.retainWhere((berita) => ids.add(berita.id));
      _allBerita.sort((a, b) => b.tanggal.compareTo(a.tanggal));

      _categoryBerita = _allBerita.where((berita) {
        return berita.tags.any(
          (tag) => tag.toLowerCase() == widget.categoryName.toLowerCase(),
        );
      }).toList();
    } catch (e) {
      print("Error loading category news: $e");
      _categoryBerita = [];
    }

    if (mounted) setState(() => _isLoading = false);
  }

  void _nextPage() {
    int totalPages = (_categoryBerita.length / _itemsPerPage).ceil();
    if (_currentPage < totalPages - 1) {
      setState(() {
        _currentPage++;
      });
    }
  }

  void _previousPage() {
    if (_currentPage > 0) {
      setState(() {
        _currentPage--;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final int startIndex = _currentPage * _itemsPerPage;
    final int endIndex = (startIndex + _itemsPerPage > _categoryBerita.length)
        ? _categoryBerita.length
        : (startIndex + _itemsPerPage);
    final List<Berita> pagedBerita = _categoryBerita.isNotEmpty
        ? _categoryBerita.sublist(startIndex, endIndex)
        : [];
    final int totalPages = _categoryBerita.isEmpty
        ? 1
        : (_categoryBerita.length / _itemsPerPage).ceil();

    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    final logoAsset = isDarkMode
        ? 'assets/img/logo_white.png'
        : 'assets/img/Logo-mikirluk.png';

    return Scaffold(
      appBar: AppBar(
        title: Image.asset(logoAsset, height: 40),
        centerTitle: true,
        actions: [
          IconButton(
            icon: Image.asset('assets/img/search.png', width: 30),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) =>
                      SearchScreen(categoryName: widget.categoryName),
                ),
              );
            },
          ),
        ],
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : _categoryBerita.isEmpty
          ? Center(
              child: Text(
                'Tidak ada berita di kategori "${widget.categoryName}".',
              ),
            )
          : SingleChildScrollView(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Text(
                      widget.categoryName,
                      style: Theme.of(context).textTheme.headlineLarge
                          ?.copyWith(fontFamily: 'Bree Serif'),
                    ),
                  ),
                  ListView.builder(
                    itemCount: pagedBerita.length,
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) {
                      final beritaItem = pagedBerita[index];
                      if (index == 4 && _currentPage == 0) {
                        return Column(
                          children: [
                            _buildBeritaLainnyaItem(beritaItem),
                            _buildAdvertising(),
                          ],
                        );
                      }
                      return _buildBeritaLainnyaItem(beritaItem);
                    },
                  ),
                  if (_categoryBerita.length > _itemsPerPage)
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 24.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          ElevatedButton(
                            onPressed: _currentPage == 0 ? null : _previousPage,
                            child: const Text('<< Prev'),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 16.0,
                            ),
                            child: Text(
                              'Hal ${_currentPage + 1} / $totalPages',
                            ),
                          ),
                          ElevatedButton(
                            onPressed: _currentPage >= totalPages - 1
                                ? null
                                : _nextPage,
                            child: const Text('Next >>'),
                          ),
                        ],
                      ),
                    ),
                  const FooterWidget(),
                ],
              ),
            ),
    );
  }

  String waktuRelative(DateTime date) {
    final duration = DateTime.now().difference(date);
    if (duration.inMinutes < 60) return '${duration.inMinutes} menit lalu';
    if (duration.inHours < 24) return '${duration.inHours} jam lalu';
    return DateFormat('dd/MM/yyyy', 'id_ID').format(date);
  }

  Widget _buildImage(
    String imagePath, {
    required double height,
    required double width,
  }) {
    bool isAsset = imagePath.startsWith('assets/');
    if (isAsset) {
      return Image.asset(
        imagePath,
        height: height,
        width: width,
        fit: BoxFit.cover,
        errorBuilder: (c, e, s) => Container(
          height: height,
          width: width,
          color: Colors.grey[200],
          child: const Icon(Icons.broken_image),
        ),
      );
    } else {
      return Image.file(
        File(imagePath),
        height: height,
        width: width,
        fit: BoxFit.cover,
        errorBuilder: (c, e, s) => Container(
          height: height,
          width: width,
          color: Colors.grey[200],
          child: const Icon(Icons.broken_image),
        ),
      );
    }
  }

  Widget _buildAdvertising() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 28, vertical: 20),
      padding: const EdgeInsets.all(6),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: const Color(0xFF224699)),
        boxShadow: const [
          BoxShadow(
            color: Color(0x3F000000),
            blurRadius: 4,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Stack(
        alignment: Alignment.topCenter,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(5),
            child: Image.asset(
              'assets/img/iklan1.png',
              errorBuilder: (c, e, s) => Container(
                height: 105,
                color: Colors.grey[200],
                child: const Center(child: Text("Iklan")),
              ),
            ),
          ),
          const Text(
            'Advertising',
            style: TextStyle(
              color: Color(0xFF224699),
              fontSize: 10,
              fontFamily: 'League Spartan',
              fontWeight: FontWeight.w300,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBeritaLainnyaItem(Berita berita) {
    final textTheme = Theme.of(context).textTheme;

    return GestureDetector(
      key: ObjectKey(berita),
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => DetailBeritaScreen(berita: berita),
          ),
        );
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Column(
          children: [
            const SizedBox(height: 16),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(5),
                  child: _buildImage(berita.gambar, width: 100, height: 100),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: SizedBox(
                    height: 100,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          berita.judul,
                          style: textTheme.titleMedium,
                          maxLines: 4,
                          overflow: TextOverflow.ellipsis,
                        ),
                        Text(
                          waktuRelative(berita.tanggal),
                          style: textTheme.bodySmall?.copyWith(
                            color: textTheme.bodySmall?.color?.withOpacity(
                              0.34,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            const Divider(color: Color(0xFF6380EA), height: 1, thickness: 1),
          ],
        ),
      ),
    );
  }
}
