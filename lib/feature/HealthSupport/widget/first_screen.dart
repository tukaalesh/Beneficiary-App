import 'package:charity_app/auth/widgets/auth_button.dart';
import 'package:charity_app/constants/custom_text.dart';
import 'package:flutter/material.dart';

enum Gender { male, female }

enum MaritalStatus { single, married, widowed }

class FirstHealthScreen extends StatefulWidget {
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
  final ValueChanged<Gender?> onGenderChanged;
  final ValueChanged<MaritalStatus?> onMaritalStatusChanged;
  final ValueChanged<String?> onGovernorateChanged;
  final ValueChanged<String?> onIncomeSourceChanged;
  final Gender? initialGender;
  final MaritalStatus? initialMaritalStatus;
  final String? initialGovernorate;
  final String? initialIncomeSource;

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
    required this.onGenderChanged,
    required this.onMaritalStatusChanged,
    required this.onGovernorateChanged,
    required this.onIncomeSourceChanged,
    this.initialGender,
    this.initialMaritalStatus,
    this.initialGovernorate,
    this.initialIncomeSource,
  });

  @override
  State<FirstHealthScreen> createState() => _FirstHealthScreenState();
}

class _FirstHealthScreenState extends State<FirstHealthScreen> {
  Gender? _selectedGender;
  MaritalStatus? _selectedMaritalStatus;
  String? _selectedGovernorate;
  String? _selectedIncomeSource;

  final List<String> _governorates = ["دمشق", "حلب", "حمص", "حماة"];

  final List<String> _incomeSources = [
    "عمل",
    "مساعدات من جمعيات",
    "مساعدات من أقارب",
    "راتب تقاعدي",
    "لا يوجد دخل",
  ];

  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    _selectedGender = widget.initialGender;
    _selectedMaritalStatus = widget.initialMaritalStatus;
    _selectedGovernorate = widget.initialGovernorate;
    _selectedIncomeSource = widget.initialIncomeSource;
    widget.numberOfChildrenController
        .addListener(_updateChildrenDetailsVisibility);
  }

  @override
  void dispose() {
    widget.numberOfChildrenController
        .removeListener(_updateChildrenDetailsVisibility);
    super.dispose();
  }

  void _updateChildrenDetailsVisibility() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25.0),
      child: Form(
        key: _formKey,
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
            _buildLabel("الاسم الكامل"),
            const SizedBox(height: 8),
            Customtextfields(
              hint: "ادخل الأسم الثلاثي",
              inputType: TextInputType.text,
              mycontroller: widget.fullNameController,
              valid: (value) => (value == null || value.isEmpty)
                  ? "الرجاء إدخال الاسم الكامل"
                  : null,
            ),
            const SizedBox(height: 15),
            _buildLabel("العمر"),
            const SizedBox(height: 8),
            Customtextfields(
              hint: "ادخل العمر",
              inputType: TextInputType.number,
              mycontroller: widget.ageController,
              valid: (value) {
                if (value == null || value.isEmpty) return "الرجاء إدخال العمر";
                if (int.tryParse(value) == null || int.parse(value) <= 0)
                  return "الرجاء إدخال عمر صحيح";
                return null;
              },
            ),
            const SizedBox(height: 15),
            _buildLabel("رقم الهاتف"),
            const SizedBox(height: 8),
            Customtextfields(
              hint: "ادخل رقم الهاتف",
              inputType: TextInputType.phone,
              mycontroller: widget.phoneNumberController,
              valid: (value) => (value == null || value.isEmpty)
                  ? "الرجاء إدخال رقم الهاتف"
                  : null,
            ),
            _buildLabel("الجنس"),
            const SizedBox(height: 8),
            _buildRadioGroup<Gender>(
              value: _selectedGender,
              options: Gender.values,
              titles: const {Gender.male: 'ذكر', Gender.female: 'أنثى'},
              onChanged: (newValue) {
                setState(() => _selectedGender = newValue);
                widget.onGenderChanged(newValue);
              },
              validator: (value) =>
                  (value == null) ? 'الرجاء اختيار الجنس' : null,
              colorScheme: widget.colorScheme,
            ),
            const SizedBox(height: 15),
            _buildLabel("الحالة الاجتماعية"),
            const SizedBox(height: 8),
            _buildRadioGroup<MaritalStatus>(
              value: _selectedMaritalStatus,
              options: MaritalStatus.values,
              titles: const {
                MaritalStatus.single: 'أعزب',
                MaritalStatus.married: 'متزوج',
                MaritalStatus.widowed: 'أرمل',
              },
              onChanged: (newValue) {
                setState(() => _selectedMaritalStatus = newValue);
                widget.onMaritalStatusChanged(newValue);
              },
              validator: (value) =>
                  (value == null) ? 'الرجاء اختيار الحالة الاجتماعية' : null,
              colorScheme: widget.colorScheme,
            ),
            Divider(height: 30, thickness: 1, color: Colors.grey[300]),
            _buildLabel("عدد الأولاد"),
            const SizedBox(height: 8),
            Customtextfields(
              hint: "ادخل عدد الأولاد",
              inputType: TextInputType.number,
              mycontroller: widget.numberOfChildrenController,
              valid: (value) {
                if (value == null || value.isEmpty)
                  return "الرجاء إدخال عدد الأولاد";
                if (int.tryParse(value) == null || int.parse(value) < 0)
                  return "الرجاء إدخال عدد صحيح وموجب";
                return null;
              },
            ),
            const SizedBox(height: 15),
            if (int.tryParse(widget.numberOfChildrenController.text) != null &&
                int.parse(widget.numberOfChildrenController.text) > 0)
              Column(
                children: [
                  _buildLabel("تفاصيل الأولاد"),
                  const SizedBox(height: 8),
                  Customtextfields(
                    hint: "ادخل تفاصيل الأولاد",
                    inputType: TextInputType.text,
                    mycontroller: widget.childrenDetailsController,
                    valid: (value) => (value == null || value.isEmpty)
                        ? "الرجاء إدخال تفاصيل الأولاد"
                        : null,
                  ),
                  const SizedBox(height: 15),
                ],
              ),
            _buildLabel("عنوان السكن بالتفصيل"),
            const SizedBox(height: 8),
            Customtextfields(
              hint: "ادخل عنوان السكن بالتفصيل",
              inputType: TextInputType.text,
              mycontroller: widget.addressController,
              valid: (value) => (value == null || value.isEmpty)
                  ? "الرجاء إدخال عنوان السكن"
                  : null,
            ),
            const SizedBox(height: 15),
            _buildLabel("المحافظة"),
            const SizedBox(height: 8),
            DropdownButtonFormField<String>(
              value: _selectedGovernorate,
              hint: const Text("اختر المحافظة"),
              decoration: _dropdownDecoration(),
              items: _governorates
                  .map((g) => DropdownMenuItem(value: g, child: Text(g)))
                  .toList(),
              onChanged: (val) {
                setState(() => _selectedGovernorate = val);
                widget.onGovernorateChanged(val);
              },
              validator: (val) => (val == null || val.isEmpty)
                  ? "الرجاء اختيار المحافظة"
                  : null,
            ),
            const SizedBox(height: 15),
            _buildLabel("مستوى الدخل الشهري للعائلة"),
            const SizedBox(height: 8),
            Customtextfields(
              hint: "ادخل مستوى الدخل الشهري للعائلة",
              inputType: TextInputType.number,
              mycontroller: widget.monthlyIncomeController,
              valid: (value) {
                if (value == null || value.isEmpty)
                  return "الرجاء إدخال مستوى الدخل";
                if (double.tryParse(value) == null || double.parse(value) < 0)
                  return "الرجاء إدخال رقم صحيح وموجب";
                return null;
              },
            ),
            const SizedBox(height: 15),
            _buildLabel("مصدر الدخل"),
            const SizedBox(height: 8),
            DropdownButtonFormField<String>(
              value: _selectedIncomeSource,
              hint: const Text("اختر مصدر الدخل"),
              decoration: _dropdownDecoration(),
              items: _incomeSources
                  .map((s) => DropdownMenuItem(value: s, child: Text(s)))
                  .toList(),
              onChanged: (val) {
                setState(() => _selectedIncomeSource = val);
                widget.onIncomeSourceChanged(val);
              },
              validator: (val) => (val == null || val.isEmpty)
                  ? "الرجاء اختيار مصدر الدخل"
                  : null,
            ),
            const SizedBox(height: 15),
            _buildLabel("العمل الحالي"),
            const SizedBox(height: 8),
            Customtextfields(
              hint: "ادخل العمل الحالي",
              inputType: TextInputType.text,
              mycontroller: widget.currentJobController,
              valid: (value) => (value == null || value.isEmpty)
                  ? "الرجاء إدخال العمل الحالي"
                  : null,
            ),
            const SizedBox(height: 30),
            Padding(
              padding: const EdgeInsets.only(bottom: 20),
              child: Authbutton(
                buttonText: "التالي",
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    if (_selectedGender == null) {
                      _showSnackBar('الرجاء اختيار الجنس');
                      return;
                    }
                    if (_selectedMaritalStatus == null) {
                      _showSnackBar('الرجاء اختيار الحالة الاجتماعية');
                      return;
                    }
                    widget.onNext();
                  } else {
                    _showSnackBar(
                        'الرجاء تعبئة جميع الحقول المطلوبة واختيار الخيارات.');
                  }
                },
                color: widget.colorScheme.primary,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLabel(String text) {
    return Align(
      alignment: Alignment.centerRight,
      child: Padding(
        padding: const EdgeInsets.only(right: 15.0),
        child: Text(text, style: const TextStyle(fontSize: 14)),
      ),
    );
  }

  InputDecoration _dropdownDecoration() {
    return InputDecoration(
      contentPadding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: const BorderSide(color: Colors.grey),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: const BorderSide(color: Colors.grey),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: BorderSide(color: widget.colorScheme.primary, width: 2),
      ),
    );
  }

  Widget _buildRadioGroup<T>({
    required T? value,
    required List<T> options,
    required Map<T, String> titles,
    required ValueChanged<T?> onChanged,
    required String? Function(T?) validator,
    required ColorScheme colorScheme,
  }) {
    return FormField<T>(
      initialValue: value,
      validator: validator,
      builder: (state) {
        if (state.value != value) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            state.didChange(value);
          });
        }
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: options.map((option) {
                return Expanded(
                  child: Directionality(
                    textDirection: TextDirection.rtl,
                    child: RadioListTile<T>(
                      title: Text(titles[option]!),
                      value: option,
                      groupValue: state.value,
                      onChanged: (newValue) {
                        state.didChange(newValue);
                        onChanged(newValue);
                      },
                      activeColor: colorScheme.secondary,
                      visualDensity: VisualDensity.compact,
                    ),
                  ),
                );
              }).toList(),
            ),
            if (state.hasError)
              Padding(
                padding: const EdgeInsets.only(right: 15.0, top: 5.0),
                child: Text(state.errorText!,
                    style: const TextStyle(color: Colors.red, fontSize: 12)),
              ),
          ],
        );
      },
    );
  }

  void _showSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message), duration: const Duration(seconds: 2)),
    );
  }
}
