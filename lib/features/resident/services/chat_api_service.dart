
import 'package:dio/dio.dart';
import '../../../core/network/dio_client.dart';
import '../../../core/constants/api_constant.dart';

class ChatApiService {
  final Dio _dio = DioClient.instance;

  // Get chat list
  Future<Response> getChatList() async {
    return await _dio.get(ApiConstants.chat);
  }

  // Get chat messages
  Future<Response> getChatMessages(String chatId, {int page = 1}) async {
    return await _dio.get(
      '${ApiConstants.chat}/$chatId',
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
      ApiConstants.chat,
      data: {
        'chatId': chatId,
        'content': content,
        'type': type ?? 'text',
      },
    );
  }

  // Mark message as read
  Future<Response> markAsRead(String messageId) async {
    return await _dio.put('${ApiConstants.chat}/$messageId/read');
  }

  // Get unread count
  Future<Response> getUnreadCount() async {
    return await _dio.get('${ApiConstants.chat}/unread-count');
  }
}