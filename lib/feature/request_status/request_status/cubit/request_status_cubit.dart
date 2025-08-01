// ignore_for_file: avoid_print

import 'package:charity_app/feature/request_status/request_status/model/request_status_model.dart';
import 'package:charity_app/main.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:charity_app/helper/api.dart';
import 'request_status_state.dart';

class RequestStatusCubit extends Cubit<RequestStatusState> {
  RequestStatusCubit() : super(RequestStatusInitial());

  Future<void> fetchRequestStatus() async {
    emit(RequestStatusLoading());

    try {
      final token = sharedPreferences.getString("token");
      final response = await Api().get(
        url: 'http://$localhost/api/projectstatuse/beneficiary',
        token: "$token",
      );

      print(response);

      final projectsJson = response['projects'] as List;
      final projects = projectsJson
          .map((json) => RequestStatusModel.fromJson(json))
          .toList();

      emit(RequestStatusSuccess(projects));
    } catch (e) {
      emit(RequestStatusError('حدث خطأ أثناء جلب البيانات: $e'));
    }
  }
}
