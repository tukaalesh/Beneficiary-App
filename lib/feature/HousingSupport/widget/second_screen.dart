// ignore_for_file: unnecessary_to_list_in_spreads, deprecated_member_use

import 'package:charity_app/auth/widgets/auth_button.dart';
import 'package:charity_app/constants/custom_text.dart';
import 'package:flutter/material.dart';

class SecondHousingScreen extends StatefulWidget {
  final GlobalKey<FormState> formKey;

  final TextEditingController descriptionController;
  final TextEditingController numberOfPeopleNeedingHousingController;

  final String? selectedHousingStatus;
  final String? selectedHelpType;

  final ValueChanged<String?> onHousingStatusChanged;
  final ValueChanged<String?> onHelpTypeChanged;

  final VoidCallback onPrevious;
  final VoidCallback onSubmit;
  final ColorScheme colorScheme;

  const SecondHousingScreen({
    super.key,
    required this.formKey,
    required this.descriptionController,
    required this.numberOfPeopleNeedingHousingController,
    required this.selectedHousingStatus,
    required this.selectedHelpType,
    required this.onHousingStatusChanged,
    required this.onHelpTypeChanged,
    required this.onPrevious,
    required this.onSubmit,
    required this.colorScheme,
  });

  @override
  State<SecondHousingScreen> createState() => _SecondScreenState();
}

class _SecondScreenState extends State<SecondHousingScreen> {
  final List<String> _optionsList = ['ملك', 'أجار', 'استضافة', 'لا يوجد سكن'];
  final List<String> _type = [
    'إصلاحات منزلية',
    'مساعدة في دفع الإيجار',
    'تأمين سكن'
  ];

  @override
  Widget build(BuildContext context) {
    return Form(
      key: widget.formKey,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 25.0),
        child: ListView(
          children: [
            const Padding(
              padding: EdgeInsets.only(right: 9.0),
              child: Text(
                'يرجى إدخال هذه المعلومات بدقة ومصداقية تامة',
                style: TextStyle(fontSize: 13, color: Colors.red),
              ),
            ),
            const SizedBox(height: 10),
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.asset(
                "assets/images/سكني.png",
                color: Colors.white.withOpacity(0.5),
                colorBlendMode: BlendMode.dstATop,
              ),
            ),
            const SizedBox(height: 20),

            // حالة السكن الحالية
            const Align(
              alignment: Alignment.centerRight,
              child: Padding(
                padding: EdgeInsets.only(right: 15.0),
                child: Text(
                  "حالة السكن الحالية",
                  style: TextStyle(fontSize: 14),
                ),
              ),
            ),
            ..._optionsList.map((option) {
              return CheckboxListTile(
                visualDensity: const VisualDensity(vertical: -4),
                side: const BorderSide(color: Colors.grey, width: 1),
                title: Text(option, style: const TextStyle(fontSize: 14)),
                value: widget.selectedHousingStatus == option,
                onChanged: (val) => widget.onHousingStatusChanged(option),
                controlAffinity: ListTileControlAffinity.leading,
                activeColor: widget.colorScheme.secondary,
              );
            }).toList(),
            if (widget.selectedHousingStatus == null)
              const Padding(
                padding: EdgeInsets.only(right: 15.0, top: 5.0),
                child: Text(
                  "يجب اختيار حالة السكن الحالية",
                  style: TextStyle(color: Colors.red, fontSize: 13),
                ),
              ),

            const SizedBox(height: 10),
            Divider(height: 30, thickness: 1, color: Colors.grey[300]),

            // نوع المساعدة المطلوبة
            const Align(
              alignment: Alignment.centerRight,
              child: Padding(
                padding: EdgeInsets.only(right: 15.0),
                child: Text(
                  "نوع المساعدة المطلوبة",
                  style: TextStyle(fontSize: 14),
                ),
              ),
            ),
            ..._type.map((option) {
              return CheckboxListTile(
                visualDensity: const VisualDensity(vertical: -4),
                side: const BorderSide(color: Colors.grey, width: 1),
                title: Text(option, style: const TextStyle(fontSize: 14)),
                value: widget.selectedHelpType == option,
                onChanged: (val) => widget.onHelpTypeChanged(option),
                controlAffinity: ListTileControlAffinity.leading,
                activeColor: widget.colorScheme.secondary,
              );
            }).toList(),
            if (widget.selectedHelpType == null)
              const Padding(
                padding: EdgeInsets.only(right: 15.0, top: 5.0),
                child: Text(
                  "يجب اختيار نوع المساعدة المطلوبة",
                  style: TextStyle(color: Colors.red, fontSize: 13),
                ),
              ),

            Divider(height: 30, thickness: 1, color: Colors.grey[300]),

            // وصف الحالة
            const Align(
              alignment: Alignment.centerRight,
              child: Padding(
                padding: EdgeInsets.only(right: 15.0),
                child: Text(
                  "وصف الحالة وسبب طلب المساعدة",
                  style: TextStyle(fontSize: 14),
                ),
              ),
            ),
            const SizedBox(height: 8),
            Customtextfields(
              hint: "(يرجى تقديم أكبر قدر ممكن من التفاصيل لدعم طلبك)",
              inputType: TextInputType.text,
              mycontroller: widget.descriptionController,
              valid: (value) {
                if (value == null || value.isEmpty) {
                  return "يجب عليك الإجابة على هذا السؤال";
                }
                return null;
              },
            ),

            const SizedBox(height: 20),

            // عدد الأفراد
            const Align(
              alignment: Alignment.centerRight,
              child: Padding(
                padding: EdgeInsets.only(right: 15.0),
                child: Text(
                  "عدد الأفراد المحتاجين للسكن",
                  style: TextStyle(fontSize: 14),
                ),
              ),
            ),
            const SizedBox(height: 8),
            Customtextfields(
              hint: "مثلاً: 2",
              inputType: TextInputType.number,
              mycontroller: widget.numberOfPeopleNeedingHousingController,
              valid: (value) {
                if (value == null || value.isEmpty) {
                  return "يجب كتابة عدد الأفراد المحتاجين للسكن";
                }
                if (double.tryParse(value) == null ||
                    double.parse(value) <= 0 ||
                    double.parse(value) >= 20) {
                  return "يرجى إدخال الرقم بطريقة صحيحة";
                }

                return null;
              },
            ),

            const SizedBox(height: 10),
            Divider(height: 30, thickness: 1, color: Colors.grey[300]),

            // الأزرار
            Padding(
              padding: const EdgeInsets.only(bottom: 20, top: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Authbutton(
                      buttonText: "السابق",
                      onPressed: widget.onPrevious,
                      color: widget.colorScheme.primary,
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Authbutton(
                      buttonText: "إرسال",
                      onPressed: () {
                        if (widget.formKey.currentState!.validate()) {
                          if (widget.selectedHousingStatus == null ||
                              widget.selectedHelpType == null) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text(
                                    "يرجى اختيار حالة السكن ونوع المساعدة"),
                              ),
                            );
                          } else {
                            widget.onSubmit();
                          }
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content:
                                  Text("الرجاء تعبئة جميع الحقول المطلوبة."),
                            ),
                          );
                        }
                      },
                      color: widget.colorScheme.secondary,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
