
import 'package:home_axis/features/auth/models/token_model.dart';

import '../../../core/services/auth_service.dart';
import '../../../core/di/service_locator.dart';
import '../models/register_model.dart';
import '../services/register_api_service.dart';

class RegisterRepository {
  final RegisterApiService _apiService = getIt<RegisterApiService>();
  final AuthService _authService = getIt<AuthService>();

  // REGISTER
  Future<RegisterResponse> register(RegisterRequest request) async {
    try {
      final response = await _apiService.register(request);
      final registerResponse = _apiService.parseRegisterResponse(response);
      
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

  // CHECK REGISTRATION STATUS
  Future<bool> isLoggedIn() async {
    return await _authService.isLoggedIn();
  }
}