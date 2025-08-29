// ignore_for_file: deprecated_member_use

import 'package:charity_app/auth/widgets/auth_button.dart';
import 'package:charity_app/constants/const_alert_dilog.dart';
import 'package:charity_app/constants/custom_text.dart';
import 'package:charity_app/core/extensions/context_extensions.dart';
import 'package:charity_app/feature/Feedback/cubit/feedback_cubit.dart';
import 'package:charity_app/feature/Feedback/cubit/feedback_states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class FeedbackScreen extends StatefulWidget {
  const FeedbackScreen({super.key});

  @override
  State<FeedbackScreen> createState() => _FeedbackScreenState();
}

class _FeedbackScreenState extends State<FeedbackScreen> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController commentController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final colorScheme = context.colorScheme;
    return BlocConsumer<FeedbackCubit, FeedbackStates>(
      listener: (context, state) {
        if (state is FeedBackSuccess) {
          nameController.clear();
          commentController.clear();
          showDialog(
            context: context,
            barrierDismissible: false,
            builder: (context) => CustomAlertDialogNoConfirm(
              title: "شكرًا لمشاركتك، تم استلام تعليقك وسيتم النظر فيه بعناية.",
              cancelText: "إغلاق",
              onCancel: () {
                Navigator.of(context).pop();
              },
            ),
          );
        }
        if (state is FeedBackNotAllowed) {
          nameController.clear();
          commentController.clear();
          showDialog(
            context: context,
            barrierDismissible: false,
            builder: (context) => CustomAlertDialogNoConfirm(
              title:
                  "يُرجى تقديم طلب مساعدة واحد على الأقل قبل إرسال الملاحظات، وذلك لضمان تقييم الخدمة المقدّمة بشكل دقيق.",
              cancelText: "إغلاق",
              onCancel: () {
                Navigator.of(context).pop();
              },
            ),
          );
        }
        if (state is FeedBackFailure) {
          nameController.clear();
          commentController.clear();
          showDialog(
            context: context,
            barrierDismissible: false,
            builder: (context) => CustomAlertDialogNoConfirm(
              title: "حدث خطأ يُرجى المحاولة فيما بعد",
              cancelText: "إغلاق",
              onCancel: () {
                Navigator.of(context).pop();
              },
            ),
          );
        }
      },
      builder: (context, state) {
        return Directionality(
            textDirection: TextDirection.rtl,
            child: Stack(
              children: [
                Scaffold(
                  backgroundColor: colorScheme.surface,
                  appBar: AppBar(
                    title: const Text("إرسال التقييم"),
                    backgroundColor: colorScheme.surface,
                    leading: null,
                    automaticallyImplyLeading: false,
                  ),
                  body: Form(
                    key: formKey,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 20, right: 20),
                      child: ListView(
                        children: [
                          Image.asset(
                            "assets/images/chat.png",
                            height: 100,
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          const Padding(
                            padding: EdgeInsets.only(right: 5.0, left: 5),
                            child: Text(
                              "ملاحظاتكم تهمّنا، نرجو مشاركتها بشفافية لتساعدنا في تحسين جودة خدماتنا وتلبيتها بشكل أفضل.",
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                          const SizedBox(height: 15),
                          Padding(
                            padding: const EdgeInsets.only(right: 5.0, left: 5),
                            child: Text(
                              "اسمك الظاهر للآخرين داخل التطبيق",
                              style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  color: colorScheme.secondary,
                                  fontSize: 14),
                            ),
                          ),
                          const SizedBox(height: 8),
                          Customtextfields(
                            hint: '',
                            inputType: TextInputType.name,
                            mycontroller: nameController,
                            valid: (value) {
                              if (value!.isEmpty) return "يجب عليك إدخال الأسم";

                              return null;
                            },
                          ),
                          const SizedBox(height: 15),
                          Padding(
                            padding: const EdgeInsets.only(right: 5.0, left: 5),
                            child: Text(
                              "التعليق",
                              style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  color: colorScheme.secondary,
                                  fontSize: 14),
                            ),
                          ),
                          const SizedBox(height: 8),
                          Customtextfields(
                            hint: '',
                            inputType: TextInputType.name,
                            mycontroller: commentController,
                            valid: (value) {
                              if (value!.isEmpty) {
                                return "يجب عليك إدخال التعليق";
                              }
                              if (value.length < 12) {
                                return "يجب ان يتضمن التعليق 10 محارف على الأقل";
                              }
                              return null;
                            },
                          ),
                          const SizedBox(height: 20),
                          Authbutton(
                            buttonText: "إرسال",
                            onPressed: () {
                              if (formKey.currentState!.validate()) {
                                BlocProvider.of<FeedbackCubit>(context)
                                    .sendFeedBack(
                                  user_name: nameController.text,
                                  message: commentController.text,
                                );
                              }
                            },
                            color: colorScheme.secondary,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                if (state is FeedBackLoading)
                  Container(
                    width: double.infinity,
                    height: double.infinity,
                    color: Colors.black.withOpacity(0.6),
                    child: Center(
                      child: SpinKitCircle(
                        color: colorScheme.primary,
                        size: 45,
                      ),
                    ),
                  ),
              ],
            ));
      },
    );
  }
}
