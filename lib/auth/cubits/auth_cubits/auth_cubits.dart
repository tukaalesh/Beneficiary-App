// ignore_for_file: non_constant_identifier_names, avoid_print, equal_keys_in_map

import 'package:bloc/bloc.dart';
import 'package:charity_app/auth/cubits/auth_cubits/auth_states.dart';
import 'package:charity_app/helper/api.dart';
import 'package:charity_app/main.dart';

class AuthCubits extends Cubit<AuthStates> {
  AuthCubits() : super(InitializeState());
//التابع تبع إنشاء حساب
  Future<void> signUpFunction({
    required fullNameController,
    required emailController,
    required passwordConfirmationController,
    required passwordController,
    required phoneController,
  }) async {
    emit(LoadingStates());
    try {
      // final responseData =
      await Api().post(
        url: "$baseUrl/api/register/beneficiary",
        body: {
          "full_name": fullNameController.text,
          "email": emailController.text,
          "phone_number": phoneController.text,
          "password": passwordController.text,
          "password_confirmation": passwordConfirmationController.text,
        },
        token: '',
      );
      // final email = responseData['user']['email'];
      // await sharedPreferences.setString('email', email);

      emit(RegisterSuccessState());
    } catch (e) {
      print('ERROR CONTENT: ${e.toString()}');
      // RegiterAndEmailisUsed
      emit(RegisterFailureState(e.toString()));
    }
  }

//التابع تبع تسجيل دخول
  Future<void> logInFunction({
    required emailController,
    required passwordController,
  }) async {
    emit(LoadingStates());

    try {
      final response = await Api().post(
        url: "$baseUrl/api/login/beneficiary",
        body: {
          "email": emailController.text,
          "password": passwordController.text,
        },
        token: '',
      );

      final token = response['token'];
      await sharedPreferences.setString('token', token);
      print("$token");
      emit(LoginSuccessState());
    } catch (e) {
      emit(LoginFailureState(e.toString()));
    }
  }

//التابع تبع تسجيل خروج
  Future<void> logOutFunction() async {
    emit(LoadingStates());
    try {
      final token = sharedPreferences.getString('token');

      final response = await Api().post(
          url: "$baseUrl/api/logout/beneficiary", body: null, token: "$token");
      if (response["message"] == 'Logout successful') {
        emit(LogOutSuccess());
      } else {
        emit(LogOutFailure());
      }
    } catch (ex) {
      emit(LogOutFailure());
    }
  }
}
