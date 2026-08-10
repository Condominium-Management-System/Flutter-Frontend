
import 'package:dio/dio.dart';
import '../../../core/network/dio_client.dart';
import '../../../core/constants/api_constant.dart';
import '../models/forgot_password_model.dart';
import '../models/reset_password_model.dart';
import '../models/change_password_model.dart';

class PasswordApiService {
  final Dio _dio = DioClient.instance;

  // Forgot Password
  Future<Response> forgotPassword(ForgotPasswordRequest request) async {
    return await _dio.post(
      ApiConstants.authForgotPassword,
      data: request.toJson(),
    );
  }

  // Reset Password
  Future<Response> resetPassword(ResetPasswordRequest request) async {
    return await _dio.post(
      ApiConstants.authResetPassword,
      data: request.toJson(),
    );
  }

  // Change Password (authenticated)
  Future<Response> changePassword(ChangePasswordRequest request) async {
    return await _dio.put(
      '/auth/change-password',
      data: request.toJson(),
    );
  }

  // Parse forgot password response
  ForgotPasswordResponse parseForgotPasswordResponse(Response response) {
    if (response.data == null) {
      throw Exception('No data received');
    }
    return ForgotPasswordResponse.fromJson(response.data as Map<String, dynamic>);
  }

  // Parse reset password response
  ResetPasswordResponse parseResetPasswordResponse(Response response) {
    if (response.data == null) {
      throw Exception('No data received');
    }
    return ResetPasswordResponse.fromJson(response.data as Map<String, dynamic>);
  }

  // Parse change password response
  ChangePasswordResponse parseChangePasswordResponse(Response response) {
    if (response.data == null) {
      throw Exception('No data received');
    }
    return ChangePasswordResponse.fromJson(response.data as Map<String, dynamic>);
  }
}