import 'package:charity_app/auth/model/NotificationCountModel.dart';

abstract class CountNotificationState {}

class NotificationInitial extends CountNotificationState {}

class NotificationLoading extends CountNotificationState {}

class NotificationLoaded extends CountNotificationState {
  final NotificationCountModel notificationCount;

  NotificationLoaded(this.notificationCount);

  int get unreadCount => notificationCount.unreadCount;
}

class NotificationError extends CountNotificationState {
  final String message;
  NotificationError(this.message);
}
