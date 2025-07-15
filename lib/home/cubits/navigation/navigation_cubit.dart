

import 'package:charity_app/feature/Feedback/screen/feedback_screen.dart';
import 'package:charity_app/feature/request/screen/nutritional_screen.dart';
import 'package:charity_app/home/screens/home_screen.dart';

import 'package:charity_app/home/screens/request_status_screen.dart';
import 'package:charity_app/home/screens/setting.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';

class NavigationCubit extends Cubit<int> {
  NavigationCubit() : super(3); //هون عم نبلش من الهوم

  final List<Widget> pages = [
    const Setting(),
    FeedbackScreen(),
    const RequestStatusScreen(),
        const NutritionalScreen(),

    const HomeScreen()
  ];

  void changePage(int index) => emit(index); //مشان نحدث الستيت لتبني واجهتنا

  Widget get currentPage => pages[state];
}
