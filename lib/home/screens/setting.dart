// ignore_for_file: use_build_context_synchronously

import 'package:charity_app/auth/cubits/auth_cubits/auth_cubits.dart';
import 'package:charity_app/auth/cubits/auth_cubits/auth_states.dart';
import 'package:charity_app/constants/const_alert_dilog.dart';
import 'package:charity_app/constants/const_appBar.dart';
import 'package:charity_app/core/extensions/context_extensions.dart';
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
          body: ListView(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            children: [
              Stack(
                children: [
                  SettingsRowItem(
                    onTap: () async {
                      await Navigator.pushNamed(context, 'Notification');
                      // context.read<UserCubit>().clearUnreadPoints(); // حذفنا الـ Bloc
                    },
                    text: "الإشعارات",
                    icon: Icon(Icons.notifications_none_outlined,
                        color: colorScheme.onSurface),
                    color: colorScheme.onSurface,
                  ),
                  // إذا حابب تخلي التنبيه الوهمي، خليه، أو احذفه
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
                        "3", // رقم ثابت بدل user.unreadNotifications
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
                icon: Icon(Icons.logout_outlined, color: colorScheme.onSurface),
                color: colorScheme.onSurface,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
