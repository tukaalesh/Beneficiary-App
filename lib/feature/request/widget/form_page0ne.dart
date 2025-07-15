import 'package:charity_app/core/extensions/context_extensions.dart';
import 'package:flutter/material.dart';
import 'package:charity_app/auth/widgets/auth_button.dart';
import 'package:charity_app/feature/request/widget/custom_textField.dart';

class FormPageOne extends StatefulWidget {
  final void Function(Map<String, String> formData) onNext;

  const FormPageOne({ super.key, required this.onNext});

  @override
  State<FormPageOne> createState() => _FormPageOneState();
}

class _FormPageOneState extends State<FormPageOne> {
  final formKey = GlobalKey<FormState>();

  
  final Map<String, String> formData = {};

  bool isOnlyDigits(String str) {
    final regExp = RegExp(r'^\d+$');
    return regExp.hasMatch(str);
  }
  bool isOnlyLetters(String str) {
    final regExp = RegExp(r'^[\p{L} ]+$', unicode: true);
    return regExp.hasMatch(str);
  }
  int countWords(String str) {
    return str.trim().split(RegExp(r'\s+')).length;
  }

  void handleNext() {
    if (formKey.currentState?.validate() ?? false) {
      formKey.currentState!.save();
      widget.onNext(formData); 
    }
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = context.colorScheme;
    return Scaffold(
      backgroundColor: colorScheme.surface,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Form(
            key: formKey,
            child: ListView(
              children: [
                const Text(
                  'يرجى تعبئة هذا النموذج بدقة ومصداقية تامة :',
                  style: TextStyle(color: Colors.red),
                ),
                const SizedBox(height: 20),

                Customtextfields(
                  hint: 'الاسم الثلاثي',
                  inputType: TextInputType.name,
                  valid: (value) {
                    if (value == null || value.isEmpty) return 'يرجى إدخال الاسم الثلاثي';
                    if (!isOnlyLetters(value)) return 'يرجى إدخال حروف فقط';
                    return null;
                  },
                  onSaved: (value) => formData['fullName'] = value ?? '',
                ),
                const SizedBox(height: 10),

                Customtextfields(
                  hint: 'العمر',
                  inputType: TextInputType.number,
                  valid: (value) {
                    if (value == null || value.isEmpty) return 'يرجى إدخال العمر';
                    if (!isOnlyDigits(value)) return 'يرجى إدخال أرقام فقط';
                    return null;
                  },
                  onSaved: (value) => formData['age'] = value ?? '',
                ),
                const SizedBox(height: 10),

              Customtextfields(
  hint: 'رقم الهاتف',
  inputType: TextInputType.phone,
  valid: (value) {
    if (value == null || value.isEmpty) return 'يرجى إدخال رقم الهاتف';
    if (!isOnlyDigits(value)) return 'يرجى إدخال أرقام فقط';
    if (!value.startsWith('09')) return 'يجب أن يبدأ رقم الهاتف بـ 09';
    if (value.length != 10) return 'رقم الهاتف يجب أن يتألف من 10 أرقام';
    return null;
  },
  onSaved: (value) => formData['phone'] = value ?? '',
),

                const SizedBox(height: 10),

                Customtextfields(
                  hint: 'عدد الأولاد',
                  inputType: TextInputType.number,
                  valid: (value) {
                    if (value == null || value.isEmpty) return 'يرجى إدخال عدد الأولاد';
                    if (!isOnlyDigits(value)) return 'يرجى إدخال أرقام ';
                    return null;
                  },
                  onSaved: (value) => formData['childrenCount'] = value ?? '',
                ),
                const SizedBox(height: 10),

                Customtextfields(
                  hint: 'تفاصيل الأولاد',
                  inputType: TextInputType.text,
                  valid: (value) {
                    if (value == null || value.isEmpty) return 'يرجى إدخال تفاصيل الأولاد';
                    if (countWords(value) < 10) return 'الرجاء كتابة 10 كلمة على الأقل';
                    return null;
                  },
                  onSaved: (value) => formData['childrenDetails'] = value ?? '',
                ),
                const SizedBox(height: 10),

                Customtextfields(
                  hint: 'عنوان السكن بالتفصيل',
                  inputType: TextInputType.streetAddress,
                  valid: (value) {
                    if (value == null || value.isEmpty) return 'يرجى إدخال عنوان السكن بالتفصيل';
                    return null;
                  },
                  onSaved: (value) => formData['address'] = value ?? '',
                ),
                const SizedBox(height: 10),

                Customtextfields(
                  hint: 'الدخل الشهري للعائلة',
                  inputType: TextInputType.number,
                  valid: (value) {
                    if (value == null || value.isEmpty) return 'يرجى إدخال الدخل الشهري للعائلة';
                    if (!isOnlyDigits(value)) return 'يرجى إدخال أرقام فقط';
                    if (value.startsWith('0')) return 'لا يمكن أن يبدأ الدخل بـ 0';
                    return null;
                  },
                  onSaved: (value) => formData['monthlyIncome'] = value ?? '',
                ),
                const SizedBox(height: 10),

                Customtextfields(
                  hint: 'العمل الحالي',
                  inputType: TextInputType.text,
                  valid: (value) {
                    if (value == null || value.isEmpty) return 'يرجى إدخال العمل الحالي ';
                    if (!isOnlyLetters(value)) return 'يرجى إدخال حروف فقط';
                    return null;
                  },
                  onSaved: (value) => formData['currentJob'] = value ?? '',
                ),

                const SizedBox(height: 20),
                Authbutton(
                  buttonText: 'التالي',
                  onPressed: handleNext,
                  color: colorScheme.primary,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
