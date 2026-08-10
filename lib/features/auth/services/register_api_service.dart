
import 'package:dio/dio.dart';
import '../../../core/network/dio_client.dart';
import '../../../core/constants/api_constant.dart';
import '../models/register_model.dart';

class RegisterApiService {
  final Dio _dio = DioClient.instance;

  // Register user
  Future<Response> register(RegisterRequest request) async {
    return await _dio.post(
      ApiConstants.authRegister,
      data: request.toJson(),
    );
  }

  // Parse register response
  RegisterResponse parseRegisterResponse(Response response) {
    if (response.data == null) {
      throw Exception('No data received');
    }
    return RegisterResponse.fromJson(response.data as Map<String, dynamic>);
  }
}