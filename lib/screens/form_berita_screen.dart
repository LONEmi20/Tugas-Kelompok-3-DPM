import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart';
import 'package:tugas_kelompok_dpm/models/berita_model.dart';

class FormBeritaScreen extends StatefulWidget {
<<<<<<< HEAD
  // Tambahkan parameter opsional untuk menampung berita yang akan diedit
=======
  // Parameter opsional untuk menampung berita yang akan diedit
>>>>>>> 8da38e30eaff57305e73c3c4ba10cfd1578d8129
  final Berita? berita;

  const FormBeritaScreen({super.key, this.berita});

  @override
  State<FormBeritaScreen> createState() => _FormBeritaScreenState();
}

class _FormBeritaScreenState extends State<FormBeritaScreen> {
  final _formKey = GlobalKey<FormState>();
  final _judulController = TextEditingController();
  final _editorController = TextEditingController();
  final _isiController = TextEditingController();

  File? _selectedImage;
  bool _isLoading = false;
  bool get _isEditing => widget.berita != null; // Cek apakah ini mode edit

  final List<String> _kategoriList = [
    'Olahraga',
    'Politik',
    'Hiburan',
    'Gaya Hidup',
    'Teknologi',
  ];
  String? _selectedKategori;

  @override
  void initState() {
    super.initState();
    // Jika ini mode edit, isi semua form dengan data yang ada
    if (_isEditing) {
      final berita = widget.berita!;
      _judulController.text = berita.judul;
      _editorController.text = berita.editor;
      _isiController.text = berita.isi;
      _selectedKategori = berita.tags.isNotEmpty ? berita.tags.first : null;
<<<<<<< HEAD
      // Cek apakah gambar dari aset atau file
=======
>>>>>>> 8da38e30eaff57305e73c3c4ba10cfd1578d8129
      if (!berita.gambar.startsWith('assets/')) {
        _selectedImage = File(berita.gambar);
      }
    }
  }

  @override
  void dispose() {
    _judulController.dispose();
    _editorController.dispose();
    _isiController.dispose();
    super.dispose();
  }

  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() => _selectedImage = File(pickedFile.path));
    }
  }

<<<<<<< HEAD
  // --- FUNGSI SIMPAN BERITA (Bisa untuk tambah & edit) ---
  Future<void> _simpanBerita() async {
    if (_formKey.currentState!.validate()) {
      // Pada mode tambah, gambar & kategori wajib. Pada mode edit, gambar boleh kosong (pakai yg lama)
      if ((!_isEditing && _selectedImage == null) ||
          _selectedKategori == null) {
=======
  Future<void> _simpanBerita() async {
    if (_formKey.currentState!.validate()) {
      if ((!_isEditing && _selectedImage == null) || _selectedKategori == null) {
>>>>>>> 8da38e30eaff57305e73c3c4ba10cfd1578d8129
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Gambar dan Kategori wajib diisi.'),
            backgroundColor: Colors.orange,
          ),
        );
        return;
      }

      setState(() => _isLoading = true);

      try {
        final appDir = await getApplicationDocumentsDirectory();
<<<<<<< HEAD

        String imagePath = '';
        if (_selectedImage != null) {
          // Simpan gambar baru jika ada gambar yang dipilih
          final fileName = path.basename(_selectedImage!.path);
          final savedImage = await _selectedImage!.copy(
            '${appDir.path}/$fileName',
          );
          imagePath = savedImage.path;
        } else if (_isEditing) {
          // Jika mode edit dan tidak ada gambar baru, pakai path gambar lama
=======
        String imagePath = '';
        if (_selectedImage != null) {
          final fileName = path.basename(_selectedImage!.path);
          final savedImage = await _selectedImage!.copy('${appDir.path}/$fileName');
          imagePath = savedImage.path;
        } else if (_isEditing) {
>>>>>>> 8da38e30eaff57305e73c3c4ba10cfd1578d8129
          imagePath = widget.berita!.gambar;
        }

        final file = File('${appDir.path}/berita.json');
        List<Berita> listBerita = [];
        if (await file.exists()) {
          final contents = await file.readAsString();
          if (contents.isNotEmpty) {
            final List<dynamic> jsonData = json.decode(contents);
            listBerita = jsonData.map((e) => Berita.fromJson(e)).toList();
          }
        }

        if (_isEditing) {
<<<<<<< HEAD
          // --- LOGIKA UNTUK EDIT BERITA ---
=======
>>>>>>> 8da38e30eaff57305e73c3c4ba10cfd1578d8129
          final beritaDiedit = Berita(
            id: widget.berita!.id,
            judul: _judulController.text,
            editor: _editorController.text,
<<<<<<< HEAD
            tanggal: DateTime.now(), // Update tanggal ke waktu sekarang
=======
            tanggal: DateTime.now(),
>>>>>>> 8da38e30eaff57305e73c3c4ba10cfd1578d8129
            gambar: imagePath,
            tags: [_selectedKategori!],
            isi: _isiController.text,
          );
<<<<<<< HEAD

          final index = listBerita.indexWhere((b) => b.id == widget.berita!.id);
          if (index != -1) {
            listBerita[index] = beritaDiedit;
          }
        } else {
          // --- LOGIKA UNTUK TAMBAH BERITA BARU ---
          int lastIdNum = 0;
          if (listBerita.isNotEmpty) {
            final lastId = listBerita
                .map((b) => int.parse(b.id.split('-').last))
                .reduce((a, b) => a > b ? a : b);
            lastIdNum = lastId;
          } else {
            // Jika kosong, bisa mulai dari angka tertentu, misal 55
            lastIdNum = 55;
          }
          final newId = 'brt-${(lastIdNum + 1).toString().padLeft(3, '0')}';

=======
          final index = listBerita.indexWhere((b) => b.id == widget.berita!.id);
          if (index != -1) listBerita[index] = beritaDiedit;
        } else {
          int lastIdNum = 0;
          if (listBerita.isNotEmpty) {
            final ids = listBerita.map((b) => int.tryParse(b.id.split('-').last) ?? 0);
            if (ids.isNotEmpty) lastIdNum = ids.reduce((a, b) => a > b ? a : b);
          } else {
            lastIdNum = 55;
          }
          final newId = 'brt-${(lastIdNum + 1).toString().padLeft(3, '0')}';
>>>>>>> 8da38e30eaff57305e73c3c4ba10cfd1578d8129
          final Berita beritaBaru = Berita(
            id: newId,
            judul: _judulController.text,
            editor: _editorController.text,
            tanggal: DateTime.now(),
            gambar: imagePath,
            tags: [_selectedKategori!],
            isi: _isiController.text,
          );
          listBerita.insert(0, beritaBaru);
        }

<<<<<<< HEAD
        final List<Map<String, dynamic>> jsonList = listBerita
            .map((b) => b.toJson())
            .toList();
        await file.writeAsString(json.encode(jsonList));

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              'Berita berhasil ${_isEditing ? 'diperbarui' : 'disimpan'}!',
            ),
            backgroundColor: Colors.green,
          ),
        );

        if (mounted)
          Navigator.pop(context, true); // Kirim sinyal 'true' bahwa ada update
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Gagal menyimpan: $e'),
            backgroundColor: Colors.red,
          ),
        );
=======
        final List<Map<String, dynamic>> jsonList = listBerita.map((b) => b.toJson()).toList();
        await file.writeAsString(json.encode(jsonList));

        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Berita berhasil ${_isEditing ? 'diperbarui' : 'disimpan'}!'), backgroundColor: Colors.green),
          );
          Navigator.pop(context, true);
        }
      } catch (e) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Gagal menyimpan: $e'), backgroundColor: Colors.red));
        }
>>>>>>> 8da38e30eaff57305e73c3c4ba10cfd1578d8129
      } finally {
        if (mounted) setState(() => _isLoading = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
<<<<<<< HEAD
    // Menentukan gambar yang akan ditampilkan di form
    Widget imagePreview;
    if (_selectedImage != null) {
      imagePreview = Image.file(
        _selectedImage!,
        fit: BoxFit.cover,
        width: double.infinity,
      );
    } else if (_isEditing && widget.berita!.gambar.startsWith('assets/')) {
      imagePreview = Image.asset(
        widget.berita!.gambar,
        fit: BoxFit.cover,
        width: double.infinity,
      );
    } else if (_isEditing) {
      imagePreview = Image.file(
        File(widget.berita!.gambar),
        fit: BoxFit.cover,
        width: double.infinity,
      );
=======
    Widget imagePreview;
    if (_selectedImage != null) {
      imagePreview = Image.file(_selectedImage!, fit: BoxFit.cover, width: double.infinity);
    } else if (_isEditing && widget.berita!.gambar.startsWith('assets/')) {
      imagePreview = Image.asset(widget.berita!.gambar, fit: BoxFit.cover, width: double.infinity);
    } else if (_isEditing && widget.berita!.gambar.isNotEmpty) {
      imagePreview = Image.file(File(widget.berita!.gambar), fit: BoxFit.cover, width: double.infinity);
>>>>>>> 8da38e30eaff57305e73c3c4ba10cfd1578d8129
    } else {
      imagePreview = const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
<<<<<<< HEAD
          children: [
            Icon(Icons.add_a_photo, size: 40, color: Colors.grey),
            SizedBox(height: 8),
            Text('Ketuk untuk pilih gambar'),
          ],
=======
          children: [Icon(Icons.add_a_photo, size: 40, color: Colors.grey), SizedBox(height: 8), Text('Ketuk untuk pilih gambar')],
>>>>>>> 8da38e30eaff57305e73c3c4ba10cfd1578d8129
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
<<<<<<< HEAD
        // Ganti judul berdasarkan mode (tambah atau edit)
=======
>>>>>>> 8da38e30eaff57305e73c3c4ba10cfd1578d8129
        title: Text(_isEditing ? 'Form Edit Berita' : 'Form Tambah Berita'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              GestureDetector(
                onTap: _pickImage,
                child: Container(
                  height: 200,
                  decoration: BoxDecoration(
                    color: Colors.grey[200],
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: Colors.grey),
                  ),
<<<<<<< HEAD
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: imagePreview,
                  ),
=======
                  child: ClipRRect(borderRadius: BorderRadius.circular(12), child: imagePreview),
>>>>>>> 8da38e30eaff57305e73c3c4ba10cfd1578d8129
                ),
              ),
              const SizedBox(height: 24),
              TextFormField(
                controller: _judulController,
                decoration: const InputDecoration(
                  labelText: 'Judul Berita',
                  border: OutlineInputBorder(),
                ),
                validator: (value) => (value == null || value.isEmpty)
                    ? 'Judul tidak boleh kosong!'
                    : null,
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _editorController,
                decoration: const InputDecoration(
                  labelText: 'Nama Editor',
                  border: OutlineInputBorder(),
                ),
                validator: (value) => (value == null || value.isEmpty)
                    ? 'Editor tidak boleh kosong!'
                    : null,
              ),
              const SizedBox(height: 16),
<<<<<<< HEAD

=======
>>>>>>> 8da38e30eaff57305e73c3c4ba10cfd1578d8129
              DropdownButtonFormField<String>(
                value: _selectedKategori,
                hint: const Text('Pilih Kategori'),
                decoration: const InputDecoration(border: OutlineInputBorder()),
<<<<<<< HEAD
                items: _kategoriList.map((String kategori) {
                  return DropdownMenuItem<String>(
                    value: kategori,
                    child: Text(kategori),
                  );
                }).toList(),
                onChanged: (newValue) {
                  setState(() {
                    _selectedKategori = newValue;
                  });
                },
                validator: (value) =>
                    value == null ? 'Kategori tidak boleh kosong' : null,
=======
                items: _kategoriList.map((String kategori) => DropdownMenuItem<String>(value: kategori, child: Text(kategori))).toList(),
                onChanged: (newValue) => setState(() => _selectedKategori = newValue),
                validator: (value) => value == null ? 'Kategori tidak boleh kosong' : null,
>>>>>>> 8da38e30eaff57305e73c3c4ba10cfd1578d8129
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _isiController,
                decoration: const InputDecoration(
                  labelText: 'Isi Berita',
                  border: OutlineInputBorder(),
                  alignLabelWithHint: true,
                ),
                maxLines: 10,
                validator: (value) => (value == null || value.isEmpty)
                    ? 'Isi berita tidak boleh kosong!'
                    : null,
              ),
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: _isLoading ? null : _simpanBerita,
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  backgroundColor: Theme.of(context).colorScheme.primary,
                  foregroundColor: Theme.of(context).colorScheme.onPrimary,
                ),
                child: _isLoading
<<<<<<< HEAD
                    ? const SizedBox(
                        height: 24,
                        width: 24,
                        child: CircularProgressIndicator(
                          color: Colors.white,
                          strokeWidth: 3,
                        ),
                      )
=======
                    ? const SizedBox(height: 24, width: 24, child: CircularProgressIndicator(color: Colors.white, strokeWidth: 3))
>>>>>>> 8da38e30eaff57305e73c3c4ba10cfd1578d8129
                    : Text(_isEditing ? 'UPDATE BERITA' : 'SIMPAN BERITA'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
