import 'package:charity_app/constants/custom_text.dart';
import 'package:charity_app/core/extensions/context_extensions.dart';
import 'package:flutter/material.dart';
import 'package:charity_app/auth/widgets/auth_button.dart';

class FirstHousingScreen extends StatelessWidget {
  final GlobalKey<FormState> formKey;
  final void Function() onNext;

  final TextEditingController fullNameController;
  final TextEditingController ageController;
  final TextEditingController phoneNumberController;
  final TextEditingController numberOfChildrenController;
  final TextEditingController childrenDetailsController;
  final TextEditingController addressController;
  final TextEditingController monthlyIncomeController;
  final TextEditingController currentJobController;

  final String? initialMaritalStatus;
  final ValueChanged<String?> onMaritalStatusChanged;
  final String? initialIncomeSource;
  final ValueChanged<String?> onIncomeSourceChanged;
  final String? initialGovernorate;
  final ValueChanged<String?> onGovernorateChanged;
  final String? initialGender;
  final ValueChanged<String?> onGenderChanged;

  const FirstHousingScreen({
    super.key,
    required this.formKey,
    required this.onNext,
    required this.fullNameController,
    required this.ageController,
    required this.phoneNumberController,
    required this.numberOfChildrenController,
    required this.childrenDetailsController,
    required this.addressController,
    required this.monthlyIncomeController,
    required this.currentJobController,
    this.initialMaritalStatus,
    required this.onMaritalStatusChanged,
    this.initialIncomeSource,
    required this.onIncomeSourceChanged,
    this.initialGovernorate,
    required this.onGovernorateChanged,
    this.initialGender,
    required this.onGenderChanged,
  });

  final List<String> governorates = const [
    'دمشق',
    'ريف دمشق',
    'حماة',
    'حمص',
    'حلب',
    'اللاذقية',
    'ادلب'
  ];

  final List<String> maritalStatuses = const [
    'أعزب',
    'متزوج',
    'مطلق',
    'أرمل',
  ];

  final List<String> incomeSources = const [
    'لا يوجد دخل',
    'راتب تقاعدي',
    'مساعدات من أقارب',
    'مساعدات من جمعيات',
    'عمل',
  ];

