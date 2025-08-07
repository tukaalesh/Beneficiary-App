import 'package:charity_app/constants/custom_text.dart';
import 'package:charity_app/core/extensions/context_extensions.dart';
import 'package:flutter/material.dart';
import 'package:charity_app/auth/widgets/auth_button.dart';

class FormPageOne extends StatefulWidget {
  final void Function(Map<String, dynamic>) onNext;

  const FormPageOne({super.key, required this.onNext});

  @override
  State<FormPageOne> createState() => _FormPageOneState();
}

class _FormPageOneState extends State<FormPageOne> {
  final formKey = GlobalKey<FormState>();

  final TextEditingController fullNameController = TextEditingController();
  final TextEditingController ageController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController numberOfKidsController = TextEditingController();
  final TextEditingController kidsDescriptionController =
      TextEditingController();
  final TextEditingController homeAddressController = TextEditingController();
  final TextEditingController monthlyIncomeController = TextEditingController();
  final TextEditingController currentJobController = TextEditingController();

  final List<String> incomeSources = [
    'لا يوجد دخل',
    'راتب تقاعدي',
    'مساعدات من أقارب',
    'مساعدات من جمعيات',
    'عمل',
  ];
  final List<String> maritalStatusOptions = [
    'أعزب',
    'متزوج',
    'مطلق',
    'أرمل',
  ];

  final List<String> governorates = [
    'دمشق',
    'ريف دمشق',
    'حماة',
    'حمص',
    'حلب',
    'اللاذقية',
    'ادلب'
  ];

  String? selectedMaritalStatus;
  String? selectedIncomeSource;
  String? selectedGovernorate;
  String? selectedGender;

  @override
  void dispose() {
    fullNameController.dispose();
    ageController.dispose();
    phoneController.dispose();
    numberOfKidsController.dispose();
    kidsDescriptionController.dispose();
    homeAddressController.dispose();
    monthlyIncomeController.dispose();
    currentJobController.dispose();
    super.dispose();
  }

