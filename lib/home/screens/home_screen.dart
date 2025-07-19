// ignore_for_file: use_build_context_synchronously

import 'package:charity_app/constants/const_appBar.dart';
import 'package:charity_app/core/extensions/context_extensions.dart';
import 'package:charity_app/home/cubits/count_notification_cubit/count-notification_cubit.dart';
import 'package:charity_app/home/cubits/count_notification_cubit/count-notification_state.dart';
import 'package:charity_app/home/widgets/home/part1/home_slider.dart';
import 'package:charity_app/home/widgets/home/part2/home_section2.dart';
import 'package:charity_app/home/widgets/home/part3/home_section3.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = context.colorScheme;

    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: colorScheme.surface,
        appBar: AppBar(
          title: const Text("الصفحة الرئيسية"),
          backgroundColor: colorScheme.surface,
          actions: [
            BlocBuilder<CountNotificationCubit, CountNotificationState>(
              builder: (context, state) {
                int unreadCount = 0;
                if (state is NotificationLoaded) {
                  unreadCount = state.unreadCount;
                }
                return Stack(
                  children: [
                    IconButton(
                      icon: Icon(
                        Icons.notifications_none_outlined,
                        color: colorScheme.secondary,
                        size: 30,
                      ),
                      onPressed: () async {
                        context.read<CountNotificationCubit>().clearCount();
                        await Navigator.pushNamed(context, 'Notification');
                        context
                            .read<CountNotificationCubit>()
                            .fetchUnreadNotifications();
                      },
                    ),
                    if (unreadCount > 0)
                      Positioned(
                        right: 8,
                        top: 8,
                        child: Container(
                          padding: const EdgeInsets.all(2),
                          decoration: BoxDecoration(
                            color: Colors.redAccent,
                            shape: BoxShape.circle,
                          ),
                          constraints: const BoxConstraints(
                            minWidth: 16,
                            minHeight: 16,
                          ),
                          child: Text(
                            '$unreadCount',
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 10,
                              fontWeight: FontWeight.bold,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                  ],
                );
              },
            ),
            const SizedBox(width: 8),
          ],
        ),
        body: RefreshIndicator(
          onRefresh: () async {
            await context
                .read<CountNotificationCubit>()
                .fetchUnreadNotifications();
          },
          child: ListView(
            children: const [
              SizedBox(
                height: 200,
                width: double.infinity,
                child: HomeSliderSection1(),
              ),
              HomeSection2(),
              HomeSection3(),
            ],
          ),
        ),
      ),
    );
  }
}
