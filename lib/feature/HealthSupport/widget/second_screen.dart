// ignore_for_file: unnecessary_to_list_in_spreads

import 'dart:io';
import 'package:charity_app/auth/widgets/auth_button.dart';
import 'package:charity_app/constants/custom_text.dart';
import 'package:flutter/material.dart';

class SecondHealthScreen extends StatefulWidget {
  final TextEditingController descriptionController;
  final TextEditingController expectedCostController;
  final String? selectedOption;
  final ValueChanged<String?> onOptionChanged;
  final VoidCallback onPrevious;
  final VoidCallback onSubmit;
  final ColorScheme colorScheme;

  const SecondHealthScreen({
    super.key,
    required this.descriptionController,
    required this.expectedCostController,
    required this.selectedOption,
    required this.onOptionChanged,
    required this.onPrevious,
    required this.onSubmit,
    required this.colorScheme,
  });

  @override
  State<SecondHealthScreen> createState() => _SecondScreenState();
}

class _SecondScreenState extends State<SecondHealthScreen> {
  final List<String> _optionsList = [
    "حرج",
    "متوسط",
    "منخفض",
  ];

  @override
  Widget build(BuildContext context) {
    return Padding(
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
              'assets/images/صحي.png',
              color: Colors.white.withOpacity(0.5),
              colorBlendMode: BlendMode.dstATop,
            ),
          ),

          const SizedBox(height: 20),

          const Align(
            alignment: Alignment.centerRight,
            child: Padding(
              padding: EdgeInsets.only(right: 15.0),
              child: Text(
                "ما مدى درجة الخطورة:",
                style: TextStyle(fontSize: 14),
              ),
            ),
          ),
          ..._optionsList.map((option) {
            return CheckboxListTile(
              visualDensity: const VisualDensity(vertical: -4),
              side: const BorderSide(color: Colors.grey, width: 1),
              title: Text(option, style: const TextStyle(fontSize: 13)),
              value: widget.selectedOption == option,
              onChanged: (val) {
                widget.onOptionChanged(option);
              },
              controlAffinity: ListTileControlAffinity.leading,
              activeColor: widget.colorScheme.secondary,
            );
          }).toList(),
          if (widget.selectedOption == null)
            const Padding(
              padding: EdgeInsets.only(right: 15.0, top: 5.0),
              child: Text(
                'الرجاء اختيار درجة الخطورة',
                style: TextStyle(color: Colors.red, fontSize: 12),
              ),
            ),

          // const SizedBox(height: 10),
          Divider(height: 30, thickness: 1, color: Colors.grey[300]),
          // const SizedBox(height: 15),

          const Align(
            alignment: Alignment.centerRight,
            child: Padding(
              padding: EdgeInsets.only(right: 15.0),
              child: Text(
                "يرجى وصف حالتك الصحية بوضوح وسبب طلب المساعدة",
                style: TextStyle(fontSize: 14),
              ),
            ),
          ),
          const SizedBox(height: 8),
          Customtextfields(
            hint: "أذكر الأعراض، تاريخ المرض، وأي تفاصيل أخرى ذات صلة\n ",
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
          const Align(
            alignment: Alignment.centerRight,
            child: Padding(
              padding: EdgeInsets.only(right: 15.0),
              child: Text(
                "التكلفة المتوقعة",
                style: TextStyle(fontSize: 14),
              ),
            ),
          ),
          const SizedBox(height: 8),
          Customtextfields(
            hint: "مثلا: 200 الف ",
            inputType: TextInputType.number,
            mycontroller: widget.expectedCostController,
            valid: (value) {
              if (value == null || value.isEmpty) {
                return "يجب كتابة المبلغ المتوقع";
              }
              if (double.tryParse(value) == null || double.parse(value) <= 0) {
                return "يُرجى إدخال رقم صحيح وموجب";
              }
              return null;
            },
          ),

          // // قسم الوثائق الطبية
          // const Align(
          //   alignment: Alignment.centerRight,
          //   child: Padding(
          //     padding: EdgeInsets.only(right: 15.0),
          //     child: Text(
          //       'الوثائق الطبية',
          //       style: TextStyle(
          //         fontSize: 14,
          //       ),
          //     ),
          //   ),
          // ),
          const SizedBox(height: 10),

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
                      // تحقق إضافي لدرجة الخطورة قبل الإرسال
                      if (widget.selectedOption == null) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                              content: Text('الرجاء اختيار درجة الخطورة.')),
                        );
                      } else {
                        widget.onSubmit();
                      }
                    },
                    color: widget.colorScheme.secondary,
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
