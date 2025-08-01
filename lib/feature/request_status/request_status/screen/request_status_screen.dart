import 'package:charity_app/core/extensions/context_extensions.dart';
import 'package:charity_app/feature/request_status/request_status/cubit/request_status_cubit.dart';
import 'package:charity_app/feature/request_status/request_status/cubit/request_status_state.dart';
import 'package:charity_app/feature/request_status/request_status/widget/empty_status.dart';
import 'package:charity_app/feature/request_status/request_status/widget/request_status_card.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class RequestStatusScreen extends StatefulWidget {
  const RequestStatusScreen({super.key});

  @override
  State<RequestStatusScreen> createState() => _RequestStatusScreenState();
}

class _RequestStatusScreenState extends State<RequestStatusScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<RequestStatusCubit>().fetchRequestStatus();
    });
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = context.colorScheme;

    return BlocConsumer<RequestStatusCubit, RequestStatusState>(
     listener: (context, state) {
      print('Bloc Listener received state: $state');

  if (state is RequestStatusError) {
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('حدث خطأ: ${state.message}')),
    );
  }
},

      builder: (context, state) {
        return Directionality(
          textDirection: TextDirection.rtl,
          child: Scaffold(
            backgroundColor: colorScheme.surface,
            appBar: AppBar(
              title: const Text("تتبع حالة الطلب"),
              backgroundColor: colorScheme.surface,
              leading: null,
            ),
            body: RefreshIndicator(
              onRefresh: () async {
                await context.read<RequestStatusCubit>().fetchRequestStatus();
              },
              child: Builder(
                builder: (_) {
                  if (state is RequestStatusLoading ||
                      state is RequestStatusInitial) {
                    return Center(
                      child: SpinKitCircle(
                        size: 45,
                        color: colorScheme.secondary,
                      ),
                    );
                  } else if (state is RequestStatusSuccess) {
                    final projects = state.projects;

                    if (projects.isEmpty) {
                      return const EmptyStatus();
                    }

                    return ListView.builder(
                      padding: const EdgeInsets.all(20),
                      itemCount: projects.length,
                      itemBuilder: (context, index) {
                        return RequestStatusCard(project: projects[index]);
                      },
                    );
                  }

                  return const SizedBox.shrink();
                },
              ),
            ),
          ),
        );
      },
    );
  }
}
