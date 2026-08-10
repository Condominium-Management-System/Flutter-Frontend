
import 'package:equatable/equatable.dart';
import 'user_model.dart';

// Profile Update Request (for multipart/form-data)
class ProfileUpdateRequest {
  final String? fullName;
  final String? phoneNumber;
  final String? profilePhotoPath;
  final String? frontIdPath;
  final String? backIdPath;

  const ProfileUpdateRequest({
    this.fullName,
    this.phoneNumber,
    this.profilePhotoPath,
    this.frontIdPath,
    this.backIdPath,
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
  final UserModel? data;

  const ProfileUpdateResponse({
    required this.success,
    required this.message,
    this.data,
  });

  // Manual fromJson
  factory ProfileUpdateResponse.fromJson(Map<String, dynamic> json) {
    return ProfileUpdateResponse(
      success: json['success'] as bool? ?? false,
      message: json['message'] as String? ?? '',
      data: json['data'] != null
          ? UserModel.fromJson(json['data'] as Map<String, dynamic>)
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