// ignore_for_file: equal_keys_in_map

import 'package:charity_app/feature/HealthSupport/cubit/health_form_state.dart';
import 'package:charity_app/helper/api.dart';
import 'package:charity_app/main.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'dart:convert';

class HealthFormCubit extends Cubit<HealthFormState> {
  HealthFormCubit() : super(HealthFormInitial());

  Future<void> sendHealthCubit({
    required String fullNameController,
    required String ageController,
    required String phoneNumberController,
    required String numberOfChildrenController,
    required String childrenDetailsController,
    required String addressController,
    required String monthlyIncomeController,
    required String currentJobController,
    required String descriptionController,
    required String expectedCostController,
    required String selectedRiskOption,
    required String gender,
    required String maritalStatus,
    required String governorate,
    required String incomeSource,
  }) async {
    emit(HealthFormLoading());
    try {
      final token = sharedPreferences.getString("token");

      // if (token == null) {
      //   emit(HealthFormFailure(
      //       errorMessage:
      //           "رمز المصادقة غير موجود. يرجى تسجيل الدخول مرة أخرى."));
      //   return;
      // }

      await Api().postt(
        url: "http://$localhost/api/beneficiary/request/health",
        body: {
          "full_name": fullNameController,
          "age": ageController,
          "phone_number": phoneNumberController,
          "number_of_kids": numberOfChildrenController,
          "kids_description": childrenDetailsController,
          "home_address": addressController,
          "monthly_income": monthlyIncomeController,
          "current_job": currentJobController,
          "description": descriptionController,
          "expected_cost": expectedCostController,
          "severity_level": selectedRiskOption,
          "gender": gender,
          "marital_status": maritalStatus,
          "governorate": governorate,
          "monthly_income_source": incomeSource,
        },
        token: token,
      );

      emit(HealthFormSuccess());
    } catch (e) {
      String errorMessage = "حدث خطأ غير متوقع. يرجى المحاولة مرة أخرى.";
      double? daysRemaining;

      if (e is Exception) {
        final errorString = e.toString();

        final regex = RegExp(r'\{.*?\}');
        final match = regex.firstMatch(errorString);

        if (match != null) {
          final rawJsonString = match.group(0)!;

          try {
            final jsonErrorBody = jsonDecode(rawJsonString);

            if (jsonErrorBody is Map<String, dynamic>) {
              if (jsonErrorBody.containsKey("message")) {
                final message = jsonErrorBody["message"];

                if (message ==
                    "لا يمكنك تقديم طلب جديد قبل مرور 20 يوم على آخر طلب تم تقديمه.") {
                  daysRemaining =
                      (jsonErrorBody["days_remaining"] as num?)?.toDouble();
                  emit(
                      HealthFormAlreadySubmitted(daysRemaining: daysRemaining));
                  return;
                } else {
                  errorMessage = message;
                }
              }
            }
          } catch (jsonParseError) {
            errorMessage = ". يرجى المحاولة مرة أخرى";
          }
        } else {
          errorMessage =
              "Unknown API Error: ${errorString.replaceFirst('Exception: ', '')}";
        }
      } else {
        errorMessage = "An unexpected error type occurred.";
      }

      emit(HealthFormFailure(errorMessage: errorMessage));
    }
  }
}
