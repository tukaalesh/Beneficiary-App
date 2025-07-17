import 'package:charity_app/feature/HousingSupport/cubit/housing_form_cubit.dart';
import 'package:charity_app/feature/HousingSupport/cubit/housing_form_state.dart';
import 'package:charity_app/feature/HousingSupport/widget/first_screen.dart';
import 'package:charity_app/feature/HousingSupport/widget/second_screen.dart';
import 'package:flutter/material.dart';
import 'package:charity_app/constants/const_appBar.dart';
import 'package:charity_app/core/extensions/context_extensions.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class HousingFormScreen extends StatefulWidget {
  const HousingFormScreen({super.key});

  @override
  State<HousingFormScreen> createState() => _HousingFormScreenState();
}

class _HousingFormScreenState extends State<HousingFormScreen> {
  final _formKey = GlobalKey<FormState>();
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

  String? selectedHousingStatus;
  String? selectedHelpType;

  int currentPage = 0;

  void nextPage() {
    if (_formKey.currentState != null && _formKey.currentState!.validate()) {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
      setState(() {
        currentPage++;
      });
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

  void submitForm() {
    if (_formKey.currentState != null && _formKey.currentState!.validate()) {
      final cubit = context.read<HousingFormCubit>();
      cubit.sendHousingCubit(
          fullNameController: fullNameController,
          ageController: ageController,
          phoneNumberController: phoneNumberController,
          numberOfChildrenController: numberOfChildrenController,
          childrenDetailsController: childrenDetailsController,
          addressController: addressController,
          monthlyIncomeController: monthlyIncomeController,
          currentJobController: currentJobController,
          descriptionController: descriptionController,
          numberOfPeopleNeedingHousingController:
              numberOfPeopleNeedingHousingController,
          selectedHousingStatus: selectedHousingStatus,
          selectedHelpType: selectedHelpType);
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
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("تم إرسال طلب المساعدة بنجاح")),
          );
          Navigator.pop(context);
        } else if (state is HousingFormAlreadySubmitted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
                duration: Duration(seconds: 4),
                content: Text(
                    "لقد قمت بإرسال طلب المساعدة مسبقًا ولا يمكنك التسجيل مرة أخرى.")),
          );
        } else if (state is HousingFormPhoneNumberAlreadyUsed) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
                duration: Duration(seconds: 4),
                content: Text("رقم الهاتف مستخدم بالفعل من قبل مستخدم آخر")),
          );
        } else if (state is HousingFormFailure) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
                duration: Duration(seconds: 3),
                content: Text("حصل خطأ يُرجى المحاولة لاحقاً !")),
          );
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
                body: Form(
                  key: _formKey,
                  child: PageView(
                    controller: _pageController,
                    physics: const NeverScrollableScrollPhysics(),
                    children: [
                      FirstHousingScreen(
                        fullNameController: fullNameController,
                        ageController: ageController,
                        phoneNumberController: phoneNumberController,
                        numberOfChildrenController: numberOfChildrenController,
                        childrenDetailsController: childrenDetailsController,
                        addressController: addressController,
                        monthlyIncomeController: monthlyIncomeController,
                        currentJobController: currentJobController,
                        onNext: nextPage,
                        colorScheme: colorScheme,
                      ),
                      SecondHousingScreen(
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
