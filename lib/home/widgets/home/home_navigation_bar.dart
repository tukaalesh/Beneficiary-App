import 'package:charity_app/core/extensions/context_extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../cubits/navigation/navigation_cubit.dart';

class HomeNavigationBar extends StatelessWidget {
  const HomeNavigationBar({super.key});

  void navigate(BuildContext context, int index) {
    final cubit = context.read<NavigationCubit>();
    cubit.changePage(index);
  }

  @override
  Widget build(BuildContext context) {
    final ColorScheme = context.colorScheme;
    return BlocBuilder<NavigationCubit, int>(
      builder: (context, selectedIndex) {
        return BottomNavigationBar(
          selectedItemColor: ColorScheme.primary,
          unselectedItemColor: Colors.grey,
          currentIndex: selectedIndex,
          onTap: (index) => navigate(context, index),
          items: const [
            BottomNavigationBarItem(
                icon: Icon(Icons.settings), label: 'الإعدادات'),
            BottomNavigationBarItem(
                icon: Icon(Icons.feedback_outlined), label: 'التقييم'),
            BottomNavigationBarItem(
                icon: Icon(Icons.assignment_turned_in), label: 'حالة الطلب'),
            BottomNavigationBarItem(
                icon: Icon(Icons.assignment), label: 'طلب المساعدة'),
            BottomNavigationBarItem(icon: Icon(Icons.home), label: 'الرئيسية'),
          ],
        );
      },
    );
  }
}
