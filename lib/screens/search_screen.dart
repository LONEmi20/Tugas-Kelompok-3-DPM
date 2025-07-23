import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tugas_kelompok_dpm/models/berita_model.dart';
import 'package:tugas_kelompok_dpm/screens/detail_berita_screen.dart';

class SearchScreen extends StatefulWidget {
  final String? categoryName;

  const SearchScreen({super.key, this.categoryName});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController _searchController = TextEditingController();
  final FocusNode _focusNode = FocusNode();

  List<Berita> _allBerita = [];
  List<Berita> _searchResults = [];
  List<String> _searchHistory = [];

  final Map<String, List<String>> _categoryRecommendations = {
    'Olahraga': ['Timnas', 'Bulu Tangkis', 'Piala Asia', 'Vitality', 'EWC'],
    'Politik': ['Pemilu', 'IKN', 'DPR', 'UU', 'Pemerintah'],
    'Hiburan': ['Film', 'Konser', 'Webtoon', 'Stand-up', 'Musik'],
    'Gaya Hidup': ['Kuliner', 'Fashion', 'Thrifting', 'Glamping', 'Slow Living'],
    'Teknologi': ['AI', 'Gadget', 'Startup', 'IoT', 'Metaverse'],
  };
  final List<String> _globalRecommendations = ['Timnas', 'Piala Asia', 'Pemilu', 'Teknologi', 'IKN'];
  
  late List<String> _currentRecommendations;

  bool _isLoading = true;
  bool _isSearching = false;
  bool _searchInitiated = false;

  String get _historyKey => widget.categoryName != null
      ? 'search_history_${widget.categoryName}'
      : 'search_history_global';

  @override
  void initState() {
    super.initState();
    _currentRecommendations = widget.categoryName != null
        ? _categoryRecommendations[widget.categoryName!] ?? _globalRecommendations
        : _globalRecommendations;
    _loadInitialData();
  }

  @override
  void dispose() {
    _searchController.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  Future<void> _loadInitialData() async {
    await _loadAllBerita();
    await _loadSearchHistory();
    if (mounted) {
      setState(() {
        _isLoading = false;
      });
    }
  }

  Future<void> _loadAllBerita() async {
    try {
      final String assetJsonString = await rootBundle.loadString('assets/data/berita.json');
      final List<dynamic> assetData = json.decode(assetJsonString);
      List<Berita> assetBerita = assetData.map((json) => Berita.fromJson(json)).toList();

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

      var combinedBerita = [...localBerita, ...assetBerita];
      final ids = <String>{};
      combinedBerita.retainWhere((berita) => ids.add(berita.id));
      combinedBerita.sort((a, b) => b.tanggal.compareTo(a.tanggal));

      // --- PERUBAHAN: Filter berita jika ada kategori yang dikirim ---
      if (widget.categoryName != null) {
        _allBerita = combinedBerita.where((berita) {
          return berita.tags.any((tag) => tag.toLowerCase() == widget.categoryName!.toLowerCase());
        }).toList();
      } else {
        _allBerita = combinedBerita;
      }

    } catch (e) {
      print("Error loading news for search: $e");
      _allBerita = [];
    }
  }

  Future<void> _loadSearchHistory() async {
    final prefs = await SharedPreferences.getInstance();
    if (mounted) {
      setState(() {
        _searchHistory = prefs.getStringList(_historyKey) ?? [];
      });
    }
  }

  Future<void> _saveSearchHistory() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setStringList(_historyKey, _searchHistory);
  }

  void _performSearch(String query) {
    _focusNode.unfocus();
    query = query.trim();
    if (query.isEmpty) return;

    setState(() {
      _isSearching = true;
      _searchInitiated = true;
    });

    if (!_searchHistory.contains(query)) {
        _searchHistory.insert(0, query);
        if (_searchHistory.length > 4) {
          _searchHistory = _searchHistory.sublist(0, 4);
        }
        _saveSearchHistory();
    }

    final results = _allBerita.where((berita) {
      final titleMatch = berita.judul.toLowerCase().contains(query.toLowerCase());
      final contentMatch = berita.isi.toLowerCase().contains(query.toLowerCase());
      return titleMatch || contentMatch;
    }).toList();

    setState(() {
      _searchResults = results;
      _isSearching = false;
    });
  }
  
