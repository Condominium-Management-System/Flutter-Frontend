
import 'package:equatable/equatable.dart';

// Forgot Password Request
class ForgotPasswordRequest extends Equatable {
  final String email;

  const ForgotPasswordRequest({
    required this.email,
  });

  Map<String, dynamic> toJson() {
    return {
      'email': email,
    };
  }

  @override
  List<Object?> get props => [email];
}

// Forgot Password Response
class ForgotPasswordResponse extends Equatable {
  final bool success;
  final String message;
  final String? resetToken;

  const ForgotPasswordResponse({
    required this.success,
    required this.message,
    this.resetToken,
  });

  // Manual fromJson
  factory ForgotPasswordResponse.fromJson(Map<String, dynamic> json) {
    return ForgotPasswordResponse(
      success: json['success'] as bool? ?? false,
      message: json['message'] as String? ?? '',
      resetToken: json['resetToken'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'success': success,
      'message': message,
      'resetToken': resetToken,
    };
  }

  @override
  List<Object?> get props => [success, message, resetToken];
}