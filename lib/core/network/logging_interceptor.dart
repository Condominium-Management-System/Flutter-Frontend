
import 'package:dio/dio.dart';
import 'dart:developer';

class LoggingInterceptor extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    log('🌐 REQUEST: ${options.method} ${options.path}');
    log('📦 HEADERS: ${options.headers}');
    if (options.data != null) {
      log('📦 DATA: ${options.data}');
    }
    handler.next(options);
  }
  
  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    log('✅ RESPONSE: ${response.statusCode} ${response.requestOptions.path}');
    if (response.data != null) {
      log('📦 RESPONSE DATA: ${response.data}');
    }
    handler.next(response);
  }
  
  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    log('❌ ERROR: ${err.message}');
    log('❌ ERROR TYPE: ${err.type}');
    if (err.response != null) {
      log('❌ STATUS: ${err.response?.statusCode}');
      log('❌ RESPONSE: ${err.response?.data}');
    }
    handler.next(err);
  }
}