  final List<String> genders = const [
    'ذكر',
    'أنثى',
  ];

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
                const SizedBox(height: 24),
                const Align(
                  alignment: Alignment.centerRight,
                  child: Padding(
                    padding: EdgeInsets.only(right: 15.0),
                    child: Text('الاسم الثلاثي',
                        style: TextStyle(
                          fontSize: 14,
                        )),
                  ),
                ),
                const SizedBox(height: 8),
                Customtextfields(
                  mycontroller: fullNameController,
                  hint: ' الاسم الثلاثي',
                  inputType: TextInputType.name,
                  valid: (value) {
                    if (value == null || value.isEmpty) {
                      return "الرجاء إدخال الاسم الثلاثي";
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                const Align(
                  alignment: Alignment.centerRight,
                  child: Padding(
                    padding: EdgeInsets.only(right: 15.0),
                    child: Text('العمر',
                        style: TextStyle(
                          fontSize: 14,
                        )),
                  ),
                ),
                const SizedBox(height: 8),
                Customtextfields(
                  mycontroller: ageController,
                  hint: 'العمر',
                  inputType: TextInputType.number,
                  valid: (value) {
                    if (value == null || value.isEmpty) {
                      return "الرجاء إدخال العمر";
                    }
                    if (int.tryParse(value) == null || int.parse(value) <= 0) {
                      return "الرجاء إدخال عمر صحيح";
                    }
                    if (int.tryParse(value) == null ||
                        int.parse(value) >= 100) {
                      return "يرجى إدخال العمر بطريقة صحيحة ";
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                const Align(
                  alignment: Alignment.centerRight,
                  child: Padding(
                    padding: EdgeInsets.only(right: 15.0),
                    child: Text('الحالة الاجتماعية',
                        style: TextStyle(
                          fontSize: 14,
                        )),
                  ),
                ),
                const SizedBox(height: 8),
                DropdownButtonFormField<String>(
                  value: initialMaritalStatus,
                  hint: const Text("اختر الحالة الاجتماعية"),
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12)),
                    contentPadding: const EdgeInsets.symmetric(
                        horizontal: 10, vertical: 14),
                  ),
                  items: maritalStatuses
                      .map((status) => DropdownMenuItem(
                            value: status,
                            child: Text(status),
                          ))
                      .toList(),
                  onChanged: onMaritalStatusChanged,
                  validator: (val) => (val == null || val.isEmpty)
                      ? "يرجى اختيار الحالة الاجتماعية"
                      : null,
                ),
                const SizedBox(height: 16),
                const Align(
                  alignment: Alignment.centerRight,
                  child: Padding(
                    padding: EdgeInsets.only(right: 15.0),
                    child: Text('رقم الهاتف',
                        style: TextStyle(
                          fontSize: 14,
                        )),
                  ),
                ),
                const SizedBox(height: 8),
                Customtextfields(
                  mycontroller: phoneNumberController,
                  hint: ' رقم هاتف يبدأ بـ 09',
                  inputType: TextInputType.phone,
                  valid: (value) {
                    if (value == null || value.isEmpty) {
                      return 'يرجى إدخال رقم الهاتف';
                    }
                    if (!value.startsWith('09')) {
                      return 'يجب أن يبدأ رقم الهاتف بـ 09';
                    }
                    if (value.length != 10) {
                      return 'رقم الهاتف يجب أن يتألف من 10 أرقام';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                const Align(
                  alignment: Alignment.centerRight,
                  child: Padding(
                    padding: EdgeInsets.only(right: 15.0),
                    child: Text('الجنس',
                        style: TextStyle(
                          fontSize: 14,
                        )),
                  ),
                ),
                Row(
                  children: [
                    Expanded(
                      child: RadioListTile<String>(
                        title: const Text(
                          'أنثى',
                          style: TextStyle(fontSize: 14),
                        ),
                        value: 'أنثى',
                        groupValue: initialGender,
                        onChanged: onGenderChanged,
                      ),
                    ),
                    Expanded(
                      child: RadioListTile<String>(
                        title: const Text(
                          'ذكر',
                          style: TextStyle(fontSize: 14),
                        ),
                        value: 'ذكر',
                        groupValue: initialGender,
                        onChanged: onGenderChanged,
                      ),
                    ),
                  ],
                ),
                if (initialGender == null)
                  const Padding(
                    padding: EdgeInsets.only(right: 15.0, top: 4.0),
                    child: Text(
                      'الرجاء اختيار الجنس',
                      style: TextStyle(color: Colors.red, fontSize: 12),
                    ),
                  ),
                const SizedBox(height: 8),
                const Align(
                  alignment: Alignment.centerRight,
                  child: Padding(
                    padding: EdgeInsets.only(right: 15.0),
                    child: Text('عدد الأولاد',
                        style: TextStyle(
                          fontSize: 14,
                        )),
                  ),
                ),
                const SizedBox(height: 8),
                Customtextfields(
                  mycontroller: numberOfChildrenController,
                  hint: "مثلاً: 2",
                  inputType: TextInputType.number,
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
                const SizedBox(height: 16),
                const Align(
                  alignment: Alignment.centerRight,
                  child: Padding(
                    padding: EdgeInsets.only(right: 15.0),
                    child: Text('تفاصيل الأولاد',
                        style: TextStyle(
                          fontSize: 14,
                        )),
                  ),
                ),
                const SizedBox(height: 8),
                Customtextfields(
                  mycontroller: childrenDetailsController,
                  hint: ' (أعمارهم _حالتهم_دراستهم الحالية) ',
                  inputType: TextInputType.text,
                  valid: (value) {
                    if (value == null || value.isEmpty) {
                      return "الرجاء إدخال تفاصيل الأولاد";
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                const Align(
                  alignment: Alignment.centerRight,
                  child: Padding(
                    padding: EdgeInsets.only(right: 15.0),
                    child: Text('عنوان السكن',
                        style: TextStyle(
                          fontSize: 14,
                        )),
                  ),
                ),
                const SizedBox(height: 8),
                Customtextfields(
                  mycontroller: addressController,
                  hint: 'عنوان السكن بالتفصيل',
                  inputType: TextInputType.streetAddress,
                  valid: (value) {
                    if (value == null || value.isEmpty) {
                      return "الرجاء إدخال عنوان السكن بالتفصيل";
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 10),
                const Align(
                  alignment: Alignment.centerRight,
                  child: Padding(
                    padding: EdgeInsets.only(right: 15.0),
                    child: Text('المحافظة',
                        style: TextStyle(
                          fontSize: 14,
                        )),
                  ),
                ),
                const SizedBox(height: 8),
                DropdownButtonFormField<String>(
                  value: initialGovernorate,
                  hint: const Text("اختر المحافظة"),
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12)),
                    contentPadding: const EdgeInsets.symmetric(
                        horizontal: 10, vertical: 14),
                  ),
                  items: governorates
                      .map((g) => DropdownMenuItem(value: g, child: Text(g)))
                      .toList(),
                  onChanged: onGovernorateChanged,
                  validator: (val) => (val == null || val.isEmpty)
                      ? "الرجاء اختيار المحافظة"
                      : null,
                ),
                const SizedBox(height: 16),
                const Align(
                  alignment: Alignment.centerRight,
                  child: Padding(
                    padding: EdgeInsets.only(right: 15.0),
                    child: Text('الدخل الشهري للعائلة',
                        style: TextStyle(
                          fontSize: 14,
                        )),
                  ),
                ),
                const SizedBox(height: 8),
                Customtextfields(
                  mycontroller: monthlyIncomeController,
                  hint: 'المدخول الشهري مثلاً :400',
                  inputType: TextInputType.number,
                  valid: (value) {
                    if (value == null || value.isEmpty) {
                      return 'يرجى إدخال الدخل الشهري للعائلة';
                    }
                    if (value.startsWith('0')) {
                      return 'لا يمكن أن يبدأ الدخل بـ 0';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                const Align(
                  alignment: Alignment.centerRight,
                  child: Padding(
                    padding: EdgeInsets.only(right: 15.0),
                    child: Text('مصدر الدخل الشهري ',
                        style: TextStyle(
                          fontSize: 14,
                        )),
                  ),
                ),
                const SizedBox(height: 8),
                DropdownButtonFormField<String>(
                  value: initialIncomeSource,
                  hint: const Text("اختر مصدر الدخل الشهري"),
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12)),
                    contentPadding: const EdgeInsets.symmetric(
                        horizontal: 10, vertical: 14),
                  ),
                  items: incomeSources
                      .map((s) => DropdownMenuItem(
                            value: s,
                            child: Text(s),
                          ))
                      .toList(),
                  onChanged: onIncomeSourceChanged,
                  validator: (val) => (val == null || val.isEmpty)
                      ? "يرجى اختيار مصدر الدخل الشهري"
                      : null,
                ),
                const SizedBox(height: 16),
                const Align(
                  alignment: Alignment.centerRight,
                  child: Padding(
                    padding: EdgeInsets.only(right: 15.0),
                    child: Text('العمل الحالي',
                        style: TextStyle(
                          fontSize: 14,
                        )),
                  ),
                ),
                const SizedBox(height: 8),
                Customtextfields(
                  mycontroller: currentJobController,
                  hint: 'العمل الحالي',
                  inputType: TextInputType.text,
                  valid: (value) {
                    if (value == null || value.isEmpty) {
                      return 'يرجى إدخال العمل الحالي';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 24),
                Authbutton(
                  buttonText: 'التالي',
                  onPressed: onNext,
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
