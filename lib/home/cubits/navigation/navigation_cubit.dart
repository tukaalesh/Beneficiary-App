// ignore_for_file: prefer_const_constructors

import 'package:charity_app/feature/Feedback/screen/feedback_screen.dart';
import 'package:charity_app/home/screens/home_screen.dart';
import 'package:charity_app/home/screens/request_help.dart';
import 'package:charity_app/home/screens/request_status_screen.dart';
import 'package:charity_app/home/screens/setting.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';

class NavigationCubit extends Cubit<int> {
  NavigationCubit() : super(4);
  final List<Widget> pages = [
    Setting(),
    FeedbackScreen(),
    RequestStatusScreen(),
    RequestHelp(),
    HomeScreen()
  ];

  void changePage(int index) => emit(index); //مشان نحدث الستيت لتبني واجهتنا

  Widget get currentPage => pages[state];
}
