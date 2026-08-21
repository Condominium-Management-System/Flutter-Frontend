
import 'package:home_axis/features/auth/models/token_model.dart';

import '../../../core/services/auth_service.dart';
import '../../../core/services/token_service.dart';
import '../../../core/di/service_locator.dart';
import '../models/login_model.dart';
import '../models/register_model.dart';
import '../models/forgot_password_model.dart';
import '../models/reset_password_model.dart';
import '../models/user_model.dart';
import '../services/auth_api_service.dart';

class AuthRepository {
  final AuthApiService _apiService = getIt<AuthApiService>();
  final AuthService _authService = getIt<AuthService>();
  final TokenService _tokenService = getIt<TokenService>();

  // LOGIN
  Future<LoginResponse> login(LoginRequest request) async {
    try {
      final response = await _apiService.login(request);
      if (response.data == null) {
        throw Exception('No data received');
      }
      
      final loginResponse = LoginResponse.fromJson(
        response.data as Map<String, dynamic>,
      );
      
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

  // REGISTER
  Future<RegisterResponse> register(RegisterRequest request) async {
    try {
      final response = await _apiService.register(request);
      if (response.data == null) {
        throw Exception('No data received');
      }
      
      final registerResponse = RegisterResponse.fromJson(
        response.data as Map<String, dynamic>,
      );
      
      // Save tokens if registration successful
      if (registerResponse.success && registerResponse.data != null) {
        await _authService.saveTokens(
          TokenModel(
            accessToken: registerResponse.data!.accessToken,
            refreshToken: registerResponse.data!.refreshToken,
          ),
        );
      }
      
      return registerResponse;
    } catch (e) {
      rethrow;
    }
  }

  // REFRESH TOKEN
  Future<String?> refreshToken(String refreshToken) async {
    try {
      final response = await _apiService.refreshToken(refreshToken);
      if (response.data == null) {
        return null;
      }
      
      final data = response.data as Map<String, dynamic>;
      if (data['success'] == true && data['data'] != null) {
        final newAccessToken = data['data']['accessToken'] as String?;
        if (newAccessToken != null) {
          await _authService.saveTokens(
            TokenModel(
              accessToken: newAccessToken,
              refreshToken: refreshToken,
            ),
          );
          return newAccessToken;
        }
      }
      return null;
    } catch (e) {
      return null;
    }
  }

  // LOGOUT
  Future<void> logout() async {
    try {
      await _apiService.logout();
    } catch (_) {
      // Ignore errors during logout
    } finally {
      await _authService.logout();
    }
  }

  // FORGOT PASSWORD
  Future<ForgotPasswordResponse> forgotPassword(ForgotPasswordRequest request) async {
    try {
      final response = await _apiService.forgotPassword(request);
      if (response.data == null) {
        throw Exception('No data received');
      }
      
      return ForgotPasswordResponse.fromJson(
        response.data as Map<String, dynamic>,
      );
    } catch (e) {
      rethrow;
    }
  }

  // RESET PASSWORD
  Future<ResetPasswordResponse> resetPassword(ResetPasswordRequest request) async {
    try {
      final response = await _apiService.resetPassword(request);
      if (response.data == null) {
        throw Exception('No data received');
      }
      
      return ResetPasswordResponse.fromJson(
        response.data as Map<String, dynamic>,
      );
    } catch (e) {
      rethrow;
    }
  }

  // SESSION MANAGEMENT
  Future<bool> isLoggedIn() async {
    return await _authService.isLoggedIn();
  }

  Future<UserModel?> getUser() async {
    return await _authService.getUser();
  }

  Future<String?> getAccessToken() async {
    return await _authService.getAccessToken();
  }

  Future<String?> getRefreshToken() async {
    return await _authService.getRefreshToken();
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

  // VALIDATION HELPERS
  Future<bool> isTokenExpired() async {
    return await _tokenService.isTokenExpired();
  }
}