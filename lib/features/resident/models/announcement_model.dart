
import 'package:equatable/equatable.dart';

class AnnouncementModel extends Equatable {
  final String id;
  final String condoId;
  final String title;
  final String body;
  final String announcementType;
  final String? expiryDate;
  final bool isPinned;
  final String createdBy;
  final String createdByRole;
  final String? imageUrl;
  final bool isPublic;
  final String createdAt;
  final String updatedAt;

  const AnnouncementModel({
    required this.id,
    required this.condoId,
    required this.title,
    required this.body,
    required this.announcementType,
    this.expiryDate,
    this.isPinned = false,
    required this.createdBy,
    required this.createdByRole,
    this.imageUrl,
    this.isPublic = true,
    required this.createdAt,
    required this.updatedAt,
  });

  factory AnnouncementModel.fromJson(Map<String, dynamic> json) {
    return AnnouncementModel(
      id: json['id'] as String? ?? '',
      condoId: json['condoId'] as String? ?? '',
      title: json['title'] as String? ?? '',
      body: json['body'] as String? ?? '',
      announcementType: json['announcementType'] as String? ?? '',
      expiryDate: json['expiryDate'] as String?,
      isPinned: json['isPinned'] as bool? ?? false,
      createdBy: json['createdBy'] as String? ?? '',
      createdByRole: json['createdByRole'] as String? ?? '',
      imageUrl: json['imageUrl'] as String?,
      isPublic: json['isPublic'] as bool? ?? true,
      createdAt: json['createdAt'] as String? ?? '',
      updatedAt: json['updatedAt'] as String? ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'condoId': condoId,
      'title': title,
      'body': body,
      'announcementType': announcementType,
      'expiryDate': expiryDate,
      'isPinned': isPinned,
      'createdBy': createdBy,
      'createdByRole': createdByRole,
      'imageUrl': imageUrl,
      'isPublic': isPublic,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
    };
  }

  // Announcement Type helpers
  String get typeLabel {
    switch (announcementType) {
      case 'general':
        return 'General';
      case 'shop_alert':
        return 'Shop Alert';
      case 'emergency':
        return 'Emergency';
      case 'event':
        return 'Event';
      case 'mourning':
        return 'Mourning';
      case 'celebration':
        return 'Celebration';
      default:
        return announcementType;
    }
  }

  bool get isEmergency => announcementType == 'emergency';

  @override
  List<Object?> get props => [
        id,
        condoId,
        title,
        body,
        announcementType,
        expiryDate,
        isPinned,
        createdBy,
        createdByRole,
        imageUrl,
        isPublic,
        createdAt,
        updatedAt,
      ];
}