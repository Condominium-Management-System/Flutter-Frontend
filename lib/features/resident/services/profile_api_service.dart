
import 'package:dio/dio.dart';
import '../../../core/network/dio_client.dart';
import '../../../core/constants/api_constant.dart';

class ProfileApiService {
  final Dio _dio = DioClient.instance;

  // Get Profile (Me)
  Future<Response> getProfile() async {
    return await _dio.get(ApiConstants.authMe);
  }

  // Update Profile
  Future<Response> updateProfile({
    String? fullName,
    String? phoneNumber,
    String? profilePhotoPath,
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
  Future<Response> changePassword({
    required String oldPassword,
    required String newPassword,
  }) async {
    return await _dio.put(
      '/auth/change-password',
      data: {
        'oldPassword': oldPassword,
        'newPassword': newPassword,
      },
    );
  }
}