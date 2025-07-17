import 'package:charity_app/auth/widgets/auth_button.dart';
import 'package:charity_app/constants/custom_text.dart';
import 'package:flutter/material.dart';

class FirstHealthScreen extends StatelessWidget {
  final TextEditingController fullNameController;
  final TextEditingController ageController;
  final TextEditingController phoneNumberController;
  final TextEditingController numberOfChildrenController;
  final TextEditingController childrenDetailsController;
  final TextEditingController addressController;
  final TextEditingController monthlyIncomeController;
  final TextEditingController currentJobController;
  final VoidCallback onNext;
  final ColorScheme colorScheme;

  const FirstHealthScreen({
    super.key,
    required this.fullNameController,
    required this.ageController,
    required this.phoneNumberController,
    required this.numberOfChildrenController,
    required this.childrenDetailsController,
    required this.addressController,
    required this.monthlyIncomeController,
    required this.currentJobController,
    required this.onNext,
    required this.colorScheme,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25.0),
      child: ListView(
        children: [
          const Padding(
            padding: EdgeInsets.only(right: 0.0),
            child: Text(
              'يرجى تعبئة هذا الفورم بدقة ومصداقية تامة',
              style: TextStyle(fontSize: 13, color: Colors.red),
            ),
          ),
          const SizedBox(height: 20),

          const Align(
            alignment: Alignment.centerRight,
            child: Padding(
              padding: EdgeInsets.only(right: 15.0),
              child: Text(
                "الاسم الكامل",
                style: TextStyle(fontSize: 14),
              ),
            ),
          ),
          const SizedBox(height: 8),
          Customtextfields(
            hint: "ادخل الأسم الثلاثي",
            inputType: TextInputType.text,
            mycontroller: fullNameController,
            valid: (value) {
              if (value == null || value.isEmpty) {
                return "الرجاء إدخال الاسم الكامل";
              }
              return null;
            },
          ),
          const SizedBox(height: 15),

          // حقل العمر
          const Align(
            alignment: Alignment.centerRight,
            child: Padding(
              padding: EdgeInsets.only(right: 15.0),
              child: Text(
                "العمر",
                style: TextStyle(fontSize: 14),
              ),
            ),
          ),
          const SizedBox(height: 8),
          Customtextfields(
            hint: "ادخل العمر",
            inputType: TextInputType.number,
            mycontroller: ageController,
            valid: (value) {
              if (value == null || value.isEmpty) {
                return "الرجاء إدخال العمر";
              }
              if (int.tryParse(value) == null || int.parse(value) <= 0) {
                return "الرجاء إدخال عمر صحيح";
              }
              return null;
            },
          ),
          const SizedBox(height: 15),

          const Align(
            alignment: Alignment.centerRight,
            child: Padding(
              padding: EdgeInsets.only(right: 15.0),
              child: Text(
                "رقم الهاتف",
                style: TextStyle(fontSize: 14),
              ),
            ),
          ),
          const SizedBox(height: 8),
          Customtextfields(
            hint: "ادخل رقم الهاتف",
            inputType: TextInputType.phone,
            mycontroller: phoneNumberController,
            valid: (value) {
              if (value == null || value.isEmpty) {
                return "الرجاء إدخال رقم الهاتف";
              }
              return null;
            },
          ),
          const SizedBox(height: 15),

          const Align(
            alignment: Alignment.centerRight,
            child: Padding(
              padding: EdgeInsets.only(right: 15.0),
              child: Text(
                "عدد الأولاد",
                style: TextStyle(fontSize: 14),
              ),
            ),
          ),
          const SizedBox(height: 8),
          Customtextfields(
            hint: "ادخل عدد الأولاد",
            inputType: TextInputType.number,
            mycontroller: numberOfChildrenController,
            valid: (value) {
              if (value == null || value.isEmpty) {
                return "الرجاء إدخال عدد الأولاد";
              }
              if (int.tryParse(value) == null || int.parse(value) < 0) {
                return "الرجاء إدخال عدد صحيح وموجب";
              }
              return null;
            },
          ),
          const SizedBox(height: 15),

          const Align(
            alignment: Alignment.centerRight,
            child: Padding(
              padding: EdgeInsets.only(right: 15.0),
              child: Text(
                "تفاصيل الأولاد",
                style: TextStyle(fontSize: 14),
              ),
            ),
          ),
          const SizedBox(height: 8),
          Customtextfields(
            hint: "ادخل تفاصيل الأولاد",
            inputType: TextInputType.text,
            mycontroller: childrenDetailsController,
            valid: (value) {
              if (value == null || value.isEmpty) {
                return "الرجاء إدخال تفاصيل الأولاد";
              }
              return null;
            },
          ),
          const SizedBox(height: 15),

          const Align(
            alignment: Alignment.centerRight,
            child: Padding(
              padding: EdgeInsets.only(right: 15.0),
              child: Text(
                "عنوان السكن بالتفصيل",
                style: TextStyle(fontSize: 14),
              ),
            ),
          ),
          const SizedBox(height: 8),
          Customtextfields(
            hint: "ادخل عنوان السكن بالتفصيل",
            inputType: TextInputType.text,
            mycontroller: addressController,
            valid: (value) {
              if (value == null || value.isEmpty) {
                return "الرجاء إدخال عنوان السكن";
              }
              return null;
            },
          ),
          const SizedBox(height: 15),

          const Align(
            alignment: Alignment.centerRight,
            child: Padding(
              padding: EdgeInsets.only(right: 15.0),
              child: Text(
                "مستوى الدخل الشهري للعائلة",
                style: TextStyle(fontSize: 14),
              ),
            ),
          ),
          const SizedBox(height: 8),
          Customtextfields(
            hint: "ادخل مستوى الدخل الشهري للعائلة",
            inputType: TextInputType.number,
            mycontroller: monthlyIncomeController,
            valid: (value) {
              if (value == null || value.isEmpty) {
                return "الرجاء إدخال مستوى الدخل";
              }
              if (double.tryParse(value) == null || double.parse(value) < 0) {
                return "الرجاء إدخال رقم صحيح وموجب";
              }
              return null;
            },
          ),
          const SizedBox(height: 15),

          const Align(
            alignment: Alignment.centerRight,
            child: Padding(
              padding: EdgeInsets.only(right: 15.0),
              child: Text(
                "العمل الحالي",
                style: TextStyle(fontSize: 14),
              ),
            ),
          ),
          const SizedBox(height: 8),
          Customtextfields(
            hint: "ادخل العمر الحالي",
            inputType: TextInputType.text,
            mycontroller: currentJobController,
            valid: (value) {
              if (value == null || value.isEmpty) {
                return "الرجاء إدخال العمل الحالي";
              }
              return null;
            },
          ),
          const SizedBox(height: 30),

          Padding(
            padding: const EdgeInsets.only(bottom: 20),
            child: Authbutton(
              buttonText: "التالي",
              onPressed: onNext,
              color: colorScheme.primary,
            ),
          ),
        ],
      ),
    );
  }
}
