
// ignore_for_file: prefer_const_declarations

import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SecureStorage {
  static final FlutterSecureStorage _storage = const FlutterSecureStorage(
    aOptions: AndroidOptions(
      encryptedSharedPreferences: true,
    ),
  );
  
  // Write
  static Future<void> write(String key, String value) async {
    await _storage.write(key: key, value: value);
  }
  
  // Read
  static Future<String?> read(String key) async {
    return await _storage.read(key: key);
  }
  
  // Delete
  static Future<void> delete(String key) async {
    await _storage.delete(key: key);
  }
  
  // Delete all
  static Future<void> deleteAll() async {
    await _storage.deleteAll();
  }
  
  // Check if contains key
  static Future<bool> containsKey(String key) async {
    return await _storage.containsKey(key: key);
  }
  
  // Read all
  static Future<Map<String, String>> readAll() async {
    return await _storage.readAll();
  }
}