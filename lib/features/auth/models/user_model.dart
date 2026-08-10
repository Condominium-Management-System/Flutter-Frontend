
import 'dart:convert';
import 'package:equatable/equatable.dart';

class UserModel extends Equatable {
  final String id;
  final String fullName;
  final String email;
  final String phoneNumber;
  final String role;
  final String? condoId;
  final String? block;
  final String? roomNo;
  final bool isVerified;
  final String? profilePhoto;
  final String? fan;
  final double? revenue;
  final bool isInIddir;
  final bool isInEqub;
  final bool isGetEqub;
  final String? registerDate;
  final String? dueDate;
  final String? frontId;
  final String? backId;
  final String? createdAt;
  final String? updatedAt;

  const UserModel({
    required this.id,
    required this.fullName,
    required this.email,
    required this.phoneNumber,
    required this.role,
    this.condoId,
    this.block,
    this.roomNo,
    this.isVerified = false,
    this.profilePhoto,
    this.fan,
    this.revenue,
    this.isInIddir = false,
    this.isInEqub = false,
    this.isGetEqub = false,
    this.registerDate,
    this.dueDate,
    this.frontId,
    this.backId,
    this.createdAt,
    this.updatedAt,
  });

  // Manual fromJson
  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'] as String? ?? '',
      fullName: json['fullName'] as String? ?? '',
      email: json['email'] as String? ?? '',
      phoneNumber: json['phoneNumber'] as String? ?? '',
      role: json['role'] as String? ?? 'resident',
      condoId: json['condoId'] as String?,
      block: json['block'] as String?,
      roomNo: json['roomNo'] as String?,
      isVerified: json['isVerified'] as bool? ?? false,
      profilePhoto: json['profilePhoto'] as String?,
      fan: json['fan'] as String?,
      revenue: (json['revenue'] as num?)?.toDouble(),
      isInIddir: json['isInIddir'] as bool? ?? false,
      isInEqub: json['isInEqub'] as bool? ?? false,
      isGetEqub: json['isGetEqub'] as bool? ?? false,
      registerDate: json['registerDate'] as String?,
      dueDate: json['dueDate'] as String?,
      frontId: json['frontId'] as String?,
      backId: json['backId'] as String?,
      createdAt: json['createdAt'] as String?,
      updatedAt: json['updatedAt'] as String?,
    );
  }

  // Manual toJson
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'fullName': fullName,
      'email': email,
      'phoneNumber': phoneNumber,
      'role': role,
      'condoId': condoId,
      'block': block,
      'roomNo': roomNo,
      'isVerified': isVerified,
      'profilePhoto': profilePhoto,
      'fan': fan,
      'revenue': revenue,
      'isInIddir': isInIddir,
      'isInEqub': isInEqub,
      'isGetEqub': isGetEqub,
      'registerDate': registerDate,
      'dueDate': dueDate,
      'frontId': frontId,
      'backId': backId,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
    };
  }

  // Helper: Convert to JSON string
  String toJsonString() => jsonEncode(toJson());

  // Helper: Create from JSON string
  static UserModel fromJsonString(String jsonString) {
    final Map<String, dynamic> json = jsonDecode(jsonString);
    return UserModel.fromJson(json);
  }

  // Copy with method
  UserModel copyWith({
    String? id,
    String? fullName,
    String? email,
    String? phoneNumber,
    String? role,
    String? condoId,
    String? block,
    String? roomNo,
    bool? isVerified,
    String? profilePhoto,
    String? fan,
    double? revenue,
    bool? isInIddir,
    bool? isInEqub,
    bool? isGetEqub,
    String? registerDate,
    String? dueDate,
    String? frontId,
    String? backId,
    String? createdAt,
    String? updatedAt,
  }) {
    return UserModel(
      id: id ?? this.id,
      fullName: fullName ?? this.fullName,
      email: email ?? this.email,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      role: role ?? this.role,
      condoId: condoId ?? this.condoId,
      block: block ?? this.block,
      roomNo: roomNo ?? this.roomNo,
      isVerified: isVerified ?? this.isVerified,
      profilePhoto: profilePhoto ?? this.profilePhoto,
      fan: fan ?? this.fan,
      revenue: revenue ?? this.revenue,
      isInIddir: isInIddir ?? this.isInIddir,
      isInEqub: isInEqub ?? this.isInEqub,
      isGetEqub: isGetEqub ?? this.isGetEqub,
      registerDate: registerDate ?? this.registerDate,
      dueDate: dueDate ?? this.dueDate,
      frontId: frontId ?? this.frontId,
      backId: backId ?? this.backId,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  @override
  List<Object?> get props => [
        id,
        fullName,
        email,
        phoneNumber,
        role,
        condoId,
        block,
        roomNo,
        isVerified,
        profilePhoto,
        fan,
        revenue,
        isInIddir,
        isInEqub,
        isGetEqub,
        registerDate,
        dueDate,
        frontId,
        backId,
        createdAt,
        updatedAt,
      ];
}