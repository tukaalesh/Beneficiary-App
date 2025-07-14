// ignore_for_file: use_build_context_synchronously

import 'package:charity_app/auth/cubits/auth_cubits/auth_cubits.dart';
import 'package:charity_app/auth/cubits/auth_cubits/auth_states.dart';
import 'package:charity_app/auth/cubits/user_cubit/user_cubit.dart';
import 'package:charity_app/auth/cubits/user_cubit/user_states.dart';
import 'package:charity_app/constants/const_alert_dilog.dart';
import 'package:charity_app/constants/const_appBar.dart';
import 'package:charity_app/core/extensions/context_extensions.dart';
import 'package:charity_app/home/widgets/initial_circle.dart';
import 'package:charity_app/home/widgets/settings_rowItem.dart';
import 'package:charity_app/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class Setting extends StatelessWidget {
  const Setting({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = context.isDarkMode;
    final theme = context.theme;
    final colorScheme = context.colorScheme;
    // final unReadPoits = sharedPreferences.getString("unreadPoints");

    return BlocListener<AuthCubits, AuthStates>(
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
          appBar: const ConstAppBar1(title: "الإعدادات"),
          backgroundColor: colorScheme.surface,
          body: BlocBuilder<UserCubit, UserState>(
            builder: (context, state) {
              if (state is UserInitialState) {
                WidgetsBinding.instance.addPostFrameCallback((_) {
                  final token = sharedPreferences.getString('token');
                  if (token != null && token.isNotEmpty) {
                    context.read<UserCubit>().getUserData(token);
                  }
                });
                return Center(child: SpinKitCircle(color: colorScheme.primary));
              }

              if (state is UserLoadingState) {
                return Center(child: SpinKitCircle(color: colorScheme.primary));
              }

              if (state is UserErrorState) {
                return Center(child: Text("Error: ${state.message}"));
              }

              if (state is UserSuccessState) {
                final user = state.user;

                return RefreshIndicator(
                  onRefresh: () async {
                    final token = sharedPreferences.getString('token');
                    if (token != null && token.isNotEmpty) {
                      try {
                        await context.read<UserCubit>().getUserData(token);
                      } catch (e) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text("فشل التحديث")),
                        );
                      }
                    } else {}
                  },
                  child: ListView(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    children: [
                      // Directionality(
                      //   textDirection: TextDirection.rtl,
                      //   child: Row(
                      //     children: [
                      //       Initialcircle(
                      //         text: (user.fullName.isNotEmpty
                      //             ? user.fullName[0].toUpperCase()
                      //             : '?'),
                      //       ),
                      //       const SizedBox(width: 12),
                      //       Column(
                      //         crossAxisAlignment: CrossAxisAlignment.start,
                      //         mainAxisSize: MainAxisSize.min,
                      //         children: [
                      //           SizedBox(
                      //             width:
                      //                 MediaQuery.of(context).size.width * 0.5,
                      //             child: Text(
                      //               user.email.isNotEmpty
                      //                   ? user.email
                      //                   : "البريد غير متوفر",
                      //               style: const TextStyle(
                      //                 fontSize: 12,
                      //                 fontWeight: FontWeight.w500,
                      //               ),
                      //               maxLines: 1,
                      //               overflow: TextOverflow.ellipsis,
                      //             ),
                      //           ),
                      //           const SizedBox(height: 4),
                      //           SizedBox(
                      //             width:
                      //                 MediaQuery.of(context).size.width * 0.5,
                      //             child: Text(
                      //               user.email.isNotEmpty
                      //                   ? user.phoneNumber
                      //                   : "09xxxxxxxx",
                      //               style: const TextStyle(
                      //                 fontSize: 12,
                      //                 fontWeight: FontWeight.w500,
                      //               ),
                      //               maxLines: 1,
                      //               overflow: TextOverflow.ellipsis,
                      //             ),
                      //           ),
                      //         ],
                      //       )
                      //     ],
                      //   ),
                      // ),
                      // const SizedBox(height: 5),
                      // Divider(color: theme.dividerColor),

                      Stack(
                        children: [
                          SettingsRowItem(
                            onTap: () async {
                              await Navigator.pushNamed(
                                  context, 'Notification');
                              context.read<UserCubit>().clearUnreadPoints();
                            },
                            text: "الإشعارات",
                            icon: Icon(Icons.notifications_none_outlined,
                                color: colorScheme.onSurface),
                            color: colorScheme.onSurface,
                          ),
                          if (user.unreadNotifications != 0)
                            Positioned(
                              right: -0.6,
                              bottom: 12,
                              child: Container(
                                width: 17,
                                height: 17,
                                alignment: Alignment.center,
                                decoration: const BoxDecoration(
                                  color: Color.fromRGBO(223, 0, 0, 0.763),
                                  shape: BoxShape.circle,
                                ),
                                child: Text(
                                  user.unreadNotifications.toString(),
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
                      ),

                      // const SizedBox(height: 6),
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
                                onChanged: (_) =>
                                    context.themeCubit.toggleTheme(),
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
                );
              }

              return const Center(child: Text("Unexpected error"));
            },
          ),
        ),
      ),
    );
  }
}
