
// ignore_for_file: unused_import

import 'package:dio/dio.dart';
import '../../../core/network/dio_client.dart';
import '../../../core/constants/api_constant.dart';
import '../models/login_model.dart';
import '../models/register_model.dart';
import '../models/forgot_password_model.dart';
import '../models/reset_password_model.dart';
import '../models/user_model.dart';
import '../models/change_password_model.dart';
import '../models/profile_model.dart';

class AuthApiService {
  final Dio _dio = DioClient.instance;

  // AUTHENTICATION ENDPOINTS

  // Login
  Future<Response> login(LoginRequest request) async {
    return await _dio.post(
      ApiConstants.authLogin,
      data: request.toJson(),
    );
  }

  // Register
  Future<Response> register(RegisterRequest request) async {
    return await _dio.post(
      ApiConstants.authRegister,
      data: request.toJson(),
    );
  }

  // Refresh Token
  Future<Response> refreshToken(String refreshToken) async {
    return await _dio.post(
      ApiConstants.authRefreshToken,
      data: {'refreshToken': refreshToken},
    );
  }

  // Logout
  Future<Response> logout() async {
    return await _dio.post(ApiConstants.authLogout);
  }

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

  // PROFILE ENDPOINTS

  // Get Profile (Me)
  Future<Response> getProfile() async {
    return await _dio.get(ApiConstants.authMe);
  }

  // Update Profile (with file uploads)
  Future<Response> updateProfile({
    String? fullName,
    String? phoneNumber,
    String? profilePhotoPath,
    String? frontIdPath,
    String? backIdPath,
  }) async {
    final formData = FormData();

    if (fullName != null) {
      formData.fields.add(MapEntry('fullName', fullName));
    }
    if (phoneNumber != null) {
      formData.fields.add(MapEntry('phoneNumber', phoneNumber));
    }
    if (profilePhotoPath != null) {
      formData.files.add(
        MapEntry(
          'profilePhoto',
          await MultipartFile.fromFile(profilePhotoPath),
        ),
      );
    }
    if (frontIdPath != null) {
      formData.files.add(
        MapEntry(
          'frontId',
          await MultipartFile.fromFile(frontIdPath),
        ),
      );
    }
    if (backIdPath != null) {
      formData.files.add(
        MapEntry(
          'backId',
          await MultipartFile.fromFile(backIdPath),
        ),
      );
    }

    return await _dio.patch(
      ApiConstants.authMe,
      data: formData,
      options: Options(
        headers: {
          ApiConstants.contentType: ApiConstants.multipartFormData,
        },
      ),
    );
  }

  // Change Password
  Future<Response> changePassword(ChangePasswordRequest request) async {
    return await _dio.put(
      '/auth/change-password',
      data: request.toJson(),
    );
  }
}