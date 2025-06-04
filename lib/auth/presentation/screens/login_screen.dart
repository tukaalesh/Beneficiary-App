import 'package:charity_app/auth/cubits/auth_cubits/auth_cubits.dart';
import 'package:charity_app/auth/cubits/auth_cubits/auth_states.dart';
import 'package:charity_app/auth/presentation/widgets/auth_button.dart';
import 'package:charity_app/auth/presentation/widgets/custom_text_field.dart';
import 'package:charity_app/core/extensions/context_extensions.dart';
import 'package:charity_app/constants/image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:icons_plus/icons_plus.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  final TextEditingController emailController = TextEditingController();

  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final colorScheme = context.colorScheme;
    Size screenSize = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: colorScheme.surface,
      body: BlocConsumer<AuthCubits, AuthStates>(
        listener: (context, state) {
          if (state is LoginSuccessState) {
            ScaffoldMessenger.of(context).clearSnackBars();
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: const Center(child: Text("تم تسجيل الدخول بنجاح")),
                backgroundColor: colorScheme.secondary,
              ),
            );
            Navigator.pushNamed(context, 'Home');
          } else if (state is LoginFailureState) {
            ScaffoldMessenger.of(context).clearSnackBars();
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Center(child: Text("عذراً يرجى المحاولة مجدداً")),
              ),
            );
          }
        },
        builder: (context, state) {
          if (state is LoadingStates) {
            return Center(
              child: SpinKitCircle(
                color: colorScheme.secondary,
                size: 45,
              ),
            );
          }

          return SafeArea(
            child: ListView(
              children: [
                const SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                        width: screenSize.width * 0.2,
                        height: screenSize.width * 0.2,
                        child: charityLogoImage),
                    const Text(
                      'تسجل دخول',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
                    ),
                    const SizedBox(
                      width: 60,
                    ),
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                Container(
                  decoration: BoxDecoration(
                    color: colorScheme.surface,
                  ),
                  padding: const EdgeInsets.only(left: 20, right: 20),
                  child: Form(
                    key: formKey,
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          Customtextfield(
                              hint: 'ادخل بريدك الإلكتروني',
                              icon: const Icon(BoxIcons.bx_envelope),
                              inputType: TextInputType.emailAddress,
                              mycontroller: emailController,
                              color: colorScheme.secondary,
                              valid: (value) {
                                if (value!.isEmpty) {
                                  return "البريد الإلكتروني مطلوب";
                                }
                                return null;
                              }),
                          const SizedBox(height: 12),
                          Customtextfield(
                            hint: 'ادخل كلمة المرور',
                            icon: const Icon(BoxIcons.bx_lock_alt),
                            inputType: TextInputType.visiblePassword,
                            mycontroller: passwordController,
                            color: colorScheme.secondary,
                            isPassword: true,
                            valid: (value) {
                              if (value!.isEmpty) return "كلمة المرور مطلوبة";
                              if (value.length < 8) {
                                return "يجب أن تحتوي على 8 أحرف على الأقل";
                              }
                              return null;
                            },
                          ),
                          const SizedBox(height: 25),
                          Authbutton(
                            buttonText: "تسجيل دخول",
                            onPressed: () {
                              if (formKey.currentState!.validate()) {
                                BlocProvider.of<AuthCubits>(context)
                                    .logInFunction(
                                        emailController: emailController,
                                        passwordController: passwordController);
                              }
                            },
                            color: colorScheme.secondary,
                          ),
                          const SizedBox(height: 15),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              GestureDetector(
                                onTap: () {
                                  Navigator.pushNamed(context, 'SignUp');
                                },
                                child: Text(
                                  'إنشاء حساب',
                                  style: TextStyle(
                                      color: colorScheme.secondary,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                              Text('   ليس لديك حساب؟ ',
                                  style:
                                      TextStyle(color: colorScheme.onSurface)),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
