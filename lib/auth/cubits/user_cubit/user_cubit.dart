// // user_cubit.dart
// import 'package:bloc/bloc.dart';
// import 'package:charity_app/auth/cubits/user_cubit/user_states.dart';
// import 'package:charity_app/auth/model/user_model.dart';
// import 'package:charity_app/helper/api.dart';
// import 'package:charity_app/main.dart';

// class UserCubit extends Cubit<UserState> {
//   UserCubit() : super(UserInitialState());
// //التابع المسؤول عن أنو يجيب معلومات اليورز
//   Future<void> getUserData(String token) async {
//     try {
//       final token = sharedPreferences.getString('token');
//       emit(UserLoadingState());
//       final response = await Api()
//           .get(url: "http://$localhost/api/getUser", token: "$token");

//       final data = Map<String, dynamic>.from(response);

//       // final unreadPoints = response["number of unread notifications"];
//       // await sharedPreferences.setString(
//       // "unreadPoints", unreadPoints.toString());
//       // await sharedPreferences.setString('balance', balance.toString());
//       final user = UserModel.fromJson(data);
//       emit(UserSuccessState(user));
//     } catch (e) {
//       emit(UserErrorState(e.toString()));
//     }
//   }

//   //مسؤول عن أنو يصفر عدد الرسائل
//   // copyWith ليعدل على قيمه عدد الرسائل الغير مقروءة ويخليها صفر
//   //هي بحال فتت على الأشعارات وبدي اطلع
//   //ف بدي صفر عدد الرسائل الغير مقروءه
//   void clearUnreadPoints() {
//     final currentState = state;
//     if (currentState is UserSuccessState) {
//       final updatedUser = currentState.user.copyWith(unreadNotifications: 0);
//       emit(UserSuccessState(updatedUser));
//     }
//   }

//   // تحديث الرصيد
//   void updateBalance(int newBalance) {
//     final currentState = state;
//     if (currentState is UserSuccessState) {
//       final updatedUser = currentState.user.copyWith(balance: newBalance);
//       emit(UserSuccessState(updatedUser));
//     }
//   }

// // تحديث عدد النقاط
//   void updatePoints(int newPoints) {
//     final currentState = state;
//     if (currentState is UserSuccessState) {
//       final updatedUser = currentState.user.copyWith(points: newPoints);
//       emit(UserSuccessState(updatedUser));
//     }
//   }

// // تحديث عدد الإشعارات
//   void updateNotifications(int newCount) {
//     final currentState = state;
//     if (currentState is UserSuccessState) {
//       final updatedUser =
//           currentState.user.copyWith(unreadNotifications: newCount);
//       emit(UserSuccessState(updatedUser));
//     }
//   }
// }
