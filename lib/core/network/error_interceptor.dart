
import 'package:dio/dio.dart';
import 'network_exceptions.dart';

class ErrorInterceptor extends Interceptor {
  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    final errorMessage = NetworkExceptions.getErrorMessage(err);
    
    // Create a new error with custom message
    final error = DioException(
      requestOptions: err.requestOptions,
      response: err.response,
      type: err.type,
      error: errorMessage,
    );
    
    handler.next(error);
  }
}