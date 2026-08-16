
import 'package:equatable/equatable.dart';

class ProfileUpdateRequest {
  final String? fullName;
  final String? phoneNumber;
  final String? profilePhotoPath;

  const ProfileUpdateRequest({
    this.fullName,
    this.phoneNumber,
    this.profilePhotoPath,
  });

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    if (fullName != null) data['fullName'] = fullName;
    if (phoneNumber != null) data['phoneNumber'] = phoneNumber;
    return data;
  }
}

// Profile Update Response
class ProfileUpdateResponse extends Equatable {
  final bool success;
  final String message;
  final Map<String, dynamic>? data;

  const ProfileUpdateResponse({
    required this.success,
    required this.message,
    this.data,
  });

  factory ProfileUpdateResponse.fromJson(Map<String, dynamic> json) {
    return ProfileUpdateResponse(
      success: json['success'] as bool? ?? false,
      message: json['message'] as String? ?? '',
      data: json['data'] as Map<String, dynamic>?,
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
  final Map<String, dynamic>? data;

  const ChangePasswordResponse({
    required this.success,
    required this.message,
    this.data,
  });

  factory ChangePasswordResponse.fromJson(Map<String, dynamic> json) {
    return ChangePasswordResponse(
      success: json['success'] as bool? ?? false,
      message: json['message'] as String? ?? '',
      data: json['data'] as Map<String, dynamic>?,
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