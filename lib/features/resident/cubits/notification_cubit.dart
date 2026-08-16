
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:home_axis/features/resident/models/notification_model.dart';
import 'notification_state.dart';
import '../repositories/notification_repository.dart';
import '../../../core/di/service_locator.dart';
import '../../../core/services/connectivity_service.dart';

class NotificationCubit extends Cubit<NotificationState> {
  final NotificationRepository _notificationRepository = getIt<NotificationRepository>();
  final ConnectivityService _connectivityService = getIt<ConnectivityService>();

  NotificationCubit() : super(NotificationInitial());

  NotificationModel _withReadStatus(NotificationModel notification, {required bool isRead}) {
    final payload = notification.toJson();
    payload['isRead'] = isRead;
    return NotificationModel.fromJson(payload);
  }

  Future<void> loadNotifications({
    bool? isRead,
    String? type,
    int page = 1,
    int limit = 20,
  }) async {
    emit(NotificationLoading());

    try {
      final hasConnection = await _connectivityService.checkConnection();
      if (!hasConnection) {
        emit(const NotificationError(message: 'No internet connection.'));
        return;
      }

      final notifications = await _notificationRepository.getNotifications(
        isRead: isRead,
        type: type,
        page: page,
        limit: limit,
      );
      emit(NotificationListLoaded(notifications: notifications));
    } catch (e) {
      emit(NotificationError(message: e.toString()));
    }
  }

  Future<void> loadNotificationDetails(String id) async {
    emit(NotificationLoading());

    try {
      final hasConnection = await _connectivityService.checkConnection();
      if (!hasConnection) {
        emit(const NotificationError(message: 'No internet connection.'));
        return;
      }

      final notification = await _notificationRepository.getNotificationDetails(id);
      emit(NotificationDetailsLoaded(notification: notification));
    } catch (e) {
      emit(NotificationError(message: e.toString()));
    }
  }

  Future<void> markAsRead(String id) async {
    try {
      await _notificationRepository.markAsRead(id);
      // Refresh list
      final currentState = state;
      if (currentState is NotificationListLoaded) {
        final updatedNotifications = currentState.notifications.map((n) {
          if (n.id == id) {
            return _withReadStatus(n, isRead: true);
          }
          return n;
        }).toList();
        emit(NotificationListLoaded(notifications: updatedNotifications));
      }
    } catch (_) {
      // Silent fail
    }
  }

  Future<void> markAllAsRead() async {
    try {
      final hasConnection = await _connectivityService.checkConnection();
      if (!hasConnection) {
        emit(const NotificationError(message: 'No internet connection.'));
        return;
      }

      await _notificationRepository.markAllAsRead();
      // Refresh list
      final currentState = state;
      if (currentState is NotificationListLoaded) {
        final updatedNotifications = currentState.notifications.map((n) {
          return _withReadStatus(n, isRead: true);
        }).toList();
        emit(NotificationListLoaded(notifications: updatedNotifications));
      }
      emit(NotificationAllRead());
    } catch (e) {
      emit(NotificationError(message: e.toString()));
    }
  }

  Future<void> loadUnreadCount() async {
    try {
      final count = await _notificationRepository.getUnreadCount();
      emit(NotificationUnreadCountLoaded(count: count));
    } catch (_) {
      // Silent fail
    }
  }

  void clearError() {
    if (state is NotificationError) {
      emit(NotificationInitial());
    }
  }
}