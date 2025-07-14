// import 'package:charity_app/core/extensions/context_extensions.dart';
// import 'package:charity_app/core/extensions/widget_extentions.dart';

// import 'package:charity_app/home/screens/setting_drawer.dart';
// import 'package:charity_app/home/widgets/home/home_appbar.dart';
// import 'package:charity_app/home/widgets/home/home_slider.dart';
// import 'package:charity_app/home/widgets/home/section3.dart';

// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:flutter_spinkit/flutter_spinkit.dart';
// import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';

// class HomePage extends StatefulWidget {
//   const HomePage({super.key});

//   @override
//   State<HomePage> createState() => _HomePageState();
// }

// // class _HomePageState extends State<HomePage> {
// //   @override
// //   void initState() {
// //     super.initState();
// //     WidgetsBinding.instance.addPostFrameCallback((_) {
// //       context.read<DonationCubit>().loadProjects();
// //     });
// //   }

//   @override
//   Widget build(BuildContext context) {
//     final ColorScheme = context.colorScheme;
//     return Scaffold(
//       appBar: const appBarWidget(),
//       drawer: const SettingDrawer(),
//       // body: BlocConsumer<DonationCubit, DonationState>(
//       //   listener: (context, state) {
//       //     ScaffoldMessenger.of(context).clearSnackBars();
//       //     if (state is DonationError) {
//       //       ScaffoldMessenger.of(context).showSnackBar(
//       //         SnackBar(content: Text('حدث خطأ: ${state.message}')),
//       //       );
//       //     }
//       //   },
//       //   builder: (context, state) {
//       //     return Directionality(
//             textDirection: TextDirection.rtl,
//             child: RefreshIndicator(
//               onRefresh: () async {
//                 await context.read<DonationCubit>().loadProjects();
//               },
//               child: SingleChildScrollView(
//                 physics: const AlwaysScrollableScrollPhysics(),
//                 child: Padding(
//                   padding: const EdgeInsets.all(16),
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       const SizedBox(
//                         height: 180,
//                         width: double.infinity,
//                         child: HomeSlider(),
//                       ),
//                       Section3(
//                           key: ValueKey(DateTime.now().millisecondsSinceEpoch)),
//                       const SizedBox(height: 25),
//                       const DonationTitle(),
//                       const SizedBox(height: 16),
//                       Builder(
//                         builder: (_) {
//                           if (state is DonationLoading ||
//                               state is DonationInitial) {
//                             return SizedBox(
//                               height: 250,
//                               child: Center(
//                                 child: SpinKitCircle(
//                                   size: 45,
//                                   color: ColorScheme.secondary,
//                                 ),
//                               ),
//                             );
//                           } else if (state is DonationLoaded) {
//                             final projects = state.projects;
//                             return Column(
//                               crossAxisAlignment: CrossAxisAlignment.start,
//                               children: [
//                                 SizedBox(
//                                   height: 270,
//                                   child: AnimationLimiter(
//                                     child: ListView.builder(
//                                       scrollDirection: Axis.horizontal,
//                                       itemCount: projects.length,
//                                       itemBuilder: (context, index) {
//                                         return DonationCard(
//                                           project: projects[index],
//                                         ).staggerListVertical(index);
//                                       },
//                                     ),
//                                   ),
//                                 ),
//                               ],
//                             );
//                           } else if (state is DonationError) {
//                             return const Center(
//                               child: Text(
//                                 'تعذر تحميل المشاريع',
//                                 style: TextStyle(color: Colors.black54),
//                               ),
//                             );
//                           }

//                           return const SizedBox(height: 0);
//                         },
//                       ),
//                       const SizedBox(height: 16),
//                     ],
//                   ),
//                 ),
//               ),
//             ),
//           );
//         },
//       ),
//     );
//   }
// }
