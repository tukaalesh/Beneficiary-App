import 'package:charity_app/feature/health/cubit/nutritional_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:charity_app/helper/api.dart';
import 'package:charity_app/main.dart';

class NutritionalRequestCubit extends Cubit<NutritionalRequestState> {
  NutritionalRequestCubit() : super(NutritionalRequestInitial());

  Future<void> sendNutritionalRequest({
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
    required List<String> neededFoodHelp,
  }) async {
    emit(NutritionalRequestLoading());

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
        "needed_food_help": neededFoodHelp,
      };
      final responseData = await Api().postt(
        url: "http://$localhost/api/beneficiary/request/food",
        body: body,
        token: '$token',
      );

      print(responseData);

      if (responseData['message'] != null &&
          responseData['message'].toString().contains(
              "لا يمكنك تقديم طلب جديد قبل مرور 20 يوم على آخر طلب تم تقديمه.")) {
        emit(NutritionalRequestFailure(responseData['message'].toString()));
        return;
      }

      emit(NutritionalRequestSuccess());
    } catch (e) {
      emit(NutritionalRequestFailure('حدث خطأ أثناء إرسال الطلب: $e'));
    }
  }
}
