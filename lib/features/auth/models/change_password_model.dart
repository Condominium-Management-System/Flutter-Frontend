
import 'package:equatable/equatable.dart';

// Change Password Request
class ChangePasswordRequest extends Equatable {
  final String oldPassword;
  final String newPassword;

  const ChangePasswordRequest({
    required this.oldPassword,
    required this.newPassword,
  });

  Map<String, dynamic> toJson() {
    return {
      'oldPassword': oldPassword,
      'newPassword': newPassword,
    };
  }

  @override
  List<Object?> get props => [oldPassword, newPassword];
}

// Change Password Response
class ChangePasswordResponse extends Equatable {
  final bool success;
  final String message;
  final dynamic data;

  const ChangePasswordResponse({
    required this.success,
    required this.message,
    this.data,
  });

  // Manual fromJson
  factory ChangePasswordResponse.fromJson(Map<String, dynamic> json) {
    return ChangePasswordResponse(
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