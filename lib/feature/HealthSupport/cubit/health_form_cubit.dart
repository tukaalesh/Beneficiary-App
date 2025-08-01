// ignore_for_file: dead_code_catch_following_catch, unused_catch_stack, avoid_print

import 'package:charity_app/feature/HealthSupport/cubit/health_form_state.dart';
import 'package:charity_app/helper/api.dart';
import 'package:charity_app/main.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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

      final response = await Api().postt(
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

      print(" Response from API: $response");

      if (response is Map<String, dynamic>) {
        final message = response['message']?.toString();
        print(" message: $message");

        if (message == "تم إرسال طلب المساعدة الصحية بنجاح") {
          emit(HealthFormSuccess());
        } else if (message ==
            "لا يمكنك تقديم طلب جديد قبل مرور 20 يوم على آخر طلب تم تقديمه.") {
          final daysRemaining =
              (response["days_remaining"] as num?)?.toDouble();
          emit(HealthFormAlreadySubmitted(daysRemaining: daysRemaining));
        } else {
          emit(HealthFormFailure(
              errorMessage: message ?? "رسالة غير معروفة من الخادم"));
        }
      } else {
        emit(HealthFormFailure(errorMessage: "  ايروررر ايرورورورو"));
      }
    } catch (e, stackTrace) {
      print(" Error occurred: $e");
      // print(" StackTrace: $stackTrace");

      String errorMessage = "حدث خطأ غير متوقع. حاول مرة أخرى.";
      double? daysRemaining;

      try {
        final msgMatch =
            RegExp(r'message:\s?([^,}]+)').firstMatch(e.toString());
        final daysMatch =
            RegExp(r'days_remaining:\s?(\d+)').firstMatch(e.toString());

        final extractedMessage = msgMatch?.group(1)?.trim();
        if (extractedMessage != null) {
          if (extractedMessage.contains("لا يمكنك تقديم طلب جديد")) {
            daysRemaining = double.tryParse(daysMatch?.group(1) ?? '');
            emit(HealthFormAlreadySubmitted(daysRemaining: daysRemaining));
            return;
          } else {
            errorMessage = extractedMessage;
          }
        }
      } catch (parseError) {
        print("Failed to manually extract error: $parseError");
      }

      emit(HealthFormFailure(errorMessage: errorMessage));
    }
  }
}
