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
  final TextEditingController expectedCostController = TextEditingController();
  String? selectedRiskOption;

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
      
      final cubit = context.read<HealthFormCubit>();
      cubit.sendHealthCubit(
          fullNameController: fullNameController,
          ageController: ageController,
          phoneNumberController: phoneNumberController,
          numberOfChildrenController: numberOfChildrenController,
          childrenDetailsController: childrenDetailsController,
          addressController: addressController,
          monthlyIncomeController: monthlyIncomeController,
          currentJobController: currentJobController,
          descriptionController: descriptionController,
          expectedCostController: expectedCostController,
          selectedRiskOption: selectedRiskOption);
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
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("تم إرسال طلب المساعدة بنجاح")),
          );
          Navigator.pop(context);
        } else if (state is HealthFormAlreadySubmitted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
                duration: Duration(seconds: 4),
                content: Text(
                    "لقد قمت بإرسال طلب المساعدة مسبقًا ولا يمكنك التسجيل مرة أخرى.")),
          );
        } else if (state is HealthFormPhoneNumberAlreadyUsed) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
                duration: Duration(seconds: 4),
                content: Text("رقم الهاتف مستخدم بالفعل من قبل مستخدم آخر")),
          );
        } else if (state is HealthFormFailure) {
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
                appBar: const ConstAppBar(title: "تقديم طلب مساعدة صحي"),
                backgroundColor: context.colorScheme.surface,
                body: Form(
                  key: _formKey,
                  child: PageView(
                    controller: _pageController,
                    physics: const NeverScrollableScrollPhysics(),
                    children: [
                      FirstHealthScreen(
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
