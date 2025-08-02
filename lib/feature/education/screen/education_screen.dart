// ignore_for_file: avoid_print

import 'package:charity_app/constants/const_alert_dilog.dart';
import 'package:charity_app/feature/education/cubit/education_form_cubit.dart';
import 'package:charity_app/feature/education/cubit/education_state.dart';
import 'package:charity_app/feature/education/widget/education_form.dart';
import 'package:charity_app/feature/education/widget/form_page0ne.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:charity_app/constants/const_appBar.dart';
import 'package:charity_app/core/extensions/context_extensions.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class EducationScreen extends StatelessWidget {
  const EducationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    context.read<EducationFormCubit>().resetForm();
    final colorScheme = context.colorScheme;

    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: const ConstAppBar(title: 'تقديم طلب مساعدة تعليمي'),
        backgroundColor: colorScheme.surface,
        body: BlocConsumer<EducationRequestCubit, EducationRequestState>(
          listener: (context, state) {
            if (state is EducationRequestSuccess) {
              showDialog(
                context: context,
                barrierDismissible: false,
                builder: (context) => CustomAlertDialogNoConfirm(
                   title:
                  "تم استلام طلب المساعدة التعيلمية بنجاح. سيتم التعامل معه في أقرب وقت، نرجو متابعة الإشعارات لمعرفة حالة الطلب.",
              cancelText: "إغلاق",
              onCancel: () {
                    Navigator.of(context).pop();
                    Navigator.of(context).pushNamedAndRemoveUntil(
                        'NavigationMain', (route) => false);
                  },
                ),
              );
            } else if (state is EducationFormAlreadySubmitted) {
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
            } else if (state is EducationRequestFailure) {
              showDialog(
                context: context,
                barrierDismissible: false,
                builder: (context) => CustomAlertDialogNoConfirm(
                  title: "حدث خطأ ما ! يرجى المحاولة فيما بعد",
                  cancelText: "إغلاق",
                  onCancel: () {
                    Navigator.of(context).pop();
                    Navigator.of(context).pop();
                    context
                        .read<EducationFormCubit>()
                        .resetForm(); 
                    Navigator.of(context).pushNamedAndRemoveUntil(
                      'EducationScreen',
                      (route) => false,
                    );
                  },
                ),
              );
            }
          },
          builder: (context, requestState) {
            final isLoading = requestState is EducationRequestLoading;

            return Stack(
              children: [
                BlocBuilder<EducationFormCubit, int>(
                  builder: (context, currentPage) {
                    return IndexedStack(
                      index: currentPage,
                      children: [
                        FormPageOne(
                          onNext: (pageOneData) {
                            context
                                .read<EducationFormCubit>()
                                .savePageOneData(pageOneData);
                          },
                        ),
                        EducationForm(
                          isLoading: isLoading,
                          onBack: () {
                            context.read<EducationFormCubit>().goBack();
                          },
                          onSubmit: (pageTwoData) {
                            final allFormData =
                                context.read<EducationFormCubit>().allFormData;
                            final completeData = {
                              ...allFormData,
                              ...pageTwoData
                            };
                            context
                                .read<EducationRequestCubit>()
                                .sendEducationRequest(
                                  fullName: completeData['full_name'] ?? '',
                                  age: completeData['age'] is String
                                      ? int.tryParse(completeData['age']) ?? 0
                                      : completeData['age'] ?? 0,
                                  gender: completeData['gender'] ?? '',
                                  maritalStatus:
                                      completeData['marital_status'] ?? '',
                                  phoneNumber:
                                      completeData['phone_number'] ?? '',
                                  numberOfKids: completeData['number_of_kids']
                                          is String
                                      ? int.tryParse(
                                              completeData['number_of_kids']) ??
                                          0
                                      : completeData['number_of_kids'] ?? 0,
                                  kidsDescription:
                                      completeData['kids_description'] ?? '',
                                  governorate:
                                      completeData['governorate'] ?? '',
                                  homeAddress:
                                      completeData['home_address'] ?? '',
                                  monthlyIncome: completeData['monthly_income']
                                          is String
                                      ? int.tryParse(
                                              completeData['monthly_income']) ??
                                          0
                                      : completeData['monthly_income'] ?? 0,
                                  currentJob: completeData['current_job'] ?? '',
                                  monthlyIncomeSource:
                                      completeData['monthly_income_source'] ??
                                          '',
                                  numberOfNeedy: completeData['number_of_needy']
                                          is String
                                      ? int.tryParse(completeData[
                                              'number_of_needy']) ??
                                          0
                                      : completeData['number_of_needy'] ?? 0,
                                  description:
                                      completeData['description'] ?? '',
                                  expectedCost: completeData['expected_cost']
                                          is String
                                      ? int.tryParse(
                                              completeData['expected_cost']) ??
                                          0
                                      : completeData['expected_cost'] ?? 0,
                                  neededEducationalHelp: List<String>.from(
                                    completeData['needed_educational_help'] ??
                                        [],
                                  ),
                                );
                          },
                        ),
                      ],
                    );
                  },
                ),
                if (isLoading)
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
            );
          },
        ),
      ),
    );
  }
}

class EducationFormCubit extends Cubit<int> {
  EducationFormCubit() : super(0);

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
