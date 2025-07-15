import 'package:charity_app/constants/const_appBar.dart';
import 'package:charity_app/core/extensions/context_extensions.dart';
import 'package:charity_app/feature/request/widget/form_page0ne.dart';
import 'package:charity_app/feature/request/widget/form_pageTwo.dart';
import 'package:flutter/material.dart';

class NutritionalScreen extends StatefulWidget {
  const NutritionalScreen({super.key});

  @override
  State<NutritionalScreen> createState() => _NutritionalScreenState();
}

class _NutritionalScreenState extends State<NutritionalScreen> {
  int currentPage = 0;

  final Map<String, dynamic> allFormData = {};

  void goToNextPage(Map<String, String> pageOneData) {
    allFormData.addAll(pageOneData);
    setState(() => currentPage = 1);
  }

  void submitForm(Map<String, dynamic> pageTwoData) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text("تم الإرسال"),
        content: const Text("تم إرسال طلب المساعدة بنجاح."),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("تم"),
          ),
        ],
      ),
    );
  }

  void goBack() => setState(() => currentPage = 0);

  @override
  Widget build(BuildContext context) {
    final colorScheme = context.colorScheme;

    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: const ConstAppBar1(title: 'تقديم طلب مساعدة غذائي'),
        backgroundColor: colorScheme.surface,
        body: IndexedStack(
          index: currentPage,
          children: [
            FormPageOne(
              onNext: goToNextPage,
              colorScheme: colorScheme,
            ),
            FormPageTwo(
              onSubmit: submitForm,
              onBack: goBack,
              colorScheme: colorScheme,
            ),
          ],
        ),
      ),
    );
  }
}
