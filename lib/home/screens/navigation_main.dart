import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:charity_app/home/widgets/home/home_navigation_bar.dart';
import 'package:charity_app/home/cubits/navigation/navigation_cubit.dart';

class NavigationMain extends StatelessWidget {
  const NavigationMain({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NavigationCubit, int>(
      builder: (context, state) {
        final cubit = context.read<NavigationCubit>();
        return Scaffold(
          body: cubit.currentPage,
          bottomNavigationBar: const HomeNavigationBar(),
        );
      },
    );
  }
}
