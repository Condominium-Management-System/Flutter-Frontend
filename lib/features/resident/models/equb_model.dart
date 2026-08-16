
import 'package:equatable/equatable.dart';
import 'equb_member_model.dart';

class EqubModel extends Equatable {
  final String id;
  final String condoId;
  final String createdBy;
  final String name;
  final int noMembers;
  final String status;
  final String startDate;
  final String dueDate;
  final double contributionAmount;
  final List<EqubMemberModel> members;
  final String createdAt;
  final String updatedAt;

  const EqubModel({
    required this.id,
    required this.condoId,
    required this.createdBy,
    required this.name,
    required this.noMembers,
    required this.status,
    required this.startDate,
    required this.dueDate,
    required this.contributionAmount,
    this.members = const [],
    required this.createdAt,
    required this.updatedAt,
  });

  factory EqubModel.fromJson(Map<String, dynamic> json) {
    return EqubModel(
      id: json['id'] as String? ?? '',
      condoId: json['condoId'] as String? ?? '',
      createdBy: json['createdBy'] as String? ?? '',
      name: json['name'] as String? ?? '',
      noMembers: json['noMembers'] as int? ?? 0,
      status: json['status'] as String? ?? '',
      startDate: json['startDate'] as String? ?? '',
      dueDate: json['dueDate'] as String? ?? '',
      contributionAmount: (json['contributionAmount'] as num?)?.toDouble() ?? 0.0,
      members: (json['members'] as List? ?? [])
          .map((item) => EqubMemberModel.fromJson(item as Map<String, dynamic>))
          .toList(),
      createdAt: json['createdAt'] as String? ?? '',
      updatedAt: json['updatedAt'] as String? ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'condoId': condoId,
      'createdBy': createdBy,
      'name': name,
      'noMembers': noMembers,
      'status': status,
      'startDate': startDate,
      'dueDate': dueDate,
      'contributionAmount': contributionAmount,
      'members': members.map((e) => e.toJson()).toList(),
      'createdAt': createdAt,
      'updatedAt': updatedAt,
    };
  }

  // Status helpers
  bool get isPending => status == 'pending';
  bool get isActive => status == 'active';
  bool get isCompleted => status == 'completed';
  bool get isCancelled => status == 'cancelled';

  String get statusLabel {
    switch (status) {
      case 'pending':
        return 'Pending';
      case 'active':
        return 'Active';
      case 'completed':
        return 'Completed';
      case 'cancelled':
        return 'Cancelled';
      default:
        return status;
    }
  }

  // Progress calculation
  double get progress {
    if (noMembers == 0) return 0.0;
    final activeMembers = members.where((m) => m.status == 'active').length;
    return activeMembers / noMembers;
  }

  bool get isMember {
    // This will be checked by the repository with current user
    return false;
  }

  @override
  List<Object?> get props => [
        id,
        condoId,
        createdBy,
        name,
        noMembers,
        status,
        startDate,
        dueDate,
        contributionAmount,
        members,
        createdAt,
        updatedAt,
      ];
}