// ignore_for_file: deprecated_member_use

import 'package:charity_app/constants/const_alert_dilog.dart';
import 'package:charity_app/feature/HealthSupport/cubit/health_form_cubit.dart';
import 'package:charity_app/feature/HealthSupport/cubit/health_form_state.dart';
import 'package:charity_app/feature/HealthSupport/widget/first_screen.dart';
import 'package:charity_app/feature/HealthSupport/widget/second_screen.dart';
import 'package:flutter/material.dart';
import 'package:charity_app/constants/const_appBar.dart';
import 'package:charity_app/core/extensions/context_extensions.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class HealthFormScreen extends StatefulWidget {
  const HealthFormScreen({super.key});

  @override
  State<HealthFormScreen> createState() => _HealthFormScreenState();
}

class _HealthFormScreenState extends State<HealthFormScreen> {
  final _firstPageFormKey = GlobalKey<FormState>();
  final PageController _pageController = PageController();

  final TextEditingController fullNameController = TextEditingController();
  final TextEditingController ageController = TextEditingController();
  final TextEditingController phoneNumberController = TextEditingController();
  final TextEditingController numberOfChildrenController =
      TextEditingController();
  final TextEditingController childrenDetailsController =
      TextEditingController();
  final TextEditingController addressController = TextEditingController();
  final TextEditingController monthlyIncomeController = TextEditingController();
  final TextEditingController currentJobController = TextEditingController();

  String? _selectedGender;
  String? _selectedMaritalStatus;
  String? _selectedGovernorate;
  String? _selectedIncomeSource;

  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController expectedCostController = TextEditingController();
  String? selectedRiskOption;

  int currentPage = 0;

  void nextPage() {
    if (currentPage == 0) {
      if (_firstPageFormKey.currentState != null &&
          _firstPageFormKey.currentState!.validate()) {
        _pageController.nextPage(
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeInOut,
        );
        setState(() {
          currentPage++;
        });
      } else {
        _showSnackBar('الرجاء تعبئة جميع الحقول المطلوبة في هذه الصفحة.');
      }
    } else if (currentPage == 1) {
      if (descriptionController.text.isEmpty ||
          expectedCostController.text.isEmpty ||
          selectedRiskOption == null) {
        _showSnackBar(
            'الرجاء تعبئة جميع الحقول المطلوبة واختيار الخيارات في هذه الصفحة.');
        return;
      }
      submitForm();
    }
  }

  void previousPage() {
    _pageController.previousPage(
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
    setState(() {
      currentPage--;
    });
  }

  void _showSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        duration: const Duration(seconds: 3),
      ),
    );
  }

  void submitForm() {
    if (currentPage == 1 &&
        descriptionController.text.isNotEmpty &&
        expectedCostController.text.isNotEmpty &&
        selectedRiskOption != null &&
        _selectedGender != null &&
        _selectedMaritalStatus != null &&
        _selectedGovernorate != null &&
        _selectedIncomeSource != null) {
      final cubit = context.read<HealthFormCubit>();
      cubit.sendHealthCubit(
        fullNameController: fullNameController.text,
        ageController: ageController.text,
        phoneNumberController: phoneNumberController.text,
        numberOfChildrenController: numberOfChildrenController.text,
        childrenDetailsController: childrenDetailsController.text,
        addressController: addressController.text,
        monthlyIncomeController: monthlyIncomeController.text,
        currentJobController: currentJobController.text,
        descriptionController: descriptionController.text,
        expectedCostController: expectedCostController.text,
        selectedRiskOption: selectedRiskOption!,
        gender: _selectedGender!,
        maritalStatus: _selectedMaritalStatus!,
        governorate: _selectedGovernorate!,
        incomeSource: _selectedIncomeSource!,
      );
    } else {
      _showSnackBar('الرجاء تعبئة جميع الحقول المطلوبة واختيار الخيارات.');
    }
  }

  @override
  void dispose() {
    fullNameController.dispose();
    ageController.dispose();
    phoneNumberController.dispose();
    numberOfChildrenController.dispose();
    childrenDetailsController.dispose();
    addressController.dispose();
    monthlyIncomeController.dispose();
    currentJobController.dispose();
    descriptionController.dispose();
    expectedCostController.dispose();
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = context.colorScheme;

    return BlocConsumer<HealthFormCubit, HealthFormState>(
      listener: (context, state) {
        if (state is HealthFormSuccess) {
          showDialog(
            context: context,
            barrierDismissible: false,
            builder: (context) => CustomAlertDialogNoConfirm(
              title: "تم إرسال طلب المساعدة الصحية بنجاح",
              cancelText: "إغلاق",
              onCancel: () {
                Navigator.of(context).pop();
                Navigator.of(context).pushNamedAndRemoveUntil(
                    'NavigationMain', (route) => false);
              },
            ),
          );
        } else if (state is HealthFormAlreadySubmitted) {
          showDialog(
            context: context,
            barrierDismissible: false,
            builder: (context) => CustomAlertDialogNoConfirm(
              title:
                  "نتفهم حاجتكم، ولكن لا يمكن تقديم طلب مساعدة صحية جديد إلا بعد مرور 20 يوم",
              cancelText: "إغلاق",
              onCancel: () {
                // Navigator.of(context).pop();
                Navigator.of(context).pushNamedAndRemoveUntil(
                    'NavigationMain', (route) => false);
              },
            ),
          );

          if (state.daysRemaining != null) {}
        }
         else if (state is HealthFormFailure) {
          showDialog(
            context: context,
            barrierDismissible: false,
            builder: (context) => CustomAlertDialogNoConfirm(
              title: "حدث خطأ ما ! يرجى المحاولة فيما بعد",
              cancelText: "إغلاق",
              onCancel: () {
                Navigator.of(context).pop();
              },
            ),
          );
          // _showSnackBar(state.errorMessage);
        }
      },
      builder: (context, state) {
        return Directionality(
          textDirection: TextDirection.rtl,
          child: Stack(
            children: [
              Scaffold(
                appBar: const ConstAppBar(title: "تقديم طلب مساعدة صحي"),
                backgroundColor: context.colorScheme.surface,
                body: PageView(
                  controller: _pageController,
                  physics: const NeverScrollableScrollPhysics(),
                  children: [
                    FirstHealthScreen(
                      formKey: _firstPageFormKey,
                      fullNameController: fullNameController,
                      ageController: ageController,
                      phoneNumberController: phoneNumberController,
                      numberOfChildrenController: numberOfChildrenController,
                      childrenDetailsController: childrenDetailsController,
                      addressController: addressController,
                      monthlyIncomeController: monthlyIncomeController,
                      currentJobController: currentJobController,
                      onNext: nextPage,
                      initialGender: _selectedGender,
                      onGenderChanged: (gender) {
                        setState(() {
                          _selectedGender = gender;
                        });
                      },
                      initialMaritalStatus: _selectedMaritalStatus,
                      onMaritalStatusChanged: (status) {
                        setState(() {
                          _selectedMaritalStatus = status;
                        });
                      },
                      initialGovernorate: _selectedGovernorate,
                      onGovernorateChanged: (governorate) {
                        setState(() {
                          _selectedGovernorate = governorate;
                        });
                      },
                      initialIncomeSource: _selectedIncomeSource,
                      onIncomeSourceChanged: (source) {
                        setState(() {
                          _selectedIncomeSource = source;
                        });
                      },
                    ),
                    SecondHealthScreen(
                      descriptionController: descriptionController,
                      expectedCostController: expectedCostController,
                      selectedOption: selectedRiskOption,
                      onOptionChanged: (newValue) {
                        setState(() {
                          selectedRiskOption = newValue;
                        });
                      },
                      onPrevious: previousPage,
                      onSubmit: submitForm,
                      colorScheme: colorScheme,
                    ),
                  ],
                ),
              ),
              if (state is HealthFormLoading)
                Container(
                  color: Colors.black.withOpacity(0.5),
                  child: Center(
                    child: SpinKitCircle(
                      color: colorScheme.secondary,
                      size: 50,
                    ),
                  ),
                ),
            ],
          ),
        );
      },
    );
  }
}
