
import '../../../core/di/service_locator.dart';
import '../services/notification_api_service.dart';
import '../models/notification_model.dart';

class NotificationRepository {
  final NotificationApiService _apiService = getIt<NotificationApiService>();

  Future<List<NotificationModel>> getNotifications({
    bool? isRead,
    String? type,
    int page = 1,
    int limit = 20,
  }) async {
    try {
      final response = await _apiService.getNotifications(
        isRead: isRead,
        type: type,
        page: page,
        limit: limit,
      );
      if (response.data == null) {
        return [];
      }
      final data = response.data as Map<String, dynamic>;
      final notificationsData = data['data'] as List? ?? [];
      return notificationsData
          .map((item) => NotificationModel.fromJson(item as Map<String, dynamic>))
          .toList();
    } catch (e) {
      rethrow;
    }
  }

  Future<NotificationModel> getNotificationDetails(String id) async {
    try {
      final response = await _apiService.getNotificationDetails(id);
      if (response.data == null) {
        throw Exception('No data received');
      }
      final data = response.data as Map<String, dynamic>;
      return NotificationModel.fromJson(data['data'] ?? {});
    } catch (e) {
      rethrow;
    }
  }

  Future<bool> markAsRead(String id) async {
    try {
      final response = await _apiService.markAsRead(id);
      return response.data != null && response.statusCode == 200;
    } catch (e) {
      rethrow;
    }
  }

  Future<bool> markAllAsRead() async {
    try {
      final response = await _apiService.markAllAsRead();
      return response.data != null && response.statusCode == 200;
    } catch (e) {
      rethrow;
    }
  }

  Future<int> getUnreadCount() async {
    try {
      final response = await _apiService.getUnreadCount();
      if (response.data == null) {
        return 0;
      }
      final data = response.data as Map<String, dynamic>;
      return data['data']?['count'] as int? ?? 0;
    } catch (e) {
      rethrow;
    }
  }
}