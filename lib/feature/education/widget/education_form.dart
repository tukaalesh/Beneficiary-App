import 'package:charity_app/constants/custom_text.dart';
import 'package:charity_app/core/extensions/context_extensions.dart';
import 'package:flutter/material.dart';
import 'package:charity_app/auth/widgets/auth_button.dart';

class EducationForm extends StatefulWidget {
  final void Function(Map<String, dynamic> formData) onSubmit;
  final VoidCallback onBack;

  const EducationForm({
    super.key,
    required this.onBack,
    required this.onSubmit,
    required bool isLoading,
  });

  @override
  State<EducationForm> createState() => _EducationFormState();
}

class _EducationFormState extends State<EducationForm> {
  final formKey = GlobalKey<FormState>();

  final Map<String, bool> options = {
    'needsSchoolClothes': false,
    'needsCostUni': false,
    'needsSchoolSupplies': false,
  };

  final TextEditingController expectedCostController = TextEditingController();
  final TextEditingController numberOfNeedyController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();

  @override
  void dispose() {
    expectedCostController.dispose();
    numberOfNeedyController.dispose();
    descriptionController.dispose();
    super.dispose();
  }

  bool atLeastOneOptionSelected() {
    return options.values.any((selected) => selected);
  }

  void handleSubmit() {
    if (formKey.currentState?.validate() ?? false) {
      formKey.currentState!.save();

      List<String> neededEducationalHelp = [];
      if (options['needsSchoolClothes'] == true) {
        neededEducationalHelp.add("ثياب مدرسية");
      }
      if (options['needsSchoolSupplies'] == true) {
        neededEducationalHelp.add("مستلزمات دراسية");
      }
      if (options['needsCostUni'] == true) {
        neededEducationalHelp.add("أقساط جامعية");
      }

      final formData = {
        "expected_cost": int.tryParse(expectedCostController.text.trim()) ?? 0,
        "number_of_needy":
            int.tryParse(numberOfNeedyController.text.trim()) ?? 0,
        "description": descriptionController.text.trim(),
        "needed_educational_help": neededEducationalHelp,
      };

      widget.onSubmit(formData);
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDark = context.isDarkMode;
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
                  'يرجى إدخال هذه المعلومات بدقة ومصداقية تامة :',
                  style: TextStyle(color: Colors.red),
                ),
                const SizedBox(height: 16),
                Center(
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Image.asset('assets/images/education.png'),
                  ),
                ),
                const SizedBox(height: 20),
                const Text(
                  'نوع الاحتياج (يمكن اختيار أكثر من خيار):',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                FormField<bool>(
                  initialValue: atLeastOneOptionSelected(),
                  validator: (value) {
                    if (!atLeastOneOptionSelected()) {
                      return 'يرجى اختيار نوع الاحتياج واحد على الأقل';
                    }
                    return null;
                  },
                  builder: (field) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CheckboxListTile(
                          value: options['needsSchoolClothes'],
                          onChanged: (val) {
                            setState(() {
                              options['needsSchoolClothes'] = val ?? false;
                              field.didChange(atLeastOneOptionSelected());
                            });
                          },
                          title: Text("ثياب مدرسية",
                              style: TextStyle(
                                  color: isDark
                                      ? Colors.grey[400]
                                      : Colors.black)),
                          controlAffinity: ListTileControlAffinity.leading,
                        ),
                        CheckboxListTile(
                          value: options['needsSchoolSupplies'],
                          onChanged: (val) {
                            setState(() {
                              options['needsSchoolSupplies'] = val ?? false;
                              field.didChange(atLeastOneOptionSelected());
                            });
                          },
                          title: Text("مستلزمات دراسية",
                              style: TextStyle(
                                  color: isDark
                                      ? Colors.grey[400]
                                      : Colors.black)),
                          controlAffinity: ListTileControlAffinity.leading,
                        ),
                        CheckboxListTile(
                          value: options['needsCostUni'],
                          onChanged: (val) {
                            setState(() {
                              options['needsCostUni'] = val ?? false;
                              field.didChange(atLeastOneOptionSelected());
                            });
                          },
                          title: Text("أقساط جامعية",
                              style: TextStyle(
                                  color: isDark
                                      ? Colors.grey[400]
                                      : Colors.black)),
                          controlAffinity: ListTileControlAffinity.leading,
                        ),
                        if (field.hasError)
                          Padding(
                            padding: const EdgeInsets.only(left: 16, top: 4),
                            child: Text(
                              field.errorText ?? '',
                              style: const TextStyle(
                                color: Colors.red,
                                fontSize: 12,
                              ),
                            ),
                          ),
                      ],
                    );
                  },
                ),
            const SizedBox(height: 10),
            Divider(height: 30, thickness: 1, color: Colors.grey[300]),

                Align(
                  alignment: Alignment.centerRight,
                  child: Padding(
                    padding: const EdgeInsets.only(right: 15.0),
                    child: Text(
                      "التكلفة المتوقعة",
                      style: TextStyle(
                          fontSize: 14,
                          color: isDark ? Colors.grey[400] : Colors.black),
                    ),
                  ),
                ),
                const SizedBox(height: 8),
                Customtextfields(
                  mycontroller: expectedCostController,
                  hint: "مثلا: 200 الف",
                  inputType: TextInputType.number,
                  valid: (value) {
                    if (value == null || value.isEmpty) {
                      return "يجب كتابة المبلغ المتوقع";
                    }
                    if (double.tryParse(value) == null ||
                        double.parse(value) <= 0) {
                      return "يُرجى إدخال رقم صحيح وموجب";
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 10),
                Align(
                  alignment: Alignment.centerRight,
                  child: Padding(
                    padding: const EdgeInsets.only(right: 15.0),
                    child: Text(
                      "عدد الأفراد المحتاجين للمساعدة",
                      style: TextStyle(
                          fontSize: 14,
                          color: isDark ? Colors.grey[400] : Colors.black),
                    ),
                  ),
                ),
                const SizedBox(height: 8),
                Customtextfields(
                  mycontroller: numberOfNeedyController,
                  hint: "مثلاً: 2",
                  inputType: TextInputType.number,
                  valid: (value) {
                    if (value == null || value.isEmpty) {
                      return "يجب كتابة عدد الأفراد المحتاجين للمساعدة";
                    }
                    final numValue = int.tryParse(value);
                    if (numValue == null || numValue <= 0) {
                      return "يُرجى إدخال رقم صحيح وموجب";
                    }
                    if (numValue >= 20) {
                      return "يرجى إدخال عدد بين 1 و 19";
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 10),
                Align(
                  alignment: Alignment.centerRight,
                  child: Padding(
                    padding: const EdgeInsets.only(right: 15.0),
                    child: Text(
                      'وصف الحالة وسبب طلب المساعدة',
                      style: TextStyle(
                          fontSize: 14,
                          color: isDark ? Colors.grey[400] : Colors.black),
                    ),
                  ),
                ),
                const SizedBox(height: 8),
                Customtextfields(
                  mycontroller: descriptionController,
                  hint: "يرجى ذكر جميع التفاصيل, التي تساعدك على قبول طلبك",
                  inputType: TextInputType.text,
                  valid: (value) {
                    if (value == null || value.isEmpty) {
                      return 'يرجى إدخال الوصف';
                    }
                    final firstChar = value.trim().characters.first;
                    final isValidStart =
                        RegExp(r'^[a-zA-Zء-ي]$').hasMatch(firstChar);

                    if (!isValidStart) {
                      return 'يجب أن يبدأ الوصف بأحرف ';
                    }
                    return null;
                  },
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
