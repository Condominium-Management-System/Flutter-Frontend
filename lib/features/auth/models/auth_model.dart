
import 'package:equatable/equatable.dart';

// Base API Response
class ApiResponse<T> extends Equatable {
  final bool success;
  final String message;
  final T? data;
  final dynamic errors;

  const ApiResponse({
    required this.success,
    required this.message,
    this.data,
    this.errors,
  });

  factory ApiResponse.fromJson(
    Map<String, dynamic> json,
    T Function(Map<String, dynamic>) fromJsonT,
  ) {
    return ApiResponse<T>(
      success: json['success'] as bool? ?? false,
      message: json['message'] as String? ?? '',
      data: json['data'] != null ? fromJsonT(json['data']) : null,
      errors: json['errors'],
    );
  }

  @override
  List<Object?> get props => [success, message, data, errors];
}

// Auth Status Enum
enum AuthStatus {
  initial,
  loading,
  authenticated,
  unauthenticated,
  error,
}

// Auth Role Enum
enum UserRole {
  resident,
  guard,
  condoAdmin,
  superAdmin,
}

extension UserRoleExtension on UserRole {
  String get value {
    switch (this) {
      case UserRole.resident:
        return 'resident';
      case UserRole.guard:
        return 'guard';
      case UserRole.condoAdmin:
        return 'condo_admin';
      case UserRole.superAdmin:
        return 'super_admin';
    }
  }

  static UserRole fromString(String value) {
    switch (value) {
      case 'resident':
        return UserRole.resident;
      case 'guard':
        return UserRole.guard;
      case 'condo_admin':
        return UserRole.condoAdmin;
      case 'super_admin':
        return UserRole.superAdmin;
      default:
        return UserRole.resident;
    }
  }
}