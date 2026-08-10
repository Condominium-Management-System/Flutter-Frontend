
import 'package:equatable/equatable.dart';

// Reset Password Request
class ResetPasswordRequest extends Equatable {
  final String token;
  final String password;

  const ResetPasswordRequest({
    required this.token,
    required this.password,
  });

  Map<String, dynamic> toJson() {
    return {
      'token': token,
      'password': password,
    };
  }

  @override
  List<Object?> get props => [token, password];
}

// Reset Password Response
class ResetPasswordResponse extends Equatable {
  final bool success;
  final String message;
  final dynamic data;

  const ResetPasswordResponse({
    required this.success,
    required this.message,
    this.data,
  });

  // Manual fromJson
  factory ResetPasswordResponse.fromJson(Map<String, dynamic> json) {
    return ResetPasswordResponse(
      success: json['success'] as bool? ?? false,
      message: json['message'] as String? ?? '',
      data: json['data'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'success': success,
      'message': message,
      'data': data,
    };
  }

  @override
  List<Object?> get props => [success, message, data];
}