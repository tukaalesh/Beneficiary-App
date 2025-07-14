import 'package:charity_app/auth/cubits/auth_cubits/auth_cubits.dart';
import 'package:charity_app/auth/cubits/splash_cubits/splash_cubits.dart';
import 'package:charity_app/auth/cubits/user_cubit/user_cubit.dart';
import 'package:charity_app/auth/screens/login_screen.dart';
import 'package:charity_app/auth/screens/signup_screen.dart';
import 'package:charity_app/auth/screens/splash_screen.dart';
import 'package:charity_app/auth/screens/welcome_screen.dart';
import 'package:charity_app/core/theme/app_themes.dart';
import 'package:charity_app/feature/notification/screen/notification_screen.dart';
import 'package:charity_app/home/cubits/navigation/navigation_cubit.dart';
import 'package:charity_app/home/cubits/themeCubit/theme_cubit.dart';
import 'package:charity_app/home/screens/home_page.dart';
import 'package:charity_app/home/screens/navigation_main.dart';
import 'package:charity_app/home/screens/setting.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

late SharedPreferences sharedPreferences;
final token = sharedPreferences.get("token");

// String? token;
//
//مشان ونحنا عم نعدل بين ايميوليتر و ويندوز

// const String localhost = "10.0.2.2:8000";

const String localhost = "127.0.0.1:8000";
// const String localhost = " 192.168.59.180:8000";
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
        BlocProvider(create: (context) => UserCubit()),
        BlocProvider(create: (context) => NavigationCubit()),
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
            // builder: (context, child) {
            //   return Directionality(
            //     textDirection: TextDirection.rtl,
            //     child: child!,
            //   );
            // },
            initialRoute: "Splash",
            routes: {
              "Splash": (context) => const SplashScreen(),
              "NavigationMain": (context) => const NavigationMain(),
              // "Home": (context) => const HomePage(),
              "SignUp": (context) => SignUpScreen(),
              "LogIn": (context) => LoginScreen(),
              "Welcom": (context) => const WelcomeScreen(),
              "Setting": (context) => const Setting(),
              "Notification": (context) => const NotificationScreen(),
            },
          );
        },
      ),
    );
  }
}
