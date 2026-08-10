
import 'package:equatable/equatable.dart';

// Register Request
class RegisterRequest extends Equatable {
  final String fullName;
  final String email;
  final String phoneNumber;
  final String fan;
  final String password;
  final String condoCode;

  const RegisterRequest({
    required this.fullName,
    required this.email,
    required this.phoneNumber,
    required this.fan,
    required this.password,
    required this.condoCode,
  });

  Map<String, dynamic> toJson() {
    return {
      'fullName': fullName,
      'email': email,
      'phoneNumber': phoneNumber,
      'fan': fan,
      'password': password,
      'condoCode': condoCode,
    };
  }

  @override
  List<Object?> get props => [
        fullName,
        email,
        phoneNumber,
        fan,
        password,
        condoCode,
      ];
}

// Register Response
class RegisterResponse extends Equatable {
  final bool success;
  final String message;
  final RegisterData? data;

  const RegisterResponse({
    required this.success,
    required this.message,
    this.data,
  });

  // Manual fromJson
  factory RegisterResponse.fromJson(Map<String, dynamic> json) {
    return RegisterResponse(
      success: json['success'] as bool? ?? false,
      message: json['message'] as String? ?? '',
      data: json['data'] != null
          ? RegisterData.fromJson(json['data'] as Map<String, dynamic>)
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'success': success,
      'message': message,
      'data': data?.toJson(),
    };
  }

  @override
  List<Object?> get props => [success, message, data];
}

// Register Data
class RegisterData extends Equatable {
  final String id;
  final String fullName;
  final String email;
  final String role;
  final String accessToken;
  final String refreshToken;

  const RegisterData({
    required this.id,
    required this.fullName,
    required this.email,
    required this.role,
    required this.accessToken,
    required this.refreshToken,
  });

  // Manual fromJson
  factory RegisterData.fromJson(Map<String, dynamic> json) {
    return RegisterData(
      id: json['id'] as String? ?? '',
      fullName: json['fullName'] as String? ?? '',
      email: json['email'] as String? ?? '',
      role: json['role'] as String? ?? 'resident',
      accessToken: json['accessToken'] as String? ?? '',
      refreshToken: json['refreshToken'] as String? ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'fullName': fullName,
      'email': email,
      'role': role,
      'accessToken': accessToken,
      'refreshToken': refreshToken,
    };
  }

  @override
  List<Object?> get props => [
        id,
        fullName,
        email,
        role,
        accessToken,
        refreshToken,
      ];
}