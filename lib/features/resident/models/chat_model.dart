
import 'package:equatable/equatable.dart';

class ChatModel extends Equatable {
  final String id;
  final String condoId;
  final String senderId;
  final String receiverId;
  final String type;
  final String content;
  final bool isRead;
  final String? readAt;
  final String? editedAt;
  final String? deletedAt;
  final String createdAt;

  const ChatModel({
    required this.id,
    required this.condoId,
    required this.senderId,
    required this.receiverId,
    required this.type,
    required this.content,
    this.isRead = false,
    this.readAt,
    this.editedAt,
    this.deletedAt,
    required this.createdAt,
  });

  factory ChatModel.fromJson(Map<String, dynamic> json) {
    return ChatModel(
      id: json['id'] as String? ?? '',
      condoId: json['condoId'] as String? ?? '',
      senderId: json['senderId'] as String? ?? '',
      receiverId: json['receiverId'] as String? ?? '',
      type: json['type'] as String? ?? '',
      content: json['content'] as String? ?? '',
      isRead: json['isRead'] as bool? ?? false,
      readAt: json['readAt'] as String?,
      editedAt: json['editedAt'] as String?,
      deletedAt: json['deletedAt'] as String?,
      createdAt: json['createdAt'] as String? ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'condoId': condoId,
      'senderId': senderId,
      'receiverId': receiverId,
      'type': type,
      'content': content,
      'isRead': isRead,
      'readAt': readAt,
      'editedAt': editedAt,
      'deletedAt': deletedAt,
      'createdAt': createdAt,
    };
  }

  // Type helpers
  bool get isMessage => type == 'message';
  bool get isPhoto => type == 'photo';
  bool get isFile => type == 'file';

  bool get isSentByMe {
    return false;
  }

  @override
  List<Object?> get props => [
        id,
        condoId,
        senderId,
        receiverId,
        type,
        content,
        isRead,
        readAt,
        editedAt,
        deletedAt,
        createdAt,
      ];
}