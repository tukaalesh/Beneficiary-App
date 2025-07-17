// ignore_for_file: equal_keys_in_map

import 'package:charity_app/feature/HealthSupport/cubit/health_form_state.dart';
import 'package:charity_app/helper/api.dart';
import 'package:charity_app/main.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HealthFormCubit extends Cubit<HealthFormState> {
  HealthFormCubit() : super(HealthFormInitial());
  Future<void> sendHealthCubit(
      {required fullNameController,
      required ageController,
      required phoneNumberController,
      required numberOfChildrenController,
      required childrenDetailsController,
      required addressController,
      required monthlyIncomeController,
      required currentJobController,
      required descriptionController,
      required expectedCostController,
      required selectedRiskOption}) async {
    emit(HealthFormLoading());
    try {
      final token = sharedPreferences.getString("token");
      Api().post(
          url: "",
          body: {
            "": fullNameController.text,
            "": ageController.text,
            "": phoneNumberController.text,
            "": numberOfChildrenController.text,
            "": childrenDetailsController.text,
            "": addressController.text,
            "": monthlyIncomeController.text,
            "": currentJobController.text,
            "": descriptionController.text,
            "": expectedCostController.text,
            "": selectedRiskOption,
          },
          token: token);
      emit(HealthFormSuccess());
    } catch (e) {
      print('ERROR CONTENT: ${e.toString()}');

      final errorString = e.toString();

      final match = RegExp(r'message: (.*?)\}').firstMatch(errorString);
      final message = match?.group(1);

      if (message != null) {
        if (message == "") {
          // emit(HealthFormPhoneNumberAlreadyUsed());
          return;
        }
        if (message == "") {
          // emit(HealthFormAlreadySubmitted());
          return;
        }
      }
      // emit(HealthFormFailure());
    }
  }
}
