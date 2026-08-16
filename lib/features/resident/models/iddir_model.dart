
import 'package:equatable/equatable.dart';
import 'iddir_member_model.dart';

class IddirModel extends Equatable {
  final String id;
  final String condoId;
  final String createdBy;
  final String name;
  final int noMembers;
  final bool status;
  final String startedDate;
  final double contributionAmount;
  final List<IddirMemberModel> members;
  final String createdAt;
  final String updatedAt;

  const IddirModel({
    required this.id,
    required this.condoId,
    required this.createdBy,
    required this.name,
    required this.noMembers,
    required this.status,
    required this.startedDate,
    required this.contributionAmount,
    this.members = const [],
    required this.createdAt,
    required this.updatedAt,
  });

  factory IddirModel.fromJson(Map<String, dynamic> json) {
    return IddirModel(
      id: json['id'] as String? ?? '',
      condoId: json['condoId'] as String? ?? '',
      createdBy: json['createdBy'] as String? ?? '',
      name: json['name'] as String? ?? '',
      noMembers: json['noMembers'] as int? ?? 0,
      status: json['status'] as bool? ?? false,
      startedDate: json['startedDate'] as String? ?? '',
      contributionAmount: (json['contributionAmount'] as num?)?.toDouble() ?? 0.0,
      members: (json['members'] as List? ?? [])
          .map((item) => IddirMemberModel.fromJson(item as Map<String, dynamic>))
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
      'startedDate': startedDate,
      'contributionAmount': contributionAmount,
      'members': members.map((e) => e.toJson()).toList(),
      'createdAt': createdAt,
      'updatedAt': updatedAt,
    };
  }

  bool get isActive => status;
  bool get isInactive => !status;

  String get statusLabel => status ? 'Active' : 'Inactive';

  @override
  List<Object?> get props => [
        id,
        condoId,
        createdBy,
        name,
        noMembers,
        status,
        startedDate,
        contributionAmount,
        members,
        createdAt,
        updatedAt,
      ];
}