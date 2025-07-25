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
      // Simpan sesi
      await saveLoginSession(user.email);
      return user;
    } catch (e) {
      return null;
    }
  }
  
  // --- FUNGSI BARU: Login via sosmed dengan token ---
  Future<bool> loginWithSocial(String email) async {
    final users = await getUsers();
    // Cek apakah user sosmed (dummy) ada di database kita
    if (users.any((user) => user.email == email)) {
      await saveLoginSession(email);
      return true;
    }
    // Jika tidak ada, bisa ditambahkan logic untuk auto-register di sini
    // Untuk sekarang, kita anggap user harus ada
    return false;
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

  // --- FUNGSI BARU: Cek email untuk Lupa Password ---
  Future<bool> checkEmailExists(String email) async {
    final users = await getUsers();
    return users.any((user) => user.email == email);
  }

  // --- FUNGSI BARU: Update password ---
  Future<bool> updatePassword(String email, String newPassword) async {
    List<User> users = await getUsers();
    int userIndex = users.indexWhere((user) => user.email == email);

    if (userIndex != -1) {
      // Buat user baru dengan password yang sudah diupdate
      User oldUser = users[userIndex];
      User updatedUser = User(
        name: oldUser.name,
        noHp: oldUser.noHp,
        email: oldUser.email,
        password: newPassword, // Password baru
        profilePicture: oldUser.profilePicture,
      );
      // Ganti user lama dengan yang baru
      users[userIndex] = updatedUser;
      await saveUsers(users);
      return true;
    }
    return false;
  }

  // --- FUNGSI MANAJEMEN SESI/TOKEN ---
  Future<void> saveLoginSession(String email) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('user_email', email);
    await prefs.setInt('login_timestamp', DateTime.now().millisecondsSinceEpoch);
  }

  Future<bool> isUserLoggedIn() async {
    final prefs = await SharedPreferences.getInstance();
    final timestamp = prefs.getInt('login_timestamp');
    if (timestamp == null) return false;
    final loginTime = DateTime.fromMillisecondsSinceEpoch(timestamp);
    return DateTime.now().difference(loginTime).inHours < 24;
  }

  Future<void> clearLoginSession() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('user_email');
    await prefs.remove('login_timestamp');
  }
}
