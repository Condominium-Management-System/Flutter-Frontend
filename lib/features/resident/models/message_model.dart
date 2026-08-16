
import 'package:equatable/equatable.dart';

class MessageModel extends Equatable {
  final String id;
  final String chatId;
  final String senderId;
  final String content;
  final String type;
  final String timestamp;
  final bool isRead;
  final String? readAt;
  final String? editedAt;
  final String? deletedAt;

  const MessageModel({
    required this.id,
    required this.chatId,
    required this.senderId,
    required this.content,
    required this.type,
    required this.timestamp,
    this.isRead = false,
    this.readAt,
    this.editedAt,
    this.deletedAt,
  });

  factory MessageModel.fromJson(Map<String, dynamic> json) {
    return MessageModel(
      id: json['id'] as String? ?? '',
      chatId: json['chatId'] as String? ?? '',
      senderId: json['senderId'] as String? ?? '',
      content: json['content'] as String? ?? '',
      type: json['type'] as String? ?? '',
      timestamp: json['timestamp'] as String? ?? '',
      isRead: json['isRead'] as bool? ?? false,
      readAt: json['readAt'] as String?,
      editedAt: json['editedAt'] as String?,
      deletedAt: json['deletedAt'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'chatId': chatId,
      'senderId': senderId,
      'content': content,
      'type': type,
      'timestamp': timestamp,
      'isRead': isRead,
      'readAt': readAt,
      'editedAt': editedAt,
      'deletedAt': deletedAt,
    };
  }

  // Type helpers
  bool get isText => type == 'text';
  bool get isImage => type == 'image';
  bool get isFile => type == 'file';

  bool get isSentByMe {
    // This will be checked by the repository with current user
    return false;
  }

  @override
  List<Object?> get props => [
        id,
        chatId,
        senderId,
        content,
        type,
        timestamp,
        isRead,
        readAt,
        editedAt,
        deletedAt,
      ];
}