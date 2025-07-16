// ignore_for_file: unused_local_variable, avoid_print, non_constant_identifier_names

import 'package:charity_app/feature/Feedback/cubit/feedback_states.dart';
import 'package:charity_app/helper/api.dart';
import 'package:charity_app/main.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FeedbackCubit extends Cubit<FeedbackStates> {
  FeedbackCubit() : super(FeedBackInitialize());
  Future<void> sendFeedBack({
    required user_name,
    required message,
  }) async {
    emit(FeedBackLoading());
    try {
      final token = sharedPreferences.getString("token");
      final responseData = await Api().post(
        url: "http://$localhost/api/feedback/beneficiary",
        body: {
          "user_name": user_name.text,
          "message": message.text,
        },
        token: '$token',
      );
      emit(FeedBackSuccess());
    } catch (e) {
      print('ERROR CONTENT: ${e.toString()}');

      final errorString = e.toString();

      final match = RegExp(r'message: (.*?)\}').firstMatch(errorString);
      final message = match?.group(1);

      if (message != null) {
        if (message ==
            "يجب أن تقوم بتقديم طلب مساعدة واحد على الأقل قبل إرسال الفيدباك.") {
          emit(FeedBackNotAllowed());
          return;
        }
      }
      emit(FeedBackFailure());
    }
  }
}
