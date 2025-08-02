// ignore_for_file: deprecated_member_use

import 'package:charity_app/constants/const_alert_dilog.dart';
import 'package:charity_app/feature/HousingSupport/cubit/housing_form_cubit.dart';
import 'package:charity_app/feature/HousingSupport/cubit/housing_form_state.dart';
import 'package:charity_app/feature/HousingSupport/widget/first_screen.dart';
import 'package:charity_app/feature/HousingSupport/widget/second_screen.dart';
import 'package:charity_app/constants/const_appBar.dart';
import 'package:charity_app/core/extensions/context_extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class HousingFormScreen extends StatefulWidget {
  const HousingFormScreen({super.key});

  @override
  State<HousingFormScreen> createState() => _HousingFormScreenState();
}

class _HousingFormScreenState extends State<HousingFormScreen> {
  final _firstPageFormKey = GlobalKey<FormState>();
  final _secondPageFormKey = GlobalKey<FormState>();

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
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController numberOfPeopleNeedingHousingController =
      TextEditingController();

  String? _selectedGender;
  String? _selectedMaritalStatus;
  String? _selectedGovernorate;
  String? _selectedIncomeSource;
  String? selectedHousingStatus;
  String? selectedHelpType;

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
          numberOfPeopleNeedingHousingController.text.isEmpty ||
          selectedHousingStatus == null ||
          selectedHelpType == null) {
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
    if (fullNameController.text.isNotEmpty &&
        ageController.text.isNotEmpty &&
        phoneNumberController.text.isNotEmpty &&
        addressController.text.isNotEmpty &&
        monthlyIncomeController.text.isNotEmpty &&
        currentJobController.text.isNotEmpty &&
        descriptionController.text.isNotEmpty &&
        numberOfPeopleNeedingHousingController.text.isNotEmpty &&
        _selectedGender != null &&
        _selectedMaritalStatus != null &&
        _selectedGovernorate != null &&
        _selectedIncomeSource != null &&
        selectedHousingStatus != null &&
        selectedHelpType != null) {
      final cubit = context.read<HousingFormCubit>();
      cubit.sendHousingCubit(
        fullNameController: fullNameController.text,
        ageController: ageController.text,
        phoneNumberController: phoneNumberController.text,
        numberOfChildrenController: numberOfChildrenController.text,
        childrenDetailsController: childrenDetailsController.text,
        addressController: addressController.text,
        monthlyIncomeController: monthlyIncomeController.text,
        currentJobController: currentJobController.text,
        descriptionController: descriptionController.text,
        numberOfPeopleNeedingHousingController:
            numberOfPeopleNeedingHousingController.text,
        selectedHousingStatus: selectedHousingStatus!,
        selectedHelpType: selectedHelpType!,
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
    numberOfPeopleNeedingHousingController.dispose();
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = context.colorScheme;

    return BlocConsumer<HousingFormCubit, HousingFormState>(
      listener: (context, state) {
        if (state is HousingFormSuccess) {
          showDialog(
            context: context,
            barrierDismissible: false,
            builder: (context) => CustomAlertDialogNoConfirm(
              title:
                  "تم استلام طلب المساعدة السكنية بنجاح. سيتم التعامل معه في أقرب وقت، نرجو متابعة الإشعارات لمعرفة حالة الطلب.",
              cancelText: "إغلاق",
              onCancel: () {
                Navigator.of(context).pop();
                Navigator.of(context).pushNamedAndRemoveUntil(
                    'NavigationMain', (route) => false);
              },
            ),
          );
        } else if (state is HousingFormAlreadySubmitted) {
          showDialog(
            context: context,
            barrierDismissible: false,
            builder: (context) => CustomAlertDialogNoConfirm(
              title:
                  "نتفهم حاجتكم، ولكن لا يمكن تقديم طلب مساعدة جديد إلا بعد مرور 20 يوم",
              cancelText: "إغلاق",
              onCancel: () {
                // Navigator.of(context).pop();
                Navigator.of(context).pushNamedAndRemoveUntil(
                    'NavigationMain', (route) => false);
              },
            ),
          );

          if (state.daysRemaining != null) {}
        } else if (state is HousingFormFailure) {
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
                appBar: const ConstAppBar(title: "تقديم طلب مساعدة سكني"),
                backgroundColor: context.colorScheme.surface,
                body: PageView(
                  controller: _pageController,
                  physics: const NeverScrollableScrollPhysics(),
                  children: [
                    FirstHousingScreen(
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
                    SecondHousingScreen(
                      formKey: _secondPageFormKey,
                      descriptionController: descriptionController,
                      numberOfPeopleNeedingHousingController:
                          numberOfPeopleNeedingHousingController,
                      selectedHousingStatus: selectedHousingStatus,
                      selectedHelpType: selectedHelpType,
                      onHousingStatusChanged: (newValue) {
                        setState(() {
                          selectedHousingStatus = newValue;
                        });
                      },
                      onHelpTypeChanged: (newValue) {
                        setState(() {
                          selectedHelpType = newValue;
                        });
                      },
                      onPrevious: previousPage,
                      onSubmit: submitForm,
                      colorScheme: colorScheme,
                    ),
                  ],
                ),
              ),
              if (state is HousingFormLoading)
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
