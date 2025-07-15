import 'package:charity_app/auth/widgets/auth_button.dart';
import 'package:charity_app/auth/widgets/auth_custom_text_field.dart';
import 'package:charity_app/constants/const_appBar.dart';
import 'package:charity_app/core/extensions/context_extensions.dart';
import 'package:charity_app/feature/Feedback/cubit/feedback_cubit.dart';
import 'package:charity_app/feature/Feedback/cubit/feedback_states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class FeedbackScreen extends StatelessWidget {
  FeedbackScreen({super.key});
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
          ScaffoldMessenger.of(context).clearSnackBars();
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text(
              "تم إرسال التعليق بنجاح",
              textDirection: TextDirection.rtl,
            ),
          ));
        }
        if (state is FeedBackNotAllowed) {
          // nameController.clear();
          // commentController.clear();
          ScaffoldMessenger.of(context).clearSnackBars();
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            duration: Duration(seconds: 3),
            content: Text(
              "يجب أن تقوم بتقديم طلب مساعدة واحد على الأقل قبل إرسال الفيدباك.",
              textDirection: TextDirection.rtl,
            ),
          ));
        }
        if (state is FeedBackFailure) {
          nameController.clear();
          commentController.clear();
          ScaffoldMessenger.of(context).clearSnackBars();
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            duration: Duration(seconds: 3),
            content: Text(
              "حدث خطأ يُرجى المحاولة فيما بعد",
              textDirection: TextDirection.rtl,
            ),
          ));
        }
      },
      builder: (context, state) {
        return Directionality(
            textDirection: TextDirection.rtl,
            child: Stack(
              children: [
                Scaffold(
                  backgroundColor: colorScheme.surface,
                  appBar: const ConstAppBar1(title: "إرسال الفيدباك"),
                  body: Form(
                    key: formKey,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 20, right: 20),
                      child: ListView(
                        children: [
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
                            padding: EdgeInsets.only(right: 5.0, left: 5),
                            child: Text(
                              "اسمك الظاهر للآخرين داخل التطبيق",
                              style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  color: colorScheme.primary,
                                  fontSize: 14),
                            ),
                          ),
                          const SizedBox(height: 8),
                          AuthCustomTextField(
                            hint: "",
                            icon: const Icon(null),
                            inputType: TextInputType.name,
                            mycontroller: nameController,
                            color: colorScheme.primary,
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
                                  color: colorScheme.primary,
                                  fontSize: 14),
                            ),
                          ),
                          const SizedBox(height: 8),
                          AuthCustomTextField(
                            hint: "",
                            icon: const Icon(null),
                            inputType: TextInputType.name,
                            mycontroller: commentController,
                            color: colorScheme.primary,
                            valid: (value) {
                              if (value!.isEmpty)
                                return "يجب عليك إدخال التعليق";

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
                                        user_name: nameController,
                                        message: commentController);
                              }
                            },
                            color: colorScheme.primary,
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
