
import 'package:equatable/equatable.dart';

class LostFoundModel extends Equatable {
  final String id;
  final String condoId;
  final String type;
  final String userId;
  final String itemName;
  final String description;
  final String category;
  final String? photoUrl;
  final String? location;
  final String dateLostFound;
  final String status;
  final String? claimedBy;
  final bool claimVerified;
  final String? verifiedBy;
  final String createdAt;
  final String updatedAt;

  const LostFoundModel({
    required this.id,
    required this.condoId,
    required this.type,
    required this.userId,
    required this.itemName,
    required this.description,
    required this.category,
    this.photoUrl,
    this.location,
    required this.dateLostFound,
    required this.status,
    this.claimedBy,
    this.claimVerified = false,
    this.verifiedBy,
    required this.createdAt,
    required this.updatedAt,
  });

  factory LostFoundModel.fromJson(Map<String, dynamic> json) {
    return LostFoundModel(
      id: json['id'] as String? ?? '',
      condoId: json['condoId'] as String? ?? '',
      type: json['type'] as String? ?? '',
      userId: json['userId'] as String? ?? '',
      itemName: json['itemName'] as String? ?? '',
      description: json['description'] as String? ?? '',
      category: json['category'] as String? ?? '',
      photoUrl: json['photoUrl'] as String?,
      location: json['location'] as String?,
      dateLostFound: json['dateLostFound'] as String? ?? '',
      status: json['status'] as String? ?? '',
      claimedBy: json['claimedBy'] as String?,
      claimVerified: json['claimVerified'] as bool? ?? false,
      verifiedBy: json['verifiedBy'] as String?,
      createdAt: json['createdAt'] as String? ?? '',
      updatedAt: json['updatedAt'] as String? ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'condoId': condoId,
      'type': type,
      'userId': userId,
      'itemName': itemName,
      'description': description,
      'category': category,
      'photoUrl': photoUrl,
      'location': location,
      'dateLostFound': dateLostFound,
      'status': status,
      'claimedBy': claimedBy,
      'claimVerified': claimVerified,
      'verifiedBy': verifiedBy,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
    };
  }

  // Type helpers
  bool get isLost => type == 'lost';
  bool get isFound => type == 'found';

  String get typeLabel => type == 'lost' ? 'Lost' : 'Found';

  // Status helpers
  bool get isOpen => status == 'open';
  bool get isMatched => status == 'matched';
  bool get isClaimed => status == 'claimed';
  bool get isArchived => status == 'archived';

  String get statusLabel {
    switch (status) {
      case 'open':
        return 'Open';
      case 'matched':
        return 'Matched';
      case 'claimed':
        return 'Claimed';
      case 'archived':
        return 'Archived';
      default:
        return status;
    }
  }

  // Category label
  String get categoryLabel {
    switch (category) {
      case 'electronics':
        return 'Electronics';
      case 'documents':
        return 'Documents';
      case 'keys':
        return 'Keys';
      case 'clothing':
        return 'Clothing';
      case 'jewelry':
        return 'Jewelry';
      case 'other':
        return 'Other';
      default:
        return category;
    }
  }

  @override
  List<Object?> get props => [
        id,
        condoId,
        type,
        userId,
        itemName,
        description,
        category,
        photoUrl,
        location,
        dateLostFound,
        status,
        claimedBy,
        claimVerified,
        verifiedBy,
        createdAt,
        updatedAt,
      ];
}