
import 'package:dio/dio.dart';
import '../../../core/network/dio_client.dart';
import '../../../core/constants/api_constant.dart';
import '../models/user_model.dart';
import '../models/profile_model.dart';

class ProfileApiService {
  final Dio _dio = DioClient.instance;

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

  // Parse profile response
  UserModel parseProfileResponse(Response response) {
    if (response.data == null) {
      throw Exception('No data received');
    }
    final Map<String, dynamic> json = response.data as Map<String, dynamic>;
    if (json['data'] == null) {
      throw Exception('No user data received');
    }
    return UserModel.fromJson(json['data'] as Map<String, dynamic>);
  }

  // Parse profile update response
  ProfileUpdateResponse parseProfileUpdateResponse(Response response) {
    if (response.data == null) {
      throw Exception('No data received');
    }
    return ProfileUpdateResponse.fromJson(response.data as Map<String, dynamic>);
  }
}