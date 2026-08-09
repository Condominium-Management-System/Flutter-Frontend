
// ignore_for_file: unnecessary_null_comparison, unused_import

import 'package:dio/dio.dart';
import '../services/token_service.dart';
import '../constants/storage_consatnt.dart';
import '../di/service_locator.dart';
import '../constants/api_constant.dart';
import '../network/dio_client.dart';

class AuthInterceptor extends Interceptor {
  TokenService get _tokenService => getIt<TokenService>();
  
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    // Skip auth header for public endpoints
    if (_isPublicEndpoint(options.path)) {
      handler.next(options);
      return;
    }
    
    final accessToken = _tokenService.getAccessToken();
    
    if (accessToken != null) {
      options.headers[ApiConstants.authorization] = 
          '${ApiConstants.bearer} $accessToken';
    }
    
    handler.next(options);
  }
  
  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    // If 401 Unauthorized, try to refresh token
    if (err.response?.statusCode == 401) {
      final refreshed = _tokenService.refreshToken();
      if (refreshed) {
        // Retry the original request with new token
        final newToken = _tokenService.getAccessToken();
        if (newToken != null) {
          final options = err.requestOptions;
          options.headers[ApiConstants.authorization] = 
              '${ApiConstants.bearer} $newToken';
          
          final dio = DioClient.instance;
          dio.fetch(options).then(
            (response) => handler.resolve(response),
            onError: (error) => handler.next(error as DioException),
          );
          return;
        }
      }
    }
    
    handler.next(err);
  }
  
  bool _isPublicEndpoint(String path) {
    final publicEndpoints = [
      ApiConstants.authLogin,
      ApiConstants.authRegister,
      ApiConstants.authRefreshToken,
      ApiConstants.authForgotPassword,
      ApiConstants.authResetPassword,
    ];
    
    return publicEndpoints.any((endpoint) => path.contains(endpoint));
  }
}