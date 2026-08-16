
import 'package:equatable/equatable.dart';

class IddirMemberModel extends Equatable {
  final String id;
  final String iddirId;
  final String userId;
  final String status;
  final String joinDate;
  final double? totalPaid;
  final double? totalReceived;
  final String createdAt;
  final String updatedAt;

  const IddirMemberModel({
    required this.id,
    required this.iddirId,
    required this.userId,
    required this.status,
    required this.joinDate,
    this.totalPaid,
    this.totalReceived,
    required this.createdAt,
    required this.updatedAt,
  });

  factory IddirMemberModel.fromJson(Map<String, dynamic> json) {
    return IddirMemberModel(
      id: json['id'] as String? ?? '',
      iddirId: json['iddirId'] as String? ?? '',
      userId: json['userId'] as String? ?? '',
      status: json['status'] as String? ?? '',
      joinDate: json['joinDate'] as String? ?? '',
      totalPaid: (json['totalPaid'] as num?)?.toDouble(),
      totalReceived: (json['totalReceived'] as num?)?.toDouble(),
      createdAt: json['createdAt'] as String? ?? '',
      updatedAt: json['updatedAt'] as String? ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'iddirId': iddirId,
      'userId': userId,
      'status': status,
      'joinDate': joinDate,
      'totalPaid': totalPaid,
      'totalReceived': totalReceived,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
    };
  }

  // Status helpers
  bool get isActive => status == 'active';
  bool get isInactive => status == 'inactive';
  bool get isSuspended => status == 'suspended';

  String get statusLabel {
    switch (status) {
      case 'active':
        return 'Active';
      case 'inactive':
        return 'Inactive';
      case 'suspended':
        return 'Suspended';
      default:
        return status;
    }
  }

  @override
  List<Object?> get props => [
        id,
        iddirId,
        userId,
        status,
        joinDate,
        totalPaid,
        totalReceived,
        createdAt,
        updatedAt,
      ];
}