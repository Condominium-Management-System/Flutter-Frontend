
import 'package:dio/dio.dart';
import '../constants/api_constant.dart';
import 'auth_interceptor.dart';
import 'error_interceptor.dart';
import 'logging_interceptor.dart';

class DioClient {
  static Dio? _instance;
  
  static Dio get instance {
    _instance ??= _createDio();
    return _instance!;
  }
  
  static Dio _createDio() {
    final dio = Dio(
      BaseOptions(
        baseUrl: ApiConstants.baseUrl,
        connectTimeout: ApiConstants.connectTimeout,
        receiveTimeout: ApiConstants.receiveTimeout,
        sendTimeout: ApiConstants.sendTimeout,
        headers: {
          ApiConstants.contentType: ApiConstants.applicationJson,
          ApiConstants.accept: ApiConstants.applicationJson,
        },
        validateStatus: (status) {
          // Accept all status codes for custom handling
          return status != null && status >= 200 && status < 500;
        },
      ),
    );
    
    // Add interceptors
    dio.interceptors.add(AuthInterceptor());
    dio.interceptors.add(ErrorInterceptor());
    dio.interceptors.add(LoggingInterceptor());
    
    return dio;
  }
  
  static void reset() {
    _instance = null;
  }
}