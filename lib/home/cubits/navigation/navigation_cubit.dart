// ignore_for_file: prefer_const_constructors

import 'package:charity_app/feature/Feedback/screen/feedback_screen.dart';
import 'package:charity_app/feature/request_status/request_status/screen/request_status_screen.dart';
import 'package:charity_app/home/screens/home_screen.dart';
import 'package:charity_app/home/screens/setting.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';

class NavigationCubit extends Cubit<int> {
  NavigationCubit() : super(3);
  final List<Widget> pages = [
    Setting(),
    FeedbackScreen(),
    RequestStatusScreen(),
    HomeScreen()
  ];

  void changePage(int index) => emit(index);
  Widget get currentPage => pages[state];
}
