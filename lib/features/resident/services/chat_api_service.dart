
import 'package:dio/dio.dart';
import '../../../core/network/dio_client.dart';

class ChatApiService {
  final Dio _dio = DioClient.instance;

  // Get chat list
  Future<Response> getChatList() async {
    return await _dio.get('/resident/chat');
  }

  // Get chat messages
  Future<Response> getChatMessages(String chatId, {int page = 1}) async {
    return await _dio.get(
      '/resident/chat/$chatId',
      queryParameters: {'page': page},
    );
  }

  // Send message
  Future<Response> sendMessage({
    required String chatId,
    required String content,
    String? type,
  }) async {
    return await _dio.post(
      '/resident/chat',
      data: {
        'chatId': chatId,
        'content': content,
        'type': type ?? 'text',
      },
    );
  }

  // Mark message as read
  Future<Response> markAsRead(String messageId) async {
    return await _dio.put('/resident/chat/$messageId/read');
  }

  // Get unread count
  Future<Response> getUnreadCount() async {
    return await _dio.get('/resident/chat/unread-count');
  }
}