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
        url: 'baseUrl/api/projectstatuse/beneficiary',
        token: token,
      );

      final projectsJson = response['projects'];

      if (projectsJson == null || projectsJson is! List) {
        emit(RequestStatusSuccess([]));
        return;
      }

      final projects = projectsJson
          .map((json) => RequestStatusModel.fromJson(json))
          .toList();

      emit(RequestStatusSuccess(projects));
    } catch (e) {
      print(' Error in fetchRequestStatus: $e');

      if (e.toString().contains('404')) {
        emit(RequestStatusSuccess([]));
      } else {
        emit(RequestStatusError(message: 'حدث خطأ أثناء جلب البيانات: $e'));
      }
    }
  }
}
