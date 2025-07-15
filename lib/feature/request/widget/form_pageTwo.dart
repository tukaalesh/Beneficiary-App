import 'package:charity_app/constants/const_image.dart';
import 'package:charity_app/core/extensions/context_extensions.dart';
import 'package:flutter/material.dart';
import 'package:charity_app/auth/widgets/auth_button.dart';
import 'package:charity_app/feature/request/widget/custom_textField.dart';

class FormPageTwo extends StatefulWidget {
  final void Function(Map<String, dynamic> formData) onSubmit;
  final VoidCallback onBack;
  final ColorScheme colorScheme;

  const FormPageTwo({
    super.key,
    required this.onSubmit,
    required this.onBack,
    required this.colorScheme,
  });

  @override
  State<FormPageTwo> createState() => _FormPageTwoState();
}

class _FormPageTwoState extends State<FormPageTwo> {
  final formKey = GlobalKey<FormState>();

  final Map<String, dynamic> options = {
    'needsFoodBasket': false,
    'needsBabyMilk': false,
  };

  bool isOnlyDigits(String str) {
    final regExp = RegExp(r'^\d+$');
    return regExp.hasMatch(str);
  }

  void handleSubmit() {
    if (formKey.currentState?.validate() ?? false) {
      formKey.currentState!.save();
      widget.onSubmit(options);
    }
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = context.colorScheme;
    return Scaffold(
      backgroundColor: widget.colorScheme.surface,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Form(
            key: formKey,
            child: ListView(
              children: [
                const Text(
                  'يرجى إدخال هذه المعلومات بدقة ومصداقية تامة :',
                  style: TextStyle(color: Colors.red),
                ),

                const SizedBox(height: 16),

                Center(
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: nutritional,
                  ),
                ),

                const SizedBox(height: 20),

                const Text(
                  'نوع الاحتياج (يمكن اختيار أكثر من خيار):',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),

                CheckboxListTile(
                  value: options['needsFoodBasket'],
                  onChanged: (val) =>
                      setState(() => options['needsFoodBasket'] = val ?? false),
                  title: const Text("سلة غذائية"),
                  controlAffinity: ListTileControlAffinity.leading,
                ),

                CheckboxListTile(
                  value: options['needsBabyMilk'],
                  onChanged: (val) =>
                      setState(() => options['needsBabyMilk'] = val ?? false),
                  title: const Text("حليب أطفال"),
                  controlAffinity: ListTileControlAffinity.leading,
                ),

                const SizedBox(height: 10),

                Customtextfields(
                  hint: 'الكلفة المتوقعة',
                  inputType: TextInputType.number,
                  valid: (value) {
                    if (value == null || value.isEmpty) {
                      return 'مطلوب إدخال الكلفة';
                    }
                    if (!isOnlyDigits(value)) {
                      return 'يرجى إدخال أرقام فقط';
                    }
                    return null;
                  },
                  onSaved: (value) =>
                      options['estimatedCost'] = value?.trim() ?? '',
                ),

                const SizedBox(height: 10),

                Customtextfields(
                  hint: 'وصف الحالة وسبب طلب المساعدة',
                  inputType: TextInputType.multiline,
                  maxLines: 5,
                  valid: (value) {
                    if (value == null || value.isEmpty) {
                      return 'يرجى إدخال الوصف';
                    }
                    return null;
                  },
                  onSaved: (value) =>
                      options['description'] = value?.trim() ?? '',
                ),

                const SizedBox(height: 20),

                Row(
                  children: [
                    Expanded(
                      child: Authbutton(
                        buttonText: 'السابق',
                        onPressed: widget.onBack,
                        color: colorScheme.primary,
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Authbutton(
                        buttonText: 'إرسال',
                        onPressed: handleSubmit,
                        color: colorScheme.secondary,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
