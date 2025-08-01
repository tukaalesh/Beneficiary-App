// ignore_for_file: use_build_context_synchronously, curly_braces_in_flow_control_structures

import 'package:charity_app/auth/cubits/auth_cubits/auth_cubits.dart';
import 'package:charity_app/auth/cubits/auth_cubits/auth_states.dart';
import 'package:charity_app/constants/const_alert_dilog.dart';
import 'package:charity_app/core/extensions/context_extensions.dart';
import 'package:charity_app/home/cubits/count_notification_cubit/count-notification_cubit.dart';
import 'package:charity_app/home/cubits/count_notification_cubit/count-notification_state.dart';
import 'package:charity_app/home/widgets/settings_rowItem.dart';
import 'package:charity_app/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Setting extends StatelessWidget {
  const Setting({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = context.isDarkMode;
    final colorScheme = context.colorScheme;

    return BlocProvider.value(
      value: context.read<CountNotificationCubit>(),
      child: BlocListener<AuthCubits, AuthStates>(
        listener: (context, state) {
          if (state is LogOutSuccess) {
            sharedPreferences.clear();
            Navigator.pushNamedAndRemoveUntil(
                context, 'Welcom', (route) => false);
          } else if (state is LogOutFailure) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text("فشل تسجيل الخروج")),
            );
          }
        },
        child: Directionality(
          textDirection: TextDirection.rtl,
          child: Scaffold(
            appBar: AppBar(
              title: const Text("الإعدادات"),
              backgroundColor: colorScheme.surface,
              leading: null,
            ),
            backgroundColor: colorScheme.surface,
            body: RefreshIndicator(
              onRefresh: () async {
                await context
                    .read<CountNotificationCubit>()
                    .fetchUnreadNotifications();
              },
              child: ListView(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                children: [
                  Stack(
                    children: [
                      SettingsRowItem(
                        onTap: () async {
                          context.read<CountNotificationCubit>().clearCount();
                          await Navigator.pushNamed(context, 'Notification');
                          context
                              .read<CountNotificationCubit>()
                              .fetchUnreadNotifications();
                        },
                        text: "الإشعارات",
                        icon: Icon(Icons.notifications_none_outlined,
                            color: colorScheme.onSurface),
                        color: colorScheme.onSurface,
                      ),
                      Positioned(
                        right: -0.6,
                        bottom: 12,
                        child: BlocBuilder<CountNotificationCubit,
                            CountNotificationState>(
                          builder: (context, state) {
                            if (state is NotificationLoading) {
                              return const SizedBox(
                                width: 17,
                                height: 17,
                                child: CircularProgressIndicator(
                                  strokeWidth: 2,
                                  valueColor: AlwaysStoppedAnimation<Color>(
                                    Color.fromRGBO(223, 0, 0, 0.763),
                                  ),
                                ),
                              );
                            }
                            int unreadCount = 0;
                            if (state is NotificationLoaded) {
                              unreadCount = state.unreadCount;
                            }
                            if (unreadCount == 0)
                              return const SizedBox.shrink();

                            return Container(
                              width: 17,
                              height: 17,
                              alignment: Alignment.center,
                              decoration: const BoxDecoration(
                                color: Color.fromRGBO(223, 0, 0, 0.763),
                                shape: BoxShape.circle,
                              ),
                              child: Text(
                                "$unreadCount",
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 10,
                                  fontWeight: FontWeight.bold,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SettingsRowItem(
                        text: "الوضع الليلي",
                        icon: Icon(Icons.dark_mode_outlined,
                            color: colorScheme.onSurface),
                        color: colorScheme.onSurface,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 20.0),
                        child: Transform.scale(
                          scale: 0.8,
                          child: Switch(
                            activeTrackColor: colorScheme.primary,
                            activeColor: colorScheme.surface,
                            inactiveThumbColor: const Color(0xFF919593),
                            inactiveTrackColor: Colors.white,
                            value: isDark,
                            onChanged: (_) => context.themeCubit.toggleTheme(),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SettingsRowItem(
                    onTap: () {
                      showDialog(
                        context: context,
                        barrierDismissible: false,
                        builder: (context) => CustomAlertDialog(
                          title: "تسجيل الخروج",
                          content: "هل تريد بالتأكيد تسجيل الخروج",
                          confirmText: "تأكيد",
                          cancelText: "إلغاء",
                          onConfirm: () {
                            Navigator.pop(context);
                            context.read<AuthCubits>().logOutFunction();
                          },
                          onCancel: () => Navigator.of(context).pop(),
                        ),
                      );
                    },
                    text: "تسجيل الخروج",
                    icon: Icon(Icons.logout_outlined,
                        color: colorScheme.onSurface),
                    color: colorScheme.onSurface,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
