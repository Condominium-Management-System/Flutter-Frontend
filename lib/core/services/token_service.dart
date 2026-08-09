
// ignore_for_file: unused_field, unused_import

import 'dart:convert';
import 'package:dio/dio.dart';
import '../storage/secure_storage.dart';
import '../constants/storage_consatnt.dart';
import '../di/service_locator.dart';
import '../../features/auth/repositories/auth_repository.dart';

class TokenService {
  final SecureStorage _secureStorage = SecureStorage();
  
  Future<String?> getAccessToken() async {
    return await SecureStorage.read(StorageKeys.accessToken);
  }
  
  Future<String?> getRefreshToken() async {
    return await SecureStorage.read(StorageKeys.refreshToken);
  }
  
  Future<void> saveTokens(String accessToken, String refreshToken) async {
    await SecureStorage.write(StorageKeys.accessToken, accessToken);
    await SecureStorage.write(StorageKeys.refreshToken, refreshToken);
  }
  
  Future<void> clearTokens() async {
    await SecureStorage.delete(StorageKeys.accessToken);
    await SecureStorage.delete(StorageKeys.refreshToken);
  }
  
  bool isTokenExpired() {
    final token = getAccessTokenSync();
    if (token == null) return true;
    
    try {
      final parts = token.split('.');
      if (parts.length != 3) return true;
      
      final payload = json.decode(
        utf8.decode(base64Url.decode(base64Url.normalize(parts[1]))),
      );
      
      final exp = payload['exp'] as int?;
      if (exp == null) return true;
      
      final now = DateTime.now().millisecondsSinceEpoch ~/ 1000;
      return exp < now;
    } catch (_) {
      return true;
    }
  }
  
  String? getAccessTokenSync() {
    // This is a synchronous version for use in interceptors
    // In real implementation, you'd need to handle this differently
    return null;
  }
  
  bool refreshToken() {
    // This is a synchronous version for use in interceptors
    // In real implementation, you'd need to handle this differently
    return false;
  }
}