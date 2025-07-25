import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';
import 'package:tugas_kelompok_dpm/models/berita_model.dart';
import 'package:tugas_kelompok_dpm/screens/app_drawer.dart';
import 'package:tugas_kelompok_dpm/screens/detail_berita_screen.dart';
import 'package:tugas_kelompok_dpm/screens/form_berita_screen.dart';
import 'package:tugas_kelompok_dpm/screens/search_screen.dart';
import 'package:tugas_kelompok_dpm/widgets/footer_widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Berita> _allBerita = [];
  List<Berita> _filteredBerita = [];
  bool _isLoading = true;

  final List<String> _categories = [
    'Beranda',
    'Olahraga',
    'Politik',
    'Hiburan',
    'Gaya Hidup',
    'Teknologi',
  ];
  String _selectedCategory = 'Beranda';

  @override
  void initState() {
    super.initState();
    _refreshData();
  }

  Future<void> _loadAndFilterBerita() async {
    try {
      // Memuat berita dari asset JSON
      final String assetJsonString = await rootBundle.loadString(
        'assets/data/berita.json',
      );
      final List<dynamic> assetData = json.decode(assetJsonString);
      List<Berita> assetBerita = assetData
          .map((json) => Berita.fromJson(json))
          .toList();

      // Memuat berita dari file lokal (jika ada)
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

      // Menggabungkan, menghilangkan duplikat, dan mengurutkan berita
      _allBerita = [...localBerita, ...assetBerita];

      final ids = <String>{};
      _allBerita.retainWhere((berita) => ids.add(berita.id));

      _allBerita.sort((a, b) => b.tanggal.compareTo(a.tanggal));

      _filterBerita();
    } catch (e) {
      print("Error loading combined news: $e");
      if (mounted) {
        setState(() {
          _allBerita = [];
          _filteredBerita = [];
        });
      }
    }
  }

  void _filterBerita() {
    List<Berita> newFilteredList;
    if (_selectedCategory == 'Beranda') {
      newFilteredList = List<Berita>.from(_allBerita);
    } else {
      newFilteredList = _allBerita.where((berita) {
        return berita.tags.any(
          (tag) => tag.toLowerCase() == _selectedCategory.toLowerCase(),
        );
      }).toList();
    }

    if (mounted) {
      setState(() {
        _filteredBerita = newFilteredList;
      });
    }
  }

  Future<void> _refreshData() async {
    if (mounted) setState(() => _isLoading = true);
    await _loadAndFilterBerita();
    if (mounted) setState(() => _isLoading = false);
  }

  void _onCategorySelected(String category) {
    setState(() {
      _selectedCategory = category;
      _filterBerita();
    });
  }

  String waktuRelative(DateTime date) {
    final duration = DateTime.now().difference(date);
    if (duration.inMinutes < 60) return '${duration.inMinutes} menit lalu';
    if (duration.inHours < 24) return '${duration.inHours} jam lalu';
    return DateFormat('dd/MM/yyyy', 'id_ID').format(date);
  }

  void _navigateToDetail(Berita berita) async {
    await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => DetailBeritaScreen(berita: berita),
      ),
    );
  }

  void _navigateToForm() async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const FormBeritaScreen()),
    );
    if (result == true && mounted) {
      _refreshData();
    }
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

  Widget _buildNationalInternationalTabs() {
    const activeColor = Color(0xFF224699);
    const inactiveColor = Color.fromARGB(255, 60, 45, 45);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      child: Row(
        children: [
          Expanded(
            child: ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFF2F2FF),
                foregroundColor: activeColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5),
                  side: const BorderSide(color: activeColor, width: 2),
                ),
                padding: const EdgeInsets.symmetric(vertical: 4),
              ),
              child: const Text(
                'National',
                style: TextStyle(
                  fontFamily: 'League Spartan',
                  fontWeight: FontWeight.w700,
                  fontSize: 16,
                ),
              ),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: inactiveColor,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5),
                ),
                padding: const EdgeInsets.symmetric(vertical: 4),
              ),
              child: const Text(
                'International',
                style: TextStyle(
                  fontFamily: 'League Spartan',
                  fontWeight: FontWeight.w600,
                  fontSize: 16,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCategoryTabs() {
    return SizedBox(
      height: 45,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: _categories.length,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        itemBuilder: (context, index) {
          final category = _categories[index];
          final isSelected = category == _selectedCategory;
          return GestureDetector(
            onTap: () => _onCategorySelected(category),
            child: Container(
              width: 100,
              margin: const EdgeInsets.symmetric(horizontal: 4),
              decoration: BoxDecoration(
                color: isSelected
                    ? const Color(0xFFF2F2FF)
                    : Colors.transparent,
                borderRadius: BorderRadius.circular(5),
              ),
              child: Center(
                child: Text(
                  category,
                  style: TextStyle(
                    color: const Color(0xFF224699),
                    fontSize: 12,
                    fontFamily: 'League Spartan',
                    fontWeight: isSelected ? FontWeight.w700 : FontWeight.w500,
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildHeroCard(Berita berita) {
    return GestureDetector(
      key: ObjectKey(berita),
      onTap: () => _navigateToDetail(berita),
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(5),
          border: Border.all(color: const Color(0xFFAAB7D3)),
          boxShadow: const [
            BoxShadow(
              color: Color(0x3F000000),
              blurRadius: 4,
              offset: Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: const BorderRadius.vertical(
                top: Radius.circular(5),
              ),
              child: _buildImage(
                berita.gambar,
                height: 164,
                width: double.infinity,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    berita.judul,
                    style: const TextStyle(
                      color: Color(0xFF224699),
                      fontSize: 20,
                      fontFamily: 'Bree Serif',
                      fontWeight: FontWeight.w400,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 12),
                  Text(
                    DateFormat('dd/MM/yy', 'id_ID').format(berita.tanggal),
                    style: const TextStyle(
                      color: Color(0xFF224699),
                      fontSize: 15,
                      fontFamily: 'Alumni Sans',
                    ),
                  ),
                  const SizedBox(height: 4),
                  const Divider(color: Color(0xFF224699)),
                  const SizedBox(height: 4),
                  Text(
                    berita.isi,
                    style: const TextStyle(
                      color: Color(0xFF224699),
                      fontSize: 12,
                      fontFamily: 'AR One Sans',
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.justify,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAdvertising() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 28, vertical: 20),
      padding: const EdgeInsets.all(6),
      decoration: BoxDecoration(
        color: Colors.white,
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

  Widget _buildBeritaTerkiniSection(List<Berita> beritaList) {
    if (beritaList.isEmpty) return const SizedBox.shrink();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.fromLTRB(20, 20, 20, 10),
          child: Text(
            'Berita Terkini',
            style: TextStyle(
              color: Colors.black,
              fontSize: 20,
              fontFamily: 'League Spartan',
              fontWeight: FontWeight.w400,
            ),
          ),
        ),
        SizedBox(
          height: 220,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: beritaList.length,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            itemBuilder: (context, index) =>
                _buildFeaturedTerkiniItem(beritaList[index]),
          ),
        ),
      ],
    );
  }

  Widget _buildFeaturedTerkiniItem(Berita berita) {
    return GestureDetector(
      key: ObjectKey(berita),
      onTap: () => _navigateToDetail(berita),
      child: Container(
        width: 160,
        margin: const EdgeInsets.symmetric(horizontal: 4),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(5),
              child: _buildImage(
                berita.gambar,
                height: 110,
                width: double.infinity,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              berita.judul,
              style: const TextStyle(
                color: Colors.black,
                fontSize: 12,
                fontFamily: 'Bree Serif',
              ),
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(height: 4),
            Text(
              waktuRelative(berita.tanggal),
              style: TextStyle(
                color: Colors.black.withOpacity(0.34),
                fontSize: 12,
                fontFamily: 'Bree Serif',
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBeritaLainnyaItem(Berita berita) {
    return GestureDetector(
      key: ObjectKey(berita),
      onTap: () => _navigateToDetail(berita),
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
                          style: const TextStyle(
                            color: Colors.black,
                            fontSize: 12,
                            fontFamily: 'Bree Serif',
                          ),
                          maxLines: 4,
                          overflow: TextOverflow.ellipsis,
                        ),
                        Text(
                          waktuRelative(berita.tanggal),
                          style: TextStyle(
                            color: Colors.black.withOpacity(0.34),
                            fontSize: 12,
                            fontFamily: 'Bree Serif',
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

  @override
  Widget build(BuildContext context) {
    final totalBerita = _filteredBerita.length;
    Berita? heroBerita = totalBerita > 0 ? _filteredBerita[0] : null;

    const int horizontalListSize = 5;
    const int verticalListSize = 3;

    const int horizontalStartIndex = 1;
    final int verticalStartIndex = horizontalStartIndex + horizontalListSize;

    List<Berita> beritaTerkini = [];
    if (totalBerita > horizontalStartIndex) {
      int endIndex = horizontalStartIndex + horizontalListSize;
      if (endIndex > totalBerita) {
        endIndex = totalBerita;
      }
      beritaTerkini = _filteredBerita.sublist(horizontalStartIndex, endIndex);
    }

    List<Berita> beritaLainnya = [];
    if (totalBerita > verticalStartIndex) {
      int endIndex = verticalStartIndex + verticalListSize;
      if (endIndex > totalBerita) {
        endIndex = totalBerita;
      }
      beritaLainnya = _filteredBerita.sublist(verticalStartIndex, endIndex);
    }

    return Scaffold(
      drawer: const AppMenuDrawer(),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: Builder(
          builder: (context) => IconButton(
            icon: Image.asset('assets/img/3_bar.png', width: 30),
            onPressed: () => Scaffold.of(context).openDrawer(),
          ),
        ),
        title: Image.asset('assets/img/Logo-mikirluk.png', height: 48),
        centerTitle: true,
        actions: [
          IconButton(
            icon: Image.asset('assets/img/search.png', width: 30),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const SearchScreen()),
              );
            },
          ),
        ],
      ),
      backgroundColor: Colors.white,
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : RefreshIndicator(
              onRefresh: _refreshData,
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildNationalInternationalTabs(),
                    _buildCategoryTabs(),

                    if (heroBerita != null) _buildHeroCard(heroBerita),
                    _buildAdvertising(),

                    if (beritaTerkini.isNotEmpty)
                      _buildBeritaTerkiniSection(beritaTerkini),

                    if (beritaLainnya.isNotEmpty)
                      ListView.builder(
                        itemCount: beritaLainnya.length,
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemBuilder: (context, index) =>
                            _buildBeritaLainnyaItem(beritaLainnya[index]),
                      ),

                    if (_filteredBerita.isEmpty && !_isLoading)
                      Container(
                        height: 200,
                        alignment: Alignment.center,
                        child: Text(
                          'Tidak ada berita di kategori "$_selectedCategory".',
                        ),
                      ),

                    // PENAMBAHAN FOOTER WIDGET
                    const FooterWidget(),
                  ],
                ),
              ),
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: _navigateToForm,
        backgroundColor: const Color(0xFF224699),
        child: const Icon(Icons.add, color: Colors.white),
      ),
    );
  }
}
