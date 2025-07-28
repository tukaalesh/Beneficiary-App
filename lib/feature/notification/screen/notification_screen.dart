import 'package:charity_app/constants/const_appBar.dart';
import 'package:charity_app/constants/const_image.dart';
import 'package:charity_app/core/extensions/context_extensions.dart';
import 'package:charity_app/feature/notification/cubit/notification_cubit.dart';
import 'package:charity_app/feature/notification/cubit/notification_state.dart';
import 'package:charity_app/feature/notification/widget/notification_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class NotificationScreen extends StatelessWidget {
  const NotificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = context.colorScheme;

    return BlocProvider(
      create: (_) => NotificationCubit()..fetchNotifications(),
      child: Directionality(
        textDirection: TextDirection.rtl,
        child: Scaffold(
          backgroundColor: colorScheme.surface,
          appBar: const ConstAppBar(title: "الإشعارات"),
          body: BlocBuilder<NotificationCubit, NotificationState>(
            builder: (context, state) {
              if (state is NotificationLoading) {
                return Center(
                  child: SpinKitCircle(color: colorScheme.primary),
                );
              }

              if (state is NotificationError) {
                return const Center(child: Text("حدث خطأ أثناء جلب البيانات"));
              }

              if (state is NotificationEmpty) {
                return RefreshIndicator(
                  onRefresh: () async {
                    context.read<NotificationCubit>().fetchNotifications();
                  },
                  child: ListView(
                    physics: const AlwaysScrollableScrollPhysics(),
                    children: [
                      const SizedBox(height: 170),
                      Center(child: emtpyImage),
                      const SizedBox(height: 10),
                      const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text(
                          "لا توجد إشعارات حالياً.\nسنعرض لك هنا أي تحديثات أو تنبيهات فور توفرها",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              }

              if (state is NotificationSuccess) {
                final notifications = state.notifications;

                return RefreshIndicator(
                  onRefresh: () async {
                    context.read<NotificationCubit>().fetchNotifications();
                  },
                  child: ListView.builder(
                    padding: const EdgeInsets.all(16),
                    itemCount: notifications.length,
                    itemBuilder: (context, index) {
                      final notification = notifications[index];
                      return NotificationCard(
                        title: notification.title,
                        message: notification.message,
                        time: notification.time,
                      );
                    },
                  ),
                );
              }

              return const Text("هناك مشكلة ما!");
            },
          ),
        ),
      ),
    );
  }
}
