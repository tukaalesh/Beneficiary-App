import 'package:charity_app/constants/const_alert_dilog.dart';
import 'package:charity_app/constants/const_appBar.dart';
import 'package:charity_app/core/extensions/context_extensions.dart';
import 'package:charity_app/feature/education/widget/form_page0ne.dart';
import 'package:charity_app/feature/food/cubit/nutritional_cubit.dart';
import 'package:charity_app/feature/food/cubit/nutritional_state.dart';
import 'package:charity_app/feature/food/widget/nutritional_form.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class NutritionalScreen extends StatelessWidget {
  const NutritionalScreen({super.key});

  @override
  Widget build(BuildContext context) {
    context.read<NutritionalFormCubit>().resetForm();
    final colorScheme = context.colorScheme;

    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: const ConstAppBar(title: 'تقديم طلب مساعدة غذائية'),
        backgroundColor: colorScheme.surface,
        body: BlocConsumer<NutritionalRequestCubit, NutritionalRequestState>(
          listener: (context, state) {
            if (state is NutritionalRequestSuccess) {
              showDialog(
                context: context,
                barrierDismissible: false,
                builder: (context) => CustomAlertDialogNoConfirm(
                  title:
                      "تم استلام طلب المساعدة الغذائية بنجاح. سيتم التعامل معه في أقرب وقت، نرجو متابعة الإشعارات لمعرفة حالة الطلب.",
                  cancelText: "إغلاق",
                  onCancel: () {
                    Navigator.of(context).pop();
                    Navigator.of(context).pushNamedAndRemoveUntil(
                        'NavigationMain', (route) => false);
                  },
                ),
              );
            } else if (state is NutritionalFormAlreadySubmitted) {
              showDialog(
                context: context,
                barrierDismissible: false,
                builder: (context) => CustomAlertDialogNoConfirm(
                  title:
                      "نتفهم حاجتكم، ولكن لا يمكن تقديم طلب مساعدة جديد إلا بعد مرور 20 يوم",
                  cancelText: "إغلاق",
                  onCancel: () {
                    Navigator.of(context).pushNamedAndRemoveUntil(
                        'NavigationMain', (route) => false);
                  },
                ),
              );
            } else if (state is NutritionalRequestFailure) {
              showDialog(
                context: context,
                barrierDismissible: false,
                builder: (context) => CustomAlertDialogNoConfirm(
                  title: "حدث خطأ ما ! يرجى المحاولة فيما بعد",
                  cancelText: "إغلاق",
                  onCancel: () {
                    Navigator.of(context).pop();
                    Navigator.of(context).pushNamedAndRemoveUntil(
                        'NavigationMain', (route) => false);
                    context.read<NutritionalFormCubit>().resetForm();
                  },
                ),
              );
            }
          },
          builder: (context, requestState) {
            final isLoading = requestState is NutritionalRequestLoading;

            if (isLoading) {
              return Center(
                child: SpinKitCircle(
                  size: 45,
                  color: colorScheme.secondary,
                ),
              );
            }

            return BlocBuilder<NutritionalFormCubit, int>(
              builder: (context, currentPage) {
                return IndexedStack(
                  index: currentPage,
                  children: [
                    FormPageOne(
                      onNext: (pageOneData) {
                        context
                            .read<NutritionalFormCubit>()
                            .savePageOneData(pageOneData);
                      },
                    ),
                    NutritionalForm(
                      onBack: () =>
                          context.read<NutritionalFormCubit>().goBack(),
                      onSubmit: (pageTwoData) {
                        final allFormData =
                            context.read<NutritionalFormCubit>().allFormData;
                        final completeData = {...allFormData, ...pageTwoData};

                        context
                            .read<NutritionalRequestCubit>()
                            .sendNutritionalRequest(
                              fullName: completeData['full_name'] ?? '',
                              age: int.tryParse(
                                      completeData['age'].toString()) ??
                                  0,
                              gender: completeData['gender'] ?? '',
                              maritalStatus:
                                  completeData['marital_status'] ?? '',
                              phoneNumber: completeData['phone_number'] ?? '',
                              numberOfKids: int.tryParse(
                                      completeData['number_of_kids']
                                          .toString()) ??
                                  0,
                              kidsDescription:
                                  completeData['kids_description'] ?? '',
                              governorate: completeData['governorate'] ?? '',
                              homeAddress: completeData['home_address'] ?? '',
                              monthlyIncome: int.tryParse(
                                      completeData['monthly_income']
                                          .toString()) ??
                                  0,
                              currentJob: completeData['current_job'] ?? '',
                              monthlyIncomeSource:
                                  completeData['monthly_income_source'] ?? '',
                              numberOfNeedy: int.tryParse(
                                      completeData['number_of_needy']
                                          .toString()) ??
                                  0,
                              description: completeData['description'] ?? '',
                              expectedCost: int.tryParse(
                                      completeData['expected_cost']
                                          .toString()) ??
                                  0,
                              neededFoodHelp: List<String>.from(
                                  completeData['needed_food_help'] ?? []),
                            );
                      },
                    ),
                  ],
                );
              },
            );
          },
        ),
      ),
    );
  }
}

class NutritionalFormCubit extends Cubit<int> {
  NutritionalFormCubit() : super(0);

  final Map<String, dynamic> allFormData = {};

  void savePageOneData(Map<String, dynamic> pageOneData) async {
    print('Received pageOneData: $pageOneData');
    allFormData.addAll(pageOneData);
    await Future.delayed(const Duration(milliseconds: 300));
    emit(1);
  }

  void goBack() {
    emit(0);
  }

  void resetForm() {
    allFormData.clear();
    emit(0);
  }
}
