
import 'package:equatable/equatable.dart';

class NotificationModel extends Equatable {
  final String id;
  final String userId;
  final String type;
  final String title;
  final String body;
  final Map<String, dynamic>? data;
  final bool isRead;
  final String? readAt;
  final String createdAt;
  final String updatedAt;

  const NotificationModel({
    required this.id,
    required this.userId,
    required this.type,
    required this.title,
    required this.body,
    this.data,
    this.isRead = false,
    this.readAt,
    required this.createdAt,
    required this.updatedAt,
  });

  factory NotificationModel.fromJson(Map<String, dynamic> json) {
    return NotificationModel(
      id: json['id'] as String? ?? '',
      userId: json['userId'] as String? ?? '',
      type: json['type'] as String? ?? '',
      title: json['title'] as String? ?? '',
      body: json['body'] as String? ?? '',
      data: json['data'] as Map<String, dynamic>?,
      isRead: json['isRead'] as bool? ?? false,
      readAt: json['readAt'] as String?,
      createdAt: json['createdAt'] as String? ?? '',
      updatedAt: json['updatedAt'] as String? ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'userId': userId,
      'type': type,
      'title': title,
      'body': body,
      'data': data,
      'isRead': isRead,
      'readAt': readAt,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
    };
  }

  // Type label
  String get typeLabel {
    switch (type) {
      case 'payment':
        return 'Payment';
      case 'announcement':
        return 'Announcement';
      case 'report':
        return 'Report';
      case 'equb':
        return 'Equb';
      case 'iddir':
        return 'Iddir';
      case 'lost_found':
        return 'Lost & Found';
      case 'system':
        return 'System';
      default:
        return type;
    }
  }

  // Type icon
  String get typeIcon {
    switch (type) {
      case 'payment':
        return '💰';
      case 'announcement':
        return '📢';
      case 'report':
        return '📋';
      case 'equb':
        return '💵';
      case 'iddir':
        return '🕊️';
      case 'lost_found':
        return '🔍';
      case 'system':
        return '⚙️';
      default:
        return '📌';
    }
  }

  @override
  List<Object?> get props => [
        id,
        userId,
        type,
        title,
        body,
        data,
        isRead,
        readAt,
        createdAt,
        updatedAt,
      ];
}