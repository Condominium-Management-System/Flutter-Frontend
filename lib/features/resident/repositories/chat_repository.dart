
import '../../../core/di/service_locator.dart';
import '../services/chat_api_service.dart';
import '../models/chat_model.dart';
import '../models/message_model.dart';

class ChatRepository {
  final ChatApiService _apiService = getIt<ChatApiService>();

  Future<List<ChatModel>> getChatList() async {
    try {
      final response = await _apiService.getChatList();
      if (response.data != null && response.data is Map<String, dynamic>) {
        final data = response.data as Map<String, dynamic>;
        final chatData = data['data'] as List? ?? [];
        return chatData
            .map((item) => ChatModel.fromJson(item as Map<String, dynamic>))
            .toList();
      }
      return [];
    } catch (_) {
      return [];
    }
  }

  Future<List<MessageModel>> getChatMessages(String chatId, {int page = 1}) async {
    try {
      final response = await _apiService.getChatMessages(chatId, page: page);
      if (response.data == null) {
        return [];
      }
      final data = response.data as Map<String, dynamic>;
      final messagesData = data['data'] as List? ?? [];
      return messagesData
          .map((item) => MessageModel.fromJson(item as Map<String, dynamic>))
          .toList();
    } catch (e) {
      rethrow;
    }
  }

  Future<MessageModel> sendMessage({
    required String chatId,
    required String content,
    String? type,
  }) async {
    try {
      final response = await _apiService.sendMessage(
        chatId: chatId,
        content: content,
        type: type,
      );
      if (response.data == null) {
        throw Exception('No data received');
      }
      final data = response.data as Map<String, dynamic>;
      return MessageModel.fromJson(data['data'] ?? {});
    } catch (e) {
      rethrow;
    }
  }

  Future<bool> markAsRead(String messageId) async {
    try {
      final response = await _apiService.markAsRead(messageId);
      return response.data != null && response.statusCode == 200;
    } catch (e) {
      rethrow;
    }
  }

  Future<int> getUnreadCount() async {
    try {
      final response = await _apiService.getUnreadCount();
      if (response.data != null && response.data is Map<String, dynamic>) {
        final data = response.data as Map<String, dynamic>;
        return data['data']?['count'] as int? ?? 0;
      }
    } catch (_) {}
    return 0;
  }
}