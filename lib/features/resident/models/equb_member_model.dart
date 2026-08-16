
import 'package:equatable/equatable.dart';

class EqubMemberModel extends Equatable {
  final String id;
  final String equbId;
  final String userId;
  final String status;
  final String joinDate;
  final double? totalPaid;
  final bool hasReceivedPayout;
  final String createdAt;
  final String updatedAt;

  const EqubMemberModel({
    required this.id,
    required this.equbId,
    required this.userId,
    required this.status,
    required this.joinDate,
    this.totalPaid,
    this.hasReceivedPayout = false,
    required this.createdAt,
    required this.updatedAt,
  });

  factory EqubMemberModel.fromJson(Map<String, dynamic> json) {
    return EqubMemberModel(
      id: json['id'] as String? ?? '',
      equbId: json['equbId'] as String? ?? '',
      userId: json['userId'] as String? ?? '',
      status: json['status'] as String? ?? '',
      joinDate: json['joinDate'] as String? ?? '',
      totalPaid: (json['totalPaid'] as num?)?.toDouble(),
      hasReceivedPayout: json['hasReceivedPayout'] as bool? ?? false,
      createdAt: json['createdAt'] as String? ?? '',
      updatedAt: json['updatedAt'] as String? ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'equbId': equbId,
      'userId': userId,
      'status': status,
      'joinDate': joinDate,
      'totalPaid': totalPaid,
      'hasReceivedPayout': hasReceivedPayout,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
    };
  }

  // Status helpers
  bool get isActive => status == 'active';
  bool get isInactive => status == 'inactive';
  bool get isSuspended => status == 'suspended';
  bool get isWinner => status == 'winner';

  String get statusLabel {
    switch (status) {
      case 'active':
        return 'Active';
      case 'inactive':
        return 'Inactive';
      case 'suspended':
        return 'Suspended';
      case 'winner':
        return 'Winner';
      default:
        return status;
    }
  }

  @override
  List<Object?> get props => [
        id,
        equbId,
        userId,
        status,
        joinDate,
        totalPaid,
        hasReceivedPayout,
        createdAt,
        updatedAt,
      ];
}