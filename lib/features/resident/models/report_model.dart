
import 'package:equatable/equatable.dart';

class ReportModel extends Equatable {
  final String id;
  final String condoId;
  final String title;
  final String description;
  final String category;
  final String? photoUrl;
  final String status;
  final String reporterId;
  final String reporterRole;
  final String priority;
  final String? assignedTo;
  final String? resolvedAt;
  final String? resolutionNotes;
  final String createdAt;
  final String updatedAt;

  const ReportModel({
    required this.id,
    required this.condoId,
    required this.title,
    required this.description,
    required this.category,
    this.photoUrl,
    required this.status,
    required this.reporterId,
    required this.reporterRole,
    required this.priority,
    this.assignedTo,
    this.resolvedAt,
    this.resolutionNotes,
    required this.createdAt,
    required this.updatedAt,
  });

  factory ReportModel.fromJson(Map<String, dynamic> json) {
    return ReportModel(
      id: json['id'] as String? ?? '',
      condoId: json['condoId'] as String? ?? '',
      title: json['title'] as String? ?? '',
      description: json['description'] as String? ?? '',
      category: json['category'] as String? ?? '',
      photoUrl: json['photoUrl'] as String?,
      status: json['status'] as String? ?? '',
      reporterId: json['reporterId'] as String? ?? '',
      reporterRole: json['reporterRole'] as String? ?? '',
      priority: json['priority'] as String? ?? '',
      assignedTo: json['assignedTo'] as String?,
      resolvedAt: json['resolvedAt'] as String?,
      resolutionNotes: json['resolutionNotes'] as String?,
      createdAt: json['createdAt'] as String? ?? '',
      updatedAt: json['updatedAt'] as String? ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'condoId': condoId,
      'title': title,
      'description': description,
      'category': category,
      'photoUrl': photoUrl,
      'status': status,
      'reporterId': reporterId,
      'reporterRole': reporterRole,
      'priority': priority,
      'assignedTo': assignedTo,
      'resolvedAt': resolvedAt,
      'resolutionNotes': resolutionNotes,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
    };
  }

  // Category label
  String get categoryLabel {
    switch (category) {
      case 'plumbing':
        return 'Plumbing';
      case 'electrical':
        return 'Electrical';
      case 'structural':
        return 'Structural';
      case 'security':
        return 'Security';
      case 'noise':
        return 'Noise';
      case 'other':
        return 'Other';
      default:
        return category;
    }
  }

  // Priority label and color
  String get priorityLabel {
    switch (priority) {
      case 'low':
        return 'Low';
      case 'medium':
        return 'Medium';
      case 'high':
        return 'High';
      case 'emergency':
        return 'Emergency';
      default:
        return priority;
    }
  }

  // Status helpers
  bool get isReported => status == 'reported';
  bool get isAssigned => status == 'assigned';
  bool get isInProgress => status == 'in_progress';
  bool get isResolved => status == 'resolved';
  bool get isClosed => status == 'closed';

  String get statusLabel {
    switch (status) {
      case 'reported':
        return 'Reported';
      case 'assigned':
        return 'Assigned';
      case 'in_progress':
        return 'In Progress';
      case 'resolved':
        return 'Resolved';
      case 'closed':
        return 'Closed';
      default:
        return status;
    }
  }

  @override
  List<Object?> get props => [
        id,
        condoId,
        title,
        description,
        category,
        photoUrl,
        status,
        reporterId,
        reporterRole,
        priority,
        assignedTo,
        resolvedAt,
        resolutionNotes,
        createdAt,
        updatedAt,
      ];
}