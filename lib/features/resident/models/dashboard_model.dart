
import 'package:equatable/equatable.dart';
import 'announcement_model.dart';

class DashboardModel extends Equatable {
  final double totalPayments;
  final int pendingPayments;
  final int openReports;
  final int activeGroups;
  final List<AnnouncementModel> pinnedAnnouncements;
  final List<ActivityItem> recentActivity;

  const DashboardModel({
    required this.totalPayments,
    required this.pendingPayments,
    required this.openReports,
    required this.activeGroups,
    required this.pinnedAnnouncements,
    required this.recentActivity,
  });

  factory DashboardModel.fromJson(Map<String, dynamic> json) {
    return DashboardModel(
      totalPayments: (json['totalPayments'] as num?)?.toDouble() ?? 0.0,
      pendingPayments: json['pendingPayments'] as int? ?? 0,
      openReports: json['openReports'] as int? ?? 0,
      activeGroups: json['activeGroups'] as int? ?? 0,
      pinnedAnnouncements: (json['pinnedAnnouncements'] as List? ?? [])
          .map((item) => AnnouncementModel.fromJson(item as Map<String, dynamic>))
          .toList(),
      recentActivity: (json['recentActivity'] as List? ?? [])
          .map((item) => ActivityItem.fromJson(item as Map<String, dynamic>))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'totalPayments': totalPayments,
      'pendingPayments': pendingPayments,
      'openReports': openReports,
      'activeGroups': activeGroups,
      'pinnedAnnouncements': pinnedAnnouncements.map((e) => e.toJson()).toList(),
      'recentActivity': recentActivity.map((e) => e.toJson()).toList(),
    };
  }

  @override
  List<Object?> get props => [
        totalPayments,
        pendingPayments,
        openReports,
        activeGroups,
        pinnedAnnouncements,
        recentActivity,
      ];
}

class ActivityItem extends Equatable {
  final String id;
  final String type;
  final String title;
  final String description;
  final String timestamp;
  final String? status;
  final String icon;

  const ActivityItem({
    required this.id,
    required this.type,
    required this.title,
    required this.description,
    required this.timestamp,
    this.status,
    required this.icon,
  });

  factory ActivityItem.fromJson(Map<String, dynamic> json) {
    return ActivityItem(
      id: json['id'] as String? ?? '',
      type: json['type'] as String? ?? '',
      title: json['title'] as String? ?? '',
      description: json['description'] as String? ?? '',
      timestamp: json['timestamp'] as String? ?? '',
      status: json['status'] as String?,
      icon: json['icon'] as String? ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'type': type,
      'title': title,
      'description': description,
      'timestamp': timestamp,
      'status': status,
      'icon': icon,
    };
  }

  @override
  List<Object?> get props => [
        id,
        type,
        title,
        description,
        timestamp,
        status,
        icon,
      ];
}