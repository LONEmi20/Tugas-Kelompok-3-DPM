import 'dart:convert';
import 'dart:io';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart'; 
import 'package:tugas_kelompok_dpm/models/user_model.dart';

class LocalAuthService {
  Future<String> get _localPath async {
    final directory = await getApplicationDocumentsDirectory();
    return directory.path;
  }

  Future<File> get _localFile async {
    final path = await _localPath;
    return File('$path/accounts.json');
  }
  
  Future<void> _initFile() async {
    final file = await _localFile;
    if (!await file.exists()) {
      final byteData = await rootBundle.loadString('assets/data/accounts.json');
      await file.writeAsString(byteData);
    }
  }

  Future<List<User>> getUsers() async {
    await _initFile();
    try {
      final file = await _localFile;
      final contents = await file.readAsString();
      if (contents.isEmpty) return [];
      
      final List<dynamic> jsonData = json.decode(contents);
      return jsonData.map((userJson) => User.fromJson(userJson)).toList();
    } catch (e) {
      print("Error reading users: $e");
      return [];
    }
  }

  Future<File> saveUsers(List<User> users) async {
    final file = await _localFile;
    final List<Map<String, dynamic>> jsonData = users.map((user) => user.toJson()).toList();
    return file.writeAsString(json.encode(jsonData));
  }

  Future<User?> login(String email, String password) async {
    final users = await getUsers();
    try {
      final user = users.firstWhere(
        (user) => user.email == email && user.password == password,
      );
      // simpan sesi
      await saveLoginSession(user.email);
      return user;
    } catch (e) {
      return null;
    }
  }

  Future<bool> signUp(User newUser) async {
    final users = await getUsers();
    if (users.any((user) => user.email == newUser.email)) {
      return false;
    }
    users.add(newUser);
    await saveUsers(users);
    return true;
  }

  // --- FUNGSI MANAJEMEN SESI/TOKEN ---

  // Simpan sesi login
  Future<void> saveLoginSession(String email) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('user_email', email);
    // Simpan waktu login
    await prefs.setInt('login_timestamp', DateTime.now().millisecondsSinceEpoch);
  }

  // Cek login session (token exp dalam 24 jam)
  Future<bool> isUserLoggedIn() async {
    final prefs = await SharedPreferences.getInstance();
    final timestamp = prefs.getInt('login_timestamp');

    if (timestamp == null) {
      return false; // data login tidak ada
    }

    final loginTime = DateTime.fromMillisecondsSinceEpoch(timestamp);
    final currentTime = DateTime.now();
    final difference = currentTime.difference(loginTime);

    // Jika kurang dari 24 jam, maka masih valid
    return difference.inHours < 24;
  }

  // Hapus sesi login (untuk logout)
  Future<void> clearLoginSession() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('user_email');
    await prefs.remove('login_timestamp');
  }
}