  void _clearSearch() {
    _searchController.clear();
    setState(() {
      _searchInitiated = false;
      _searchResults = [];
    });
  }

  Future<void> _showDeleteConfirmation(String term) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Hapus Riwayat'),
          content: Text('Anda yakin ingin menghapus "$term" dari riwayat pencarian?'),
          actions: <Widget>[
            TextButton(
              child: const Text('Batal'),
              onPressed: () => Navigator.of(context).pop(),
            ),
            TextButton(
              child: const Text('Hapus'),
              onPressed: () {
                setState(() {
                  _searchHistory.remove(term);
                  _saveSearchHistory();
                });
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: _buildSearchBar(),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 1,
        // Tombol back
      ),
      backgroundColor: Colors.white,
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : _searchInitiated
              ? _buildSearchResults()
              : _buildSuggestionsAndHistory(),
    );
  }

  Widget _buildSearchBar() {
    return SizedBox(
      height: 40,
      child: TextField(
        controller: _searchController,
        focusNode: _focusNode,
        autofocus: true,
        decoration: InputDecoration(
          hintText: widget.categoryName != null 
              ? 'Cari di ${widget.categoryName}...' 
              : 'Cari berita...',
          contentPadding: const EdgeInsets.symmetric(horizontal: 16),
          filled: true,
          fillColor: Colors.grey[200],
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20.0),
            borderSide: BorderSide.none,
          ),
          suffixIcon: _searchController.text.isNotEmpty
              ? IconButton(
                  icon: const Icon(Icons.clear, size: 20),
                  onPressed: _clearSearch,
                )
              : null,
        ),
        onSubmitted: _performSearch,
      ),
    );
  }

  Widget _buildSuggestionsAndHistory() {
    List<String> suggestions = List.from(_searchHistory);
    for (var rec in _currentRecommendations) {
      if (!suggestions.contains(rec)) {
        suggestions.add(rec);
      }
    }
    final displayList = suggestions.take(5).toList();

    return ListView.builder(
      itemCount: displayList.length,
      itemBuilder: (context, index) {
        final term = displayList[index];
        final isHistory = _searchHistory.contains(term);

        return ListTile(
          leading: Icon(isHistory ? Icons.history : Icons.search),
          title: Text(term),
          onTap: () {
            _searchController.text = term;
            _performSearch(term);
          },
          trailing: isHistory
              ? IconButton(
                  icon: const Icon(Icons.delete_outline, color: Colors.grey),
                  onPressed: () => _showDeleteConfirmation(term),
                )
              : null,
        );
      },
    );
  }

  Widget _buildSearchResults() {
    if (_isSearching) {
      return const Center(child: CircularProgressIndicator());
    }

    if (_searchResults.isEmpty) {
      return const Center(
        child: Text('Berita tidak ditemukan.'),
      );
    }

    return ListView.builder(
      itemCount: _searchResults.length,
      itemBuilder: (context, index) {
        return _buildBeritaItem(_searchResults[index]);
      },
    );
  }

  Widget _buildBeritaItem(Berita berita) {
    return GestureDetector(
      key: ObjectKey(berita),
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) => DetailBeritaScreen(berita: berita)));
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 8.0),
        child: Row(
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
                      style: const TextStyle(color: Colors.black, fontSize: 14, fontFamily: 'Bree Serif', fontWeight: FontWeight.bold),
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                    ),
                    Text(
                      DateFormat('d MMM yyyy', 'id_ID').format(berita.tanggal),
                      style: TextStyle(color: Colors.black.withOpacity(0.5), fontSize: 12, fontFamily: 'Bree Serif'),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildImage(String imagePath, {required double height, required double width}) {
    bool isAsset = imagePath.startsWith('assets/');
    if (isAsset) {
      return Image.asset(imagePath, height: height, width: width, fit: BoxFit.cover,
        errorBuilder: (c, e, s) => Container(height: height, width: width, color: Colors.grey[200], child: const Icon(Icons.broken_image)));
    } else {
      return Image.file(File(imagePath), height: height, width: width, fit: BoxFit.cover,
        errorBuilder: (c, e, s) => Container(height: height, width: width, color: Colors.grey[200], child: const Icon(Icons.broken_image)));
    }
  }
}
