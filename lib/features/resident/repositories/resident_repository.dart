
// ignore_for_file: unused_import

import 'package:home_axis/features/auth/models/change_password_model.dart';
import 'package:home_axis/features/auth/models/profile_model.dart';
import 'package:home_axis/features/auth/models/user_model.dart';

import '../../../core/services/auth_service.dart';
import '../../../core/di/service_locator.dart';
import '../services/resident_api_service.dart';
import '../models/dashboard_model.dart';
import '../models/payment_model.dart';
import '../models/announcement_model.dart';
import '../models/report_model.dart';
import '../models/equb_model.dart';
import '../models/iddir_model.dart';
import '../models/lost_found_model.dart';
import '../models/chat_model.dart';
import '../models/notification_model.dart';
import '../models/neighbor_model.dart';
import '../models/transaction_model.dart';

class ResidentRepository {
  final ResidentApiService _apiService = getIt<ResidentApiService>();
  final AuthService _authService = getIt<AuthService>();

  // DASHBOARD
  Future<DashboardModel> getDashboard() async {
    try {
      final response = await _apiService.getDashboard();
      if (response.data == null) {
        throw Exception('No data received');
      }
      final data = response.data as Map<String, dynamic>;
      return DashboardModel.fromJson(data['data'] ?? {});
    } catch (e) {
      rethrow;
    }
  }

  // PROFILE (Reuses Auth)
  Future<UserModel> getProfile() async {
    try {
      final response = await _apiService.getProfile();
      if (response.data == null) {
        throw Exception('No data received');
      }
      final data = response.data as Map<String, dynamic>;
      final user = UserModel.fromJson(data['data'] ?? {});
      await _authService.saveUser(user);
      return user;
    } catch (e) {
      rethrow;
    }
  }

  Future<ProfileUpdateResponse> updateProfile({
    String? fullName,
    String? phoneNumber,
    String? profilePhotoPath,
  }) async {
    try {
      final response = await _apiService.updateProfile(
        fullName: fullName,
        phoneNumber: phoneNumber,
        profilePhotoPath: profilePhotoPath,
      );
      if (response.data == null) {
        throw Exception('No data received');
      }
      final data = response.data as Map<String, dynamic>;
      return ProfileUpdateResponse.fromJson(data);
    } catch (e) {
      rethrow;
    }
  }

  Future<ChangePasswordResponse> changePassword({
    required String oldPassword,
    required String newPassword,
  }) async {
    try {
      final response = await _apiService.changePassword(
        oldPassword: oldPassword,
        newPassword: newPassword,
      );
      if (response.data == null) {
        throw Exception('No data received');
      }
      final data = response.data as Map<String, dynamic>;
      return ChangePasswordResponse.fromJson(data);
    } catch (e) {
      rethrow;
    }
  }

  // CACHED PROFILE
  Future<UserModel?> getCachedProfile() async {
    return await _authService.getUser();
  }

  Future<void> clearCache() async {
    await _authService.clearUser();
  }

  // SESSION
  Future<bool> isLoggedIn() async {
    return await _authService.isLoggedIn();
  }

  Future<void> logout() async {
    await _authService.logout();
  }
}