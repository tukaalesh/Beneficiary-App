// ignore_for_file: file_names

class NotificationCountModel {
  final int unreadCount;

  NotificationCountModel({required this.unreadCount});

  factory NotificationCountModel.fromJson(Map<String, dynamic> json) {
    return NotificationCountModel(
      unreadCount: (json['unread_count'] is int) ? json['unread_count'] : 0,
    );
  }
}
