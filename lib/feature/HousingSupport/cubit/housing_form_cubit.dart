// ignore_for_file: equal_keys_in_map

import 'housing_form_state.dart';
import 'package:charity_app/helper/api.dart';
import 'package:charity_app/main.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HousingFormCubit extends Cubit<HousingFormState> {
  HousingFormCubit() : super(HousingFormInitial());
  Future<void> sendHousingCubit({
    required fullNameController,
    required ageController,
    required phoneNumberController,
    required numberOfChildrenController,
    required childrenDetailsController,
    required addressController,
    required monthlyIncomeController,
    required currentJobController,
    required descriptionController,
    required numberOfPeopleNeedingHousingController,
    required selectedHousingStatus,
    required selectedHelpType,
  }) async {
    emit(HousingFormLoading());
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
            "": numberOfPeopleNeedingHousingController.text,
            "": selectedHousingStatus,
            "": selectedHelpType,
          },
          token: token);
      emit(HousingFormSuccess());
    } catch (e) {
      print('ERROR CONTENT: ${e.toString()}');

      final errorString = e.toString();

      final match = RegExp(r'message: (.*?)\}').firstMatch(errorString);
      final message = match?.group(1);

      if (message != null) {
        if (message == "") {
          // emit(HousingFormPhoneNumberAlreadyUsed());
          return;
        }
        if (message == "") {
          // emit(HousingFormAlreadySubmitted());
          return;
        }
      }
      // emit(HousingFormFailure());
    }
  }
}
