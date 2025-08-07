import 'package:charity_app/auth/cubits/auth_cubits/auth_cubits.dart';
import 'package:charity_app/auth/cubits/splash_cubits/splash_cubits.dart';
import 'package:charity_app/auth/screens/login_screen.dart';
import 'package:charity_app/auth/screens/signup_screen.dart';
import 'package:charity_app/auth/screens/splash_screen.dart';
import 'package:charity_app/auth/screens/welcome_screen.dart';
import 'package:charity_app/core/theme/app_themes.dart';
import 'package:charity_app/feature/Feedback/cubit/feedback_cubit.dart';
import 'package:charity_app/feature/HealthSupport/cubit/health_form_cubit.dart';
import 'package:charity_app/feature/HealthSupport/screen/health_form_screen.dart';
import 'package:charity_app/feature/HousingSupport/cubit/housing_form_cubit.dart';
import 'package:charity_app/feature/education/cubit/education_form_cubit.dart';
import 'package:charity_app/feature/education/screen/education_screen.dart';
import 'package:charity_app/feature/food/cubit/nutritional_cubit.dart';
import 'package:charity_app/feature/food/screen/nutritional_screen.dart';
import 'package:charity_app/feature/notification/screen/notification_screen.dart';
import 'package:charity_app/feature/request_status/request_status/cubit/request_status_cubit.dart';
import 'package:charity_app/home/cubits/count_notification_cubit/count-notification_cubit.dart';
import 'package:charity_app/home/cubits/navigation/navigation_cubit.dart';
import 'package:charity_app/home/cubits/themeCubit/theme_cubit.dart';
import 'package:charity_app/home/screens/navigation_main.dart';
import 'package:charity_app/home/screens/setting.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

late SharedPreferences sharedPreferences;

// const String localhost = "10.0.2.2:8000";
const String localhost = "127.0.0.1:8000";

const String baseUrl = "http://$localhost";
//const String localhost = "ffa3e8341e13.ngrok-free.app";
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  sharedPreferences = await SharedPreferences.getInstance();

  final isDarkMode = sharedPreferences.getBool('isDarkMode') ?? false;

  runApp(MyApp(isDarkMode: isDarkMode));
}

class MyApp extends StatelessWidget {
  final bool isDarkMode;

  const MyApp({super.key, required this.isDarkMode});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => AuthCubits()),
        BlocProvider(create: (context) => SplashCubit()),
        BlocProvider(create: (context) => ThemeCubits(isDarkMode)),
        BlocProvider(create: (context) => NavigationCubit()),
        BlocProvider(create: (context) => FeedbackCubit()),
        BlocProvider(create: (context) => RequestStatusCubit()),
        BlocProvider(create: (context) => EducationRequestCubit()),
        BlocProvider(create: (context) => EducationFormCubit()),
        BlocProvider(create: (context) => NutritionalFormCubit()),
        BlocProvider(create: (context) => NutritionalRequestCubit()),
        BlocProvider(create: (context) => HousingFormCubit()),
        BlocProvider(create: (context) => HealthFormCubit()),
        BlocProvider<CountNotificationCubit>(
          create: (_) => CountNotificationCubit()..fetchUnreadNotifications(),
        )
      ],
      child: BlocBuilder<ThemeCubits, bool>(
        builder: (context, isDarkMode) {
          final theme = AppThemes.getTheme(isDarkMode);
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: theme.copyWith(
              textTheme: theme.textTheme.apply(
                fontFamily: 'IBMPlexSansArabic',
              ),
            ),
            initialRoute: "Welcom",
            routes: {
              "Splash": (context) => const SplashScreen(),
              "NavigationMain": (context) => const NavigationMain(),
              // "Home": (context) => const HomePage(),
              "SignUp": (context) => SignUpScreen(),
              "LogIn": (context) => LoginScreen(),
              "Welcom": (context) => const WelcomeScreen(),
              "Setting": (context) => const Setting(),
              "Notification": (context) => const NotificationScreen(),
              "HealthFormScreen": (context) => const HealthFormScreen(),
              "EducationScreen": (context) => const EducationScreen(),
            },
          );
        },
      ),
    );
  }
}
