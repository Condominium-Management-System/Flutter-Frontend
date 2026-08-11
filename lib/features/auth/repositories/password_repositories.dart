
import '../../../core/di/service_locator.dart';
import '../models/forgot_password_model.dart';
import '../models/reset_password_model.dart';
import '../models/change_password_model.dart';
import '../services/password_api_service.dart';

class PasswordRepository {
  final PasswordApiService _apiService = getIt<PasswordApiService>();

  // FORGOT PASSWORD
  Future<ForgotPasswordResponse> forgotPassword(ForgotPasswordRequest request) async {
    try {
      final response = await _apiService.forgotPassword(request);
      return _apiService.parseForgotPasswordResponse(response);
    } catch (e) {
      rethrow;
    }
  }

  // RESET PASSWORD
  Future<ResetPasswordResponse> resetPassword(ResetPasswordRequest request) async {
    try {
      final response = await _apiService.resetPassword(request);
      return _apiService.parseResetPasswordResponse(response);
    } catch (e) {
      rethrow;
    }
  }

  // CHANGE PASSWORD (Authenticated)
  Future<ChangePasswordResponse> changePassword(ChangePasswordRequest request) async {
    try {
      final response = await _apiService.changePassword(request);
      return _apiService.parseChangePasswordResponse(response);
    } catch (e) {
      rethrow;
    }
  }
}