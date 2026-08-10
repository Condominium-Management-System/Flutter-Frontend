
import 'package:dio/dio.dart';
import '../../../core/network/dio_client.dart';
import '../../../core/constants/api_constant.dart';
import '../models/login_model.dart';

class LoginApiService {
  final Dio _dio = DioClient.instance;

  // Login user
  Future<Response> login(LoginRequest request) async {
    return await _dio.post(
      ApiConstants.authLogin,
      data: request.toJson(),
    );
  }

  // Parse login response
  LoginResponse parseLoginResponse(Response response) {
    if (response.data == null) {
      throw Exception('No data received');
    }
    return LoginResponse.fromJson(response.data as Map<String, dynamic>);
  }
}