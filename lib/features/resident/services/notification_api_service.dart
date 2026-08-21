
import 'package:dio/dio.dart';
import '../../../core/network/dio_client.dart';
import '../../../core/constants/api_constant.dart';

class NotificationApiService {
  final Dio _dio = DioClient.instance;

  // Get notifications
  Future<Response> getNotifications({
    bool? isRead,
    String? type,
    int page = 1,
    int limit = 20,
  }) async {
    final query = <String, dynamic>{};
    if (isRead != null) query['isRead'] = isRead;
    if (type != null) query['type'] = type;
    query['page'] = page;
    query['limit'] = limit;
    return await _dio.get(
      ApiConstants.notifications,
      queryParameters: query,
    );
  }

  // Get notification details
  Future<Response> getNotificationDetails(String id) async {
    return await _dio.get('${ApiConstants.notifications}/$id');
  }

  // Mark notification as read
  Future<Response> markAsRead(String id) async {
    return await _dio.put('${ApiConstants.notifications}/$id/read');
  }

  // Mark all as read
  Future<Response> markAllAsRead() async {
    return await _dio.put('${ApiConstants.notifications}/read-all');
  }

  // Get unread count
  Future<Response> getUnreadCount() async {
    return await _dio.get('${ApiConstants.notifications}/unread-count');
  }
}