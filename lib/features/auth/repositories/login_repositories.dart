
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
    try {
      final response = await _apiService.login(request);
      final loginResponse = _apiService.parseLoginResponse(response);
      
      // Save tokens if login successful
      if (loginResponse.success && loginResponse.data != null) {
        await _authService.saveTokens(
          TokenModel(
            accessToken: loginResponse.data!.accessToken,
            refreshToken: loginResponse.data!.refreshToken,
          ),
        );
        await _authService.saveUser(loginResponse.data!.user);
      }
      
      return loginResponse;
    } catch (e) {
      rethrow;
    }
  }

  // SESSION CHECK
  Future<bool> isLoggedIn() async {
    return await _authService.isLoggedIn();
  }

  Future<void> logout() async {
    await _authService.logout();
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
}