
// import 'package:dio/dio.dart';
// import '../../../core/network/dio_client.dart';
// import '../../../core/constants/api_constant.dart';
// import '../models/login_model.dart';

// class LoginApiService {
//   final Dio _dio = DioClient.instance;

//   // Login user
//   Future<Response> login(LoginRequest request) async {
//     return await _dio.post(
//       ApiConstants.authLogin,
//       data: request.toJson(),
//     );
//   }

//   // Parse login response
//   LoginResponse parseLoginResponse(Response response) {
//     if (response.data == null) {
//       throw Exception('No data received');
//     }
//     return LoginResponse.fromJson(response.data as Map<String, dynamic>);
//   }
// }

// ============================================
// FILE: lib/features/auth/services/login_api_service.dart
// PURPOSE: Login specific API service
// ============================================

// ignore_for_file: avoid_print

import 'package:dio/dio.dart';
import '../../../core/network/dio_client.dart';
import '../../../core/constants/api_constant.dart';
import '../models/login_model.dart';

class LoginApiService {
  final Dio _dio = DioClient.instance;

  // Login user
  Future<Response> login(LoginRequest request) async {
    print('🔵 LOGIN API: Sending request to ${ApiConstants.authLogin}');
    print('🔵 LOGIN API: Data: ${request.toJson()}');
    
    try {
      final response = await _dio.post(
        ApiConstants.authLogin,
        data: request.toJson(),
      );
      
      print('🟢 LOGIN API: Response received');
      print('🟢 LOGIN API: Status: ${response.statusCode}');
      print('🟢 LOGIN API: Data: ${response.data}');
      
      return response;
    } catch (e) {
      print('🔴 LOGIN API ERROR: $e');
      rethrow;
    }
  }

  // Parse login response
  LoginResponse parseLoginResponse(Response response) {
    print('🟢 LOGIN API: Parsing response...');
    if (response.data == null) {
      print('🔴 LOGIN API: No data received');
      throw Exception('No data received');
    }
    final parsed = LoginResponse.fromJson(response.data as Map<String, dynamic>);
    print('🟢 LOGIN API: Parsed: success=${parsed.success}');
    return parsed;
  }
}