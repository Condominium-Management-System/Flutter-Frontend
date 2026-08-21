
// ignore_for_file: unnecessary_null_comparison, unused_import

import 'dart:async';
import 'package:dio/dio.dart';
import '../services/token_service.dart';
import '../constants/storage_constant.dart';
import '../di/service_locator.dart';
import '../constants/api_constant.dart';
import '../network/dio_client.dart';

class AuthInterceptor extends QueuedInterceptor {
  TokenService get _tokenService => getIt<TokenService>();
  // Refresh locking to prevent parallel refresh requests
  static bool _isRefreshing = false;
  static Completer<bool>? _refreshCompleter;

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) async {
    // Skip auth header for public endpoints
    if (_isPublicEndpoint(options.path)) {
      handler.next(options);
      return;
    }
    
    final accessToken = await _tokenService.getAccessToken();
    
    if (accessToken != null && accessToken.isNotEmpty) {
      options.headers[ApiConstants.authorization] = 
          '${ApiConstants.bearer} $accessToken';
    }
    
    handler.next(options);
  }
  
  @override
  void onError(DioException err, ErrorInterceptorHandler handler) async {
    // If 401 Unauthorized, try to refresh token (with single-refresh queue)
    if (err.response?.statusCode == 401) {
      final refreshToken = await _tokenService.getRefreshToken();
      if (refreshToken == null || refreshToken.isEmpty) {
        return handler.next(err);
      }

      // If a refresh is already in progress, wait for it
      if (_isRefreshing) {
        final success = await (_refreshCompleter?.future ?? Future.value(false));
        if (!success) return handler.next(err);
      } else {
        // Start refresh
        _isRefreshing = true;
        _refreshCompleter = Completer<bool>();

        final refreshed = await _tokenService.refreshToken();
        _isRefreshing = false;
        _refreshCompleter?.complete(refreshed);

        if (!refreshed) {
          return handler.next(err);
        }
      }

      // At this point a refresh succeeded; retry the original request
      final newToken = await _tokenService.getAccessToken();
      if (newToken != null && newToken.isNotEmpty) {
        final options = err.requestOptions;
        options.headers[ApiConstants.authorization] =
            '${ApiConstants.bearer} $newToken';

        try {
          final dio = DioClient.instance;
          final response = await dio.fetch(options);
          return handler.resolve(response);
        } catch (e) {
          if (e is DioException) return handler.next(e);
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