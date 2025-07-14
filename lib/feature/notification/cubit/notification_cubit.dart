// lib/feature/notification/cubit/notification_cubit.dart
// ignore_for_file: unused_catch_stack

import 'package:charity_app/feature/notification/cubit/notification_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:charity_app/feature/notification/model/notification_model.dart';
import 'package:charity_app/helper/api.dart';
import 'package:charity_app/main.dart';

class NotificationCubit extends Cubit<NotificationState> {
  NotificationCubit() : super(NotificationInitial());

  void fetchNotifications() async {
    if (isClosed) return;
    emit(NotificationLoading());

    try {
      final token = sharedPreferences.getString('token');

      final res = await Api().get(
        url: "http://$localhost/api/notifications/beneficiary",
        token: "$token",
      );

      if (res['notifications'] == null || res['notifications'] is! List) {
        if (!isClosed) emit(NotificationEmpty());
        return;
      }

      final List list = res['notifications'];

      if (list.isEmpty) {
        if (!isClosed) emit(NotificationEmpty());
        return;
      }

      final notifications = list
          .map((e) {
            try {
              return NotificationModel.fromJson(e);
            } catch (e) {
              return null;
            }
          })
          .where((e) => e != null)
          .cast<NotificationModel>()
          .toList();

      if (!isClosed) emit(NotificationSuccess(notifications));
    } catch (e, stackTrace) {
      if (!isClosed) emit(NotificationError("حدث خطأ أثناء جلب البيانات"));
    }
  }
}
