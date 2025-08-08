// ignore_for_file: avoid_print

import 'package:charity_app/feature/education/cubit/education_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:charity_app/helper/api.dart';
import 'package:charity_app/main.dart';

class EducationRequestCubit extends Cubit<EducationRequestState> {
  EducationRequestCubit() : super(EducationRequestInitial());

  Future<void> sendEducationRequest({
    required String fullName,
    required int age,
    required String gender,
    required String maritalStatus,
    required String phoneNumber,
    required int numberOfKids,
    required String kidsDescription,
    required String governorate,
    required String homeAddress,
    required int monthlyIncome,
    required String monthlyIncomeSource,
    required String currentJob,
    required int numberOfNeedy,
    required String description,
    required int expectedCost,
    required List<String> neededEducationalHelp,
  }) async {
    emit(EducationRequestLoading());

    try {
      final token = sharedPreferences.getString("token");
      final response = await Api().postt(
        url: "$baseUrl/api/beneficiary/request/educational",
        body: {
          "full_name": fullName,
          "age": age.toString(),
          "gender": gender,
          "marital_status": maritalStatus,
          "phone_number": phoneNumber,
          "number_of_kids": numberOfKids.toString(),
          "kids_description": kidsDescription,
          "governorate": governorate,
          "home_address": homeAddress,
          "monthly_income": monthlyIncome.toString(),
          "monthly_income_source": monthlyIncomeSource,
          "current_job": currentJob,
          "number_of_needy": numberOfNeedy.toString(),
          "description": description,
          "expected_cost": expectedCost.toString(),
          "needed_educational_help": neededEducationalHelp,
        },
        token: token,
      );
      print(response);
      if (response is Map<String, dynamic>) {
        final message = response['message']?.toString();
        print(" message: $message");

        if (message != null && message.contains("تم إرسال طلب المساعدة")) {
          emit(EducationRequestSuccess());
        } else if (message ==
            "لا يمكنك تقديم طلب جديد قبل مرور 20 يوم على آخر طلب تم تقديمه.") {
          final daysRemaining =
              (response["days_remaining"] as num?)?.toDouble();
          emit(EducationFormAlreadySubmitted(daysRemaining: daysRemaining));
        } else {
          emit(EducationRequestFailure(message: "رسالة غير معروفة من الخادم"));
        }
      } else {
        emit(EducationRequestFailure(message: ""));
      }
    } catch (e) {
      print(" Error : $e");

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
            emit(EducationFormAlreadySubmitted(daysRemaining: daysRemaining));
            return;
          } else {
            errorMessage = extractedMessage;
          }
        }
      } catch (parseError) {
        print("Failed to manually extract error: $parseError");
      }

      emit(EducationRequestFailure(message: errorMessage));
    }
  }
}