  void onNextPressed() {
    if (formKey.currentState?.validate() ?? false) {
      final data = {
        "full_name": fullNameController.text.trim(),
        "age": int.tryParse(ageController.text.trim()) ?? 0,
        "gender": selectedGender ?? "",
        "marital_status": selectedMaritalStatus ?? "",
        "phone_number": phoneController.text.trim(),
        "number_of_kids": int.tryParse(numberOfKidsController.text.trim()) ?? 0,
        "kids_description": kidsDescriptionController.text.trim(),
        "governorate": selectedGovernorate ?? "",
        "home_address": homeAddressController.text.trim(),
        "monthly_income":int.tryParse(monthlyIncomeController.text.trim()) ?? 0,
        "current_job": currentJobController.text.trim(),
        "monthly_income_source": selectedIncomeSource ?? ""
      };

      widget.onNext(data);
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
                  'يرجى تعبئة هذا النموذج بدقة ومصداقية تامة :',
                  style: TextStyle(color: Colors.red),
                ),
                const SizedBox(height: 24),
                Align(
                  alignment: Alignment.centerRight,
                  child: Padding(
                    padding: const EdgeInsets.only(right: 15.0),
                    child: Text('الاسم الثلاثي',
                        style: TextStyle(
                          fontSize: 14,
                          color: isDark ? Colors.grey[400] : Colors.black,
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
                Align(
                  alignment: Alignment.centerRight,
                  child: Padding(
                    padding: const EdgeInsets.only(right: 15.0),
                    child: Text('العمر',
                        style: TextStyle(
                          fontSize: 14,
                          color: isDark ? Colors.grey[400] : Colors.black,
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
                    if (int.parse(value) < 18 || int.parse(value) > 100) {
                      return "العمر يجب أن يكون بين 18 و 100";
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                Align(
                  alignment: Alignment.centerRight,
                  child: Padding(
                    padding: const EdgeInsets.only(right: 15.0),
                    child: Text('الحالة الاجتماعية',
                        style: TextStyle(
                            fontSize: 14,
                            color: isDark ? Colors.grey[400] : Colors.black)),
                  ),
                ),
                const SizedBox(height: 8),
                DropdownButtonFormField<String>(
                  value: selectedMaritalStatus,
                  hint: const Text("اختر الحالة الاجتماعية"),
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12)),
                    contentPadding: const EdgeInsets.symmetric(
                        horizontal: 10, vertical: 14),
                  ),
                  items: maritalStatusOptions
                      .map((status) => DropdownMenuItem(
                            value: status,
                            child: Text(status),
                          ))
                      .toList(),
                  onChanged: (val) => setState(() {
                    selectedMaritalStatus = val;
                  }),
                  validator: (val) => (val == null || val.isEmpty)
                      ? "يرجى اختيار الحالة الاجتماعية"
                      : null,
                ),
                const SizedBox(height: 16),
                Align(
                  alignment: Alignment.centerRight,
                  child: Padding(
                    padding: const EdgeInsets.only(right: 15.0),
                    child: Text('رقم الهاتف',
                        style: TextStyle(
                            fontSize: 14,
                            color: isDark ? Colors.grey[400] : Colors.black)),
                  ),
                ),
                const SizedBox(height: 8),
                Customtextfields(
                  mycontroller: phoneController,
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
                Align(
                  alignment: Alignment.centerRight,
                  child: Padding(
                    padding: const EdgeInsets.only(right: 15.0),
                    child: Text('الجنس',
                        style: TextStyle(
                            fontSize: 14,
                            color: isDark ? Colors.grey[400] : Colors.black)),
                  ),
                ),
                Row(
                  children: [
                    Expanded(
                      child: RadioListTile<String>(
                        title: Text(
                          "أنثى",
                          style: TextStyle(
                              fontSize: 14,
                              color: isDark ? Colors.grey[400] : Colors.black),
                        ),
                        value: 'أنثى',
                        groupValue: selectedGender,
                        onChanged: (value) {
                          setState(() {
                            selectedGender = value;
                          });
                        },
                      ),
                    ),
                    Expanded(
                      child: RadioListTile<String>(
                        title: Text(
                          "ذكر",
                          style: TextStyle(
                              fontSize: 14,
                              color: isDark ? Colors.grey[400] : Colors.black),
                        ),
                        value: 'ذكر',
                        groupValue: selectedGender,
                        onChanged: (value) {
                          setState(() {
                            selectedGender = value;
                          });
                        },
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Align(
                  alignment: Alignment.centerRight,
                  child: Padding(
                    padding: const EdgeInsets.only(right: 15.0),
                    child: Text('عدد الأولاد',
                        style: TextStyle(
                            fontSize: 14,
                            color: isDark ? Colors.grey[400] : Colors.black)),
                  ),
                ),
                const SizedBox(height: 8),
                Customtextfields(
                  mycontroller: numberOfKidsController,
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
                Align(
                  alignment: Alignment.centerRight,
                  child: Padding(
                    padding: const EdgeInsets.only(right: 15.0),
                    child: Text('تفاصيل الأولاد',
                        style: TextStyle(
                            fontSize: 14,
                            color: isDark ? Colors.grey[400] : Colors.black)),
                  ),
                ),
                const SizedBox(height: 8),
                Customtextfields(
                  mycontroller: kidsDescriptionController,
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
                Align(
                  alignment: Alignment.centerRight,
                  child: Padding(
                    padding: const EdgeInsets.only(right: 15.0),
                    child: Text('عنوان السكن',
                        style: TextStyle(
                            fontSize: 14,
                            color: isDark ? Colors.grey[400] : Colors.black)),
                  ),
                ),
                const SizedBox(height: 8),
                Customtextfields(
                  mycontroller: homeAddressController,
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
                Align(
                  alignment: Alignment.centerRight,
                  child: Padding(
                    padding: const EdgeInsets.only(right: 15.0),
                    child: Text('المحافظة',
                        style: TextStyle(
                            fontSize: 14,
                            color: isDark ? Colors.grey[400] : Colors.black)),
                  ),
                ),
                const SizedBox(height: 8),
                DropdownButtonFormField<String>(
                  value: selectedGovernorate,
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
                  onChanged: (val) => setState(() {
                    selectedGovernorate = val;
                  }),
                  validator: (val) => (val == null || val.isEmpty)
                      ? "الرجاء اختيار المحافظة"
                      : null,
                ),
                const SizedBox(height: 16),
                Align(
                  alignment: Alignment.centerRight,
                  child: Padding(
                    padding: const EdgeInsets.only(right: 15.0),
                    child: Text('الدخل الشهري للعائلة',
                        style: TextStyle(
                            fontSize: 14,
                            color: isDark ? Colors.grey[400] : Colors.black)),
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
                Align(
                  alignment: Alignment.centerRight,
                  child: Padding(
                    padding: const EdgeInsets.only(right: 15.0),
                    child: Text('مصدر الدخل الشهري ',
                        style: TextStyle(
                            fontSize: 14,
                            color: isDark ? Colors.grey[400] : Colors.black)),
                  ),
                ),
                const SizedBox(height: 8),
                DropdownButtonFormField<String>(
                  value: selectedIncomeSource,
                  hint: const Text("اختر مصدر الدخل الشهري"),
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12)),
                    contentPadding: const EdgeInsets.symmetric(
                        horizontal: 10, vertical: 14),
                  ),
                  items: incomeSources
                      .map((s) => DropdownMenuItem(value: s, child: Text(s)))
                      .toList(),
                  onChanged: (val) => setState(() {
                    selectedIncomeSource = val;
                  }),
                  validator: (val) => (val == null || val.isEmpty)
                      ? "يرجى اختيار مصدر الدخل الشهري"
                      : null,
                ),
                const SizedBox(height: 16),
                Align(
                  alignment: Alignment.centerRight,
                  child: Padding(
                    padding: const EdgeInsets.only(right: 15.0),
                    child: Text('العمل الحالي',
                        style: TextStyle(
                            fontSize: 14,
                            color: isDark ? Colors.grey[400] : Colors.black)),
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
                  onPressed: onNextPressed,
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
