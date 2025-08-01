// ignore_for_file: avoid_print

import 'package:charity_app/constants/const_appBar.dart';
import 'package:charity_app/core/extensions/context_extensions.dart';
import 'package:charity_app/feature/education/widget/form_page0ne.dart';
import 'package:charity_app/feature/health/cubit/nutritional_cubit.dart';
import 'package:charity_app/feature/health/cubit/nutritional_state.dart';
import 'package:charity_app/feature/health/widget/nutritional_form.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class NutritionalScreen extends StatelessWidget {
  const NutritionalScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = context.colorScheme;

    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: const ConstAppBar1(title: 'تقديم طلب مساعدة غذائية'),
        backgroundColor: colorScheme.surface,
        body: BlocListener<NutritionalRequestCubit, NutritionalRequestState>(
          listener: (context, state) {
            if (state is NutritionalRequestSuccess) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: const Text('تم إرسال طلب المساعدة بنجاح!'),
                  backgroundColor: colorScheme.secondary,
                ),
              );
            }
            // else if (state is NutritionalFormPhoneNumberAlreadyUsed) {
            //   ScaffoldMessenger.of(context).showSnackBar(
            //     const SnackBar(
            //       content: Text('رقم الهاتف مستخدم بالفعل، الرجاء استخدام رقم آخر.'),
            //     ),
            //   );
            // } else if (state is NutritionalFormAlreadySubmitted) {
            //   ScaffoldMessenger.of(context).showSnackBar(
            //     const SnackBar(
            //       content: Text('لقد قمت بتقديم الطلب من قبل بالفعل.'),
            //     ),
            //   );
            // }
            else if (state is NutritionalRequestFailure) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('حدث خطأ: ${state.message}'),
                ),
              );
            }
          },
          child: BlocBuilder<NutritionalRequestCubit, NutritionalRequestState>(
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
      ),
    );
  }
}

class NutritionalFormCubit extends Cubit<int> {
  NutritionalFormCubit() : super(0);

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
