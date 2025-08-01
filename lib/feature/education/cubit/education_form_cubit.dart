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
      final body = {
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
      };

      final responseData = await Api().postt(
        url: "http://$localhost/api/beneficiary/request/educational",
        body: body,
        token: '$token',
      );
      print(responseData);

      if (responseData['message'] != null &&
          responseData['message'].toString().contains(
                "لا يمكنك تقديم طلب جديد قبل مرور 20 يوم على آخر طلب تم تقديمه.",
              )) {
        emit(EducationRequestFailure(responseData['message'].toString()));
        return;
      }

      emit(EducationRequestSuccess());
    } catch (e) {
      emit(EducationRequestFailure('حدث خطأ أثناء إرسال الطلب: $e'));
    }
  }
}
