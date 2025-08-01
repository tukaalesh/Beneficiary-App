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
    final colorScheme = context.colorScheme;

    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: const ConstAppBar1(title: 'تقديم طلب مساعدة تعليمي'),
        backgroundColor: colorScheme.surface,
        body: BlocListener<EducationRequestCubit, EducationRequestState>(
          listener: (context, state) {
            final colorScheme = Theme.of(context).colorScheme;

            if (state is EducationRequestSuccess) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: const Text('تم إرسال طلب المساعدة بنجاح!'),
                  backgroundColor: colorScheme.secondary,
                ),
              );
            }
            // else if (state is EducationFormPhoneNumberAlreadyUsed) {
            //   ScaffoldMessenger.of(context).showSnackBar(
            //     const SnackBar(
            //       content: Text('رقم الهاتف مستخدم بالفعل، الرجاء استخدام رقم آخر.'),
            //     ),
            //   );
            // } else if (state is EducationFormAlreadySubmitted) {
            //   ScaffoldMessenger.of(context).showSnackBar(
            //     const SnackBar(
            //       content: Text('لقد قمت بتقديم الطلب من قبل بالفعل.'),
            //     ),
            //   );
            // }
            else if (state is EducationRequestFailure) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('حدث خطأ: ${state.message}'),
                ),
              );
            }
          },
          child: BlocBuilder<EducationRequestCubit, EducationRequestState>(
            builder: (context, requestState) {
              final isLoading = requestState is EducationRequestLoading;

              if (isLoading) {
                return Center(
                  child: SpinKitCircle(
                    size: 45,
                    color: colorScheme.secondary,
                  ),
                );
              }
              return BlocBuilder<EducationFormCubit, int>(
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
                          // print('Page Two Data: $pageTwoData');
                          final allFormData =
                              context.read<EducationFormCubit>().allFormData;
                          final completeData = {...allFormData, ...pageTwoData};
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
                                phoneNumber: completeData['phone_number'] ?? '',
                                numberOfKids: completeData['number_of_kids']
                                        is String
                                    ? int.tryParse(
                                            completeData['number_of_kids']) ??
                                        0
                                    : completeData['number_of_kids'] ?? 0,
                                kidsDescription:
                                    completeData['kids_description'] ?? '',
                                governorate: completeData['governorate'] ?? '',
                                homeAddress: completeData['home_address'] ?? '',
                                monthlyIncome: completeData['monthly_income']
                                        is String
                                    ? int.tryParse(
                                            completeData['monthly_income']) ??
                                        0
                                    : completeData['monthly_income'] ?? 0,
                                currentJob: completeData['current_job'] ?? '',
                                monthlyIncomeSource:
                                    completeData['monthly_income_source'] ?? '',
                                numberOfNeedy: completeData['number_of_needy']
                                        is String
                                    ? int.tryParse(
                                            completeData['number_of_needy']) ??
                                        0
                                    : completeData['number_of_needy'] ?? 0,
                                description: completeData['description'] ?? '',
                                expectedCost: completeData['expected_cost']
                                        is String
                                    ? int.tryParse(
                                            completeData['expected_cost']) ??
                                        0
                                    : completeData['expected_cost'] ?? 0,
                                neededEducationalHelp: List<String>.from(
                                  completeData['needed_educational_help'] ?? [],
                                ),
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
      ),
    );
  }
}

class EducationFormCubit extends Cubit<int> {
  EducationFormCubit() : super(0);

  final Map<String, dynamic> allFormData = {};

  void savePageOneData(Map<String, dynamic> pageOneData) {
    print('Received pageOneData: $pageOneData');
    allFormData.addAll(pageOneData);
    emit(1);
  }

  void goBack() {
    emit(0);
  }
}
