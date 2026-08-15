
import 'package:dio/dio.dart';
import '../../../core/network/dio_client.dart';

class DashboardApiService {
  final Dio _dio = DioClient.instance;

  Future<Response> getDashboard() async {
    return await _dio.get('/resident/dashboard');
  }
}