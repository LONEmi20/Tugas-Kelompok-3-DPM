import 'package:flutter/foundation.dart';

class Berita {
  final String id;
  final String judul;
  final String editor;
  final DateTime tanggal;
  final String gambar;
  final List<String> tags;
  final String isi;

  Berita({
    required this.id,
    required this.judul,
    required this.editor,
    required this.tanggal,
    required this.gambar,
    required this.tags,
    required this.isi,
  });

  factory Berita.fromJson(Map<String, dynamic> json) {
    return Berita(
      id: json['id'],
      judul: json['judul'],
      editor: json['editor'],
      tanggal: DateTime.parse(json['tanggal']),
      gambar: json['gambar'],
      tags: List<String>.from(json['tags']),
      isi: json['isi'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'judul': judul,
      'editor': editor,
      'tanggal': tanggal.toIso8601String(),
      'gambar': gambar,
      'tags': tags,
      'isi': isi,
    };
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
  
    return other is Berita &&
      other.id == id &&
      other.judul == judul &&
      other.editor == editor &&
      other.tanggal == tanggal &&
      other.gambar == gambar &&
      listEquals(other.tags, tags) &&
      other.isi == isi;
  }

  @override
  int get hashCode {
    return id.hashCode ^
      judul.hashCode ^
      editor.hashCode ^
      tanggal.hashCode ^
      gambar.hashCode ^
      tags.hashCode ^
      isi.hashCode;
  }
}
