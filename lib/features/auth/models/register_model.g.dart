
class ResetPasswordRequest {
  final String token;
  final String password;

  ResetPasswordRequest({
    required this.token,
    required this.password,
  });

  // Manual fromJson
  factory ResetPasswordRequest.fromJson(Map<String, dynamic> json) {
    return ResetPasswordRequest(
      token: json['token'] as String,
      password: json['password'] as String,
    );
  }

  // Manual toJson
  Map<String, dynamic> toJson() {
    return {
      'token': token,
      'password': password,
    };
  }
}

class ResetPasswordResponse {
  final bool success;
  final String message;
  final dynamic data;

  ResetPasswordResponse({
    required this.success,
    required this.message,
    this.data,
  });

  // Manual fromJson
  factory ResetPasswordResponse.fromJson(Map<String, dynamic> json) {
    return ResetPasswordResponse(
      success: json['success'] as bool,
      message: json['message'] as String,
      data: json['data'],
    );
  }

  // Manual toJson
  Map<String, dynamic> toJson() {
    return {
      'success': success,
      'message': message,
      'data': data,
    };
  }
}