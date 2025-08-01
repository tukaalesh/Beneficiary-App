// ignore_for_file: deprecated_member_use

import 'package:charity_app/auth/cubits/auth_cubits/auth_cubits.dart';
import 'package:charity_app/auth/cubits/auth_cubits/auth_states.dart';
import 'package:charity_app/auth/widgets/auth_button.dart';
import 'package:charity_app/auth/widgets/auth_custom_text_field.dart';
import 'package:charity_app/constants/const_alert_dilog.dart';
import 'package:charity_app/core/extensions/context_extensions.dart';
import 'package:charity_app/constants/const_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:icons_plus/icons_plus.dart';

class SignUpScreen extends StatelessWidget {
  SignUpScreen({super.key});

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  final TextEditingController fullNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  // final TextEditingController phoneNumberController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController passwordConfirmationController =
      TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final colorScheme = context.colorScheme;
    Size screenSize = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: colorScheme.surface,
      body: BlocConsumer<AuthCubits, AuthStates>(
        listener: (context, state) {
          if (state is RegisterSuccessState) {
            Navigator.pushNamed(context, 'LogIn');
          } else if (state is RegisterFailureState) {
            showDialog(
              context: context,
              barrierDismissible: false,
              builder: (context) => CustomAlertDialogNoConfirm(
                title: "عذراً يرجى المحاولة مجدداً",
                cancelText: "إغلاق",
                onCancel: () {
                  Navigator.of(context).pop();
                },
              ),
            );
          }
        },
        builder: (context, state) {
          final isLoading = state is LoadingStates;

          return Stack(
            children: [
              SafeArea(
                child: ListView(
                  children: [
                    const SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                            width: screenSize.width * 0.2,
                            height: screenSize.width * 0.2,
                            child: charityLogoImage),
                        const Text(
                          'إنشاء حساب',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 20),
                        ),
                        const SizedBox(width: 60),
                      ],
                    ),
                    const SizedBox(height: 10),
                    Container(
                      decoration: BoxDecoration(
                        color: colorScheme.surface,
                      ),
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Form(
                        key: formKey,
                        child: Column(
                          children: [
                            AuthCustomTextField(
                              hint: 'ادخل اسمك الثلاثي',
                              icon: const Icon(BoxIcons.bx_user),
                              inputType: TextInputType.name,
                              mycontroller: fullNameController,
                              color: colorScheme.secondary,
                              valid: (value) {
                                if (value!.isEmpty) {
                                  return "الاسم مطلوب";
                                }
                                return null;
                              },
                            ),
                            const SizedBox(height: 12),
                            AuthCustomTextField(
                              hint: 'ادخل بريدك الإلكتروني',
                              icon: const Icon(BoxIcons.bx_envelope),
                              inputType: TextInputType.emailAddress,
                              mycontroller: emailController,
                              color: colorScheme.secondary,
                              valid: (value) {
                                if (value!.isEmpty) {
                                  return "البريد الإلكتروني مطلوب";
                                }
                                bool isValidEmail =
                                    RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$')
                                        .hasMatch(value);
                                if (!isValidEmail) {
                                  return "الرجاء إدخال بريد إلكتروني صحيح";
                                }
                                return null;
                              },
                            ),
                            const SizedBox(height: 12),
                            AuthCustomTextField(
                                color: colorScheme.secondary,
                                hint: "رقم الهاتف",
                                inputType: TextInputType.number,
                                mycontroller: phoneController,
                                icon: const Icon(Icons.phone_enabled_rounded),
                                valid: (value) {
                                  if (value!.isEmpty) {
                                    return "رقم المُهدى إليه مطلوب";
                                  }
                                  if (!value.startsWith("09")) {
                                    return "يجب أن يبدأ الرقم ب 09";
                                  }
                                  if (value.length != 10) {
                                    return "يجب أن يتكون الرقم من 10 أرقام";
                                  }
                                  if (value.startsWith(".") ||
                                      value.startsWith(",") ||
                                      value.startsWith("-")) {
                                    return "يُرجى إدخال الرقم بطريقة صحيحة";
                                  }
                                  if (value.contains(".") ||
                                      value.contains(",") ||
                                      value.contains("-")) {
                                    return "يُرجى إدخال الرقم بطريقة صحيحة";
                                  }
                                  return null;
                                }),
                            const SizedBox(height: 12),
                            AuthCustomTextField(
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
                            const SizedBox(height: 12),
                            AuthCustomTextField(
                              hint: 'ادخل تأكيد كلمة المرور',
                              icon: const Icon(BoxIcons.bx_lock_alt),
                              inputType: TextInputType.visiblePassword,
                              mycontroller: passwordConfirmationController,
                              color: colorScheme.secondary,
                              isPassword: true,
                              valid: (value) {
                                if (value!.isEmpty) {
                                  return "يرجى تأكيد كلمة المرور";
                                }
                                if (value != passwordController.text) {
                                  return "كلمة المرور غير متطابقة";
                                }
                                return null;
                              },
                            ),
                            const SizedBox(height: 25),
                            Authbutton(
                              buttonText: "إنشاء حساب",
                              onPressed: () {
                                if (formKey.currentState!.validate()) {
                                  BlocProvider.of<AuthCubits>(context)
                                      .signUpFunction(
                                          fullNameController:
                                              fullNameController,
                                          emailController: emailController,
                                          passwordConfirmationController:
                                              passwordConfirmationController,
                                          passwordController:
                                              passwordController,
                                          phoneController: phoneController);
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
                                    Navigator.pushNamed(context, 'LogIn');
                                  },
                                  child: Text(
                                    'تسجيل الدخول',
                                    style: TextStyle(
                                        color: colorScheme.secondary,
                                        fontSize: 13,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                                Text(
                                  ' لديك حساب بالفعل ؟ ',
                                  style: TextStyle(
                                      color: colorScheme.onSurface,
                                      fontSize: 13),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              if (isLoading)
                Container(
                  width: double.infinity,
                  height: double.infinity,
                  color: Colors.black.withOpacity(0.3),
                  child: Center(
                    child: SpinKitCircle(
                      color: colorScheme.secondary,
                      size: 45,
                    ),
                  ),
                ),
            ],
          );
        },
      ),
    );
  }
}
