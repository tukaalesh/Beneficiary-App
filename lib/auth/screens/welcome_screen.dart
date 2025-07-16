import 'package:charity_app/auth/widgets/auth_button.dart';
import 'package:charity_app/core/extensions/context_extensions.dart';
import 'package:flutter/material.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = context.colorScheme;
    final size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: colorScheme.surface,
      body: Stack(
        children: [
          SizedBox(
            width: double.infinity,
            height: size.height * 0.55,
            child: Image.asset(
              'assets/images/welcome_test.jpg',
              fit: BoxFit.cover,
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: FractionallySizedBox(
              heightFactor: 0.52,
              widthFactor: 1,
              child: Container(
                decoration: BoxDecoration(
                  color: colorScheme.surface,
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(25),
                    topRight: Radius.circular(25),
                  ),
                ),
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 25),
                  child: Column(
                    children: [
                      Column(
                        children: [
                          Text(
                            "نحن هنا لدعم كل من يحتاج، لنمد يد العون لكل صاحب حاجة",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: colorScheme.onSurface,
                            ),
                          ),
                          const SizedBox(height: 15),
                          Text(
                            'قم بتسجيل دخولك أو إنشاء حساب جديد لتتمكن من استخدام خدمات التطبيق',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 14,
                              color: colorScheme.onSurface,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          const SizedBox(height: 15),
                        ],
                      ),
                      Column(
                        children: [
                          Authbutton(
                            buttonText: 'إنشاء حساب',
                            onPressed: () {
                              Navigator.pushNamed(context, 'SignUp');
                            },
                            color: colorScheme.secondary,
                          ),
                          const SizedBox(height: 15),
                          Authbutton(
                            buttonText: 'تسجيل دخول',
                            onPressed: () {
                              Navigator.pushNamed(context, 'LogIn');
                            },
                            color: colorScheme.primary,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
