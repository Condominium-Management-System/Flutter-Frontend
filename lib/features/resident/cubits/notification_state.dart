
import 'package:equatable/equatable.dart';
import '../models/notification_model.dart';

abstract class NotificationState extends Equatable {
  const NotificationState();

  @override
  List<Object?> get props => [];
}

class NotificationInitial extends NotificationState {}

class NotificationLoading extends NotificationState {}

class NotificationListLoaded extends NotificationState {
  final List<NotificationModel> notifications;

  const NotificationListLoaded({required this.notifications});

  @override
  List<Object?> get props => [notifications];
}

class NotificationDetailsLoaded extends NotificationState {
  final NotificationModel notification;

  const NotificationDetailsLoaded({required this.notification});

  @override
  List<Object?> get props => [notification];
}

class NotificationUnreadCountLoaded extends NotificationState {
  final int count;

  const NotificationUnreadCountLoaded({required this.count});

  @override
  List<Object?> get props => [count];
}

class NotificationAllRead extends NotificationState {}

class NotificationError extends NotificationState {
  final String message;

  const NotificationError({required this.message});

  @override
  List<Object?> get props => [message];
}