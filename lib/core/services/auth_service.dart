
// ignore_for_file: unused_field, unused_import

import 'dart:convert';
import '../../features/auth/models/user_model.dart';
import '../../features/auth/models/token_model.dart';
import '../storage/storage_keys.dart';
import '../storage/secure_storage.dart';
import '../storage/shared_prefs.dart';
import '../constants/api_constant.dart';
import '../di/service_locator.dart';
import 'connectivity_service.dart';

class AuthService {
  final SecureStorage _secureStorage = SecureStorage();
  final SharedPrefs _sharedPrefs = SharedPrefs();
  final ConnectivityService _connectivityService = ConnectivityService();
  
  // Token management
  Future<void> saveTokens(TokenModel tokens) async {
    await SecureStorage.write(StorageKeys.accessToken, tokens.accessToken);
    await SecureStorage.write(StorageKeys.refreshToken, tokens.refreshToken);
    await SharedPrefs.setBool(StorageKeys.isLoggedIn, true);
  }

  Future<String?> getAccessToken() async {
    return await SecureStorage.read(StorageKeys.accessToken);
  }

  Future<String?> getRefreshToken() async {
    return await SecureStorage.read(StorageKeys.refreshToken);
  }

  Future<void> clearTokens() async {
    await SecureStorage.delete(StorageKeys.accessToken);
    await SecureStorage.delete(StorageKeys.refreshToken);
    await SharedPrefs.setBool(StorageKeys.isLoggedIn, false);
  }
  
  // User data management
  Future<void> saveUser(UserModel user) async {
    await SharedPrefs.setString(StorageKeys.userData, jsonEncode(user.toJson()));
    await SharedPrefs.setString(StorageKeys.userId, user.id);
    await SharedPrefs.setString(StorageKeys.userRole, user.role);
    await SharedPrefs.setString(StorageKeys.condoId, user.condoId ?? '');
    await SharedPrefs.setBool(StorageKeys.isVerified, user.isVerified);
  }
  
  Future<UserModel?> getUser() async {
    final userData = SharedPrefs.getString(StorageKeys.userData);
    if (userData == null) return null;
    try {
      final Map<String, dynamic> json = jsonDecode(userData);
      return UserModel.fromJson(json);
    } catch (_) {
      return null;
    }
  }
  
  Future<void> clearUser() async {
    await SharedPrefs.remove(StorageKeys.userData);
    await SharedPrefs.remove(StorageKeys.userId);
    await SharedPrefs.remove(StorageKeys.userRole);
    await SharedPrefs.remove(StorageKeys.condoId);
    await SharedPrefs.remove(StorageKeys.isVerified);
  }
  
  // Session management
  Future<bool> isLoggedIn() async {
    final token = await getAccessToken();
    final isLoggedIn = SharedPrefs.getBool(StorageKeys.isLoggedIn) ?? false;
    return token != null && isLoggedIn;
  }
  
  Future<void> logout() async {
    await clearTokens();
    await clearUser();
  }
  
  // Remember me
  Future<void> setRememberMe(bool value) async {
    await SharedPrefs.setBool(StorageKeys.rememberMe, value);
  }
  
  Future<bool> getRememberMe() async {
    return SharedPrefs.getBool(StorageKeys.rememberMe) ?? false;
  }
  
  Future<void> saveCredentials(String email, String password) async {
    await SharedPrefs.setString(StorageKeys.savedEmail, email);
    await SharedPrefs.setString(StorageKeys.savedPassword, password);
  }
  
  Future<Map<String, String>> getCredentials() async {
    return {
      'email': SharedPrefs.getString(StorageKeys.savedEmail) ?? '',
      'password': SharedPrefs.getString(StorageKeys.savedPassword) ?? '',
    };
  }
  
  Future<void> clearCredentials() async {
    await SharedPrefs.remove(StorageKeys.savedEmail);
    await SharedPrefs.remove(StorageKeys.savedPassword);
  }
  
  // Connectivity check
  Future<bool> hasInternetConnection() async {
    return await _connectivityService.checkConnection();
  }
  
  // Get connection status stream
  Stream<bool> get connectionStream => _connectivityService.connectionStream;
}