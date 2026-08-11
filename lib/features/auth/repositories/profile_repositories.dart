
import '../../../core/services/auth_service.dart';
import '../../../core/di/service_locator.dart';
import '../models/user_model.dart';
import '../models/profile_model.dart';
import '../services/profile_api_service.dart';

class ProfileRepository {
  final ProfileApiService _apiService = getIt<ProfileApiService>();
  final AuthService _authService = getIt<AuthService>();

  // GET PROFILE
  Future<UserModel> getProfile() async {
    try {
      final response = await _apiService.getProfile();
      final user = _apiService.parseProfileResponse(response);
      
      // Update stored user data
      await _authService.saveUser(user);
      
      return user;
    } catch (e) {
      rethrow;
    }
  }

  // UPDATE PROFILE
  Future<ProfileUpdateResponse> updateProfile({
    String? fullName,
    String? phoneNumber,
    String? profilePhotoPath,
    String? frontIdPath,
    String? backIdPath,
  }) async {
    try {
      final response = await _apiService.updateProfile(
        fullName: fullName,
        phoneNumber: phoneNumber,
        profilePhotoPath: profilePhotoPath,
        frontIdPath: frontIdPath,
        backIdPath: backIdPath,
      );
      
      final profileResponse = _apiService.parseProfileUpdateResponse(response);
      
      // Update stored user data if successful
      if (profileResponse.success && profileResponse.data != null) {
        await _authService.saveUser(profileResponse.data!);
      }
      
      return profileResponse;
    } catch (e) {
      rethrow;
    }
  }

  // GET CACHED PROFILE
  Future<UserModel?> getCachedProfile() async {
    return await _authService.getUser();
  }

  // CLEAR PROFILE CACHE
  Future<void> clearCache() async {
    await _authService.clearUser();
  }
}