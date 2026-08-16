
import 'package:equatable/equatable.dart';

class NeighborModel extends Equatable {
  final String id;
  final String fullName;
  final String email;
  final String phoneNumber;
  final String? block;
  final String? roomNo;
  final String? profilePhoto;
  final bool isVerified;
  final String createdAt;

  const NeighborModel({
    required this.id,
    required this.fullName,
    required this.email,
    required this.phoneNumber,
    this.block,
    this.roomNo,
    this.profilePhoto,
    this.isVerified = false,
    required this.createdAt,
  });

  factory NeighborModel.fromJson(Map<String, dynamic> json) {
    return NeighborModel(
      id: json['id'] as String? ?? '',
      fullName: json['fullName'] as String? ?? '',
      email: json['email'] as String? ?? '',
      phoneNumber: json['phoneNumber'] as String? ?? '',
      block: json['block'] as String?,
      roomNo: json['roomNo'] as String?,
      profilePhoto: json['profilePhoto'] as String?,
      isVerified: json['isVerified'] as bool? ?? false,
      createdAt: json['createdAt'] as String? ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'fullName': fullName,
      'email': email,
      'phoneNumber': phoneNumber,
      'block': block,
      'roomNo': roomNo,
      'profilePhoto': profilePhoto,
      'isVerified': isVerified,
      'createdAt': createdAt,
    };
  }

  String get unitDisplay {
    if (block != null && roomNo != null) {
      return '$block - $roomNo';
    }
    if (block != null) {
      return 'Block $block';
    }
    if (roomNo != null) {
      return 'Room $roomNo';
    }
    return 'N/A';
  }

  @override
  List<Object?> get props => [
        id,
        fullName,
        email,
        phoneNumber,
        block,
        roomNo,
        profilePhoto,
        isVerified,
        createdAt,
      ];
}