// ignore_for_file: avoid_print

import 'package:home_axis/features/auth/models/token_model.dart';

import '../../../core/services/auth_service.dart';
import '../../../core/di/service_locator.dart';
import '../models/login_model.dart';
import '../services/login_api_service.dart';

class LoginRepository {
  final LoginApiService _apiService = getIt<LoginApiService>();
  final AuthService _authService = getIt<AuthService>();

  // LOGIN
  Future<LoginResponse> login(LoginRequest request) async {
    print('🔵 LOGIN REPO: Starting login...');
    
    try {
      final response = await _apiService.login(request);
      print('🟢 LOGIN REPO: Got response from API');
      
      final loginResponse = _apiService.parseLoginResponse(response);
      print('🟢 LOGIN REPO: Parsed response: success=${loginResponse.success}');
      
      // Save tokens if login successful
      if (loginResponse.success && loginResponse.data != null) {
        print('🟢 LOGIN REPO: Saving tokens and user data...');
        await _authService.saveTokens(
          TokenModel(
            accessToken: loginResponse.data!.accessToken,
            refreshToken: loginResponse.data!.refreshToken,
          ),
        );
        await _authService.saveUser(loginResponse.data!.user);
        print('🟢 LOGIN REPO: Tokens and user data saved!');
      } else {
        print('🔴 LOGIN REPO: Login failed: ${loginResponse.message}');
      }
      
      return loginResponse;
    } catch (e) {
      print('🔴 LOGIN REPO ERROR: $e');
      rethrow;
    }
  }

  // REMEMBER ME
  Future<void> setRememberMe(bool value) async {
    await _authService.setRememberMe(value);
  }

  Future<bool> getRememberMe() async {
    return await _authService.getRememberMe();
  }

  Future<void> saveCredentials(String email, String password) async {
    await _authService.saveCredentials(email, password);
  }

  Future<Map<String, String>> getCredentials() async {
    return await _authService.getCredentials();
  }

  Future<void> clearCredentials() async {
    await _authService.clearCredentials();
  }

  Future<void> logout() async {
    await _authService.logout();
  }
}