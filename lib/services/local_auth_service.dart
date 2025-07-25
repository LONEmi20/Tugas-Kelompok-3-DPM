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
    final List<Map<String, dynamic>> jsonData =
        users.map((user) => user.toJson()).toList();
    return file.writeAsString(json.encode(jsonData));
  }
  
  Future<bool> updateUser(User updatedUser, String originalEmail) async {
    List<User> users = await getUsers();
    int userIndex = users.indexWhere((user) => user.email == originalEmail);

    if (userIndex != -1) {
      users[userIndex] = updatedUser;
      await saveUsers(users);
      if (updatedUser.email != originalEmail) {
        await saveLoginSession(updatedUser.email);
      }
      return true;
    }
    return false;
  }

  Future<User?> login(String email, String password) async {
    final users = await getUsers();
    try {
      final user = users.firstWhere(
        (user) => user.email == email && user.password == password,
      );
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

  Future<bool> checkEmailExists(String email) async {
    final users = await getUsers();
    return users.any((user) => user.email == email);
  }

  Future<bool> updatePassword(String email, String newPassword) async {
    List<User> users = await getUsers();
    int userIndex = users.indexWhere((user) => user.email == email);

    if (userIndex != -1) {
      User oldUser = users[userIndex];
      User updatedUser = User(
        name: oldUser.name,
        noHp: oldUser.noHp,
        email: oldUser.email,
        password: newPassword, 
        profilePicture: oldUser.profilePicture,
      );
      users[userIndex] = updatedUser;
      await saveUsers(users);
      return true;
    }
    return false;
  }

  Future<void> saveLoginSession(String email) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('user_email', email);
  }

  Future<User?> getLoggedInUser() async {
    final prefs = await SharedPreferences.getInstance();
    final email = prefs.getString('user_email');
    if (email == null) return null;

    final users = await getUsers();
    try {
      return users.firstWhere((user) => user.email == email);
    } catch (e) {
      return null;
    }
  }

  Future<void> clearLoginSession() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('user_email');
  }
}
