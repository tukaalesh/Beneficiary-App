// ignore_for_file: file_names

import 'package:charity_app/auth/model/NotificationCountModel.dart';
import 'package:charity_app/helper/api.dart';
import 'package:charity_app/home/cubits/count_notification_cubit/count-notification_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:charity_app/main.dart'; // sharedPreferences

class CountNotificationCubit extends Cubit<CountNotificationState> {
  CountNotificationCubit() : super(NotificationInitial());

  Future<void> fetchUnreadNotifications() async {
    emit(NotificationLoading());
    try {
      final token = sharedPreferences.getString("token") ?? '';

      final responseData = await Api().get(
        url: "http://$localhost/api/notifications/unread",
        token: token,
      );

      final notificationCount = NotificationCountModel.fromJson(responseData);

      emit(NotificationLoaded(notificationCount));
    } catch (e) {
      emit(NotificationError("فشل تحميل عدد الإشعارات"));
    }
  }

  void clearCount() {
    emit(NotificationLoaded(NotificationCountModel(unreadCount: 0)));
  }
}
