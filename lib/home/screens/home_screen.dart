// ignore_for_file: unnecessary_const

import 'package:charity_app/constants/const_appBar.dart';
import 'package:charity_app/core/extensions/context_extensions.dart';
import 'package:charity_app/home/widgets/home/part1/home_slider.dart';
import 'package:charity_app/home/widgets/home/part2/home_section2.dart';
import 'package:charity_app/home/widgets/home/part3/home_section3.dart';

import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = context.colorScheme;

    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: colorScheme.surface,
        appBar: const ConstAppBar1(title: "الصفحة الرئيسية"),
        body: ListView(
          children: const [
            const SizedBox(
              height: 200,
              width: double.infinity,
              child: HomeSliderSection1(),
            ),
            const HomeSection2(),
            HomeSection3()
          ],
        ),
      ),
    );
  }
}
