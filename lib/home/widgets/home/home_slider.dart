// import 'package:carousel_slider/carousel_slider.dart';
// import 'package:charity_app/core/extensions/context_extensions.dart';
// import 'package:charity_app/home/cubits/slider_cubit.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:smooth_page_indicator/smooth_page_indicator.dart';

// class HomeSlider extends StatelessWidget {
//   const HomeSlider({super.key});

//   final List<String> imagePaths = const [
//     'assets/images/slider2.png',
//     "assets/images/1.png",
//     'assets/images/slider3.png',
//   ];

//   @override
//   Widget build(BuildContext context) {
//     final ColorScheme = context.colorScheme;
//     return BlocProvider(
//       create: (_) => SliderCubit(),
//       child: Scaffold(
//         backgroundColor: Colors.transparent,
//         body: Align(
//           alignment: Alignment.topCenter,
//           child: Column(
//             mainAxisSize: MainAxisSize.min,
//             children: [
//               BlocBuilder<SliderCubit, int>(
//                 //تحديث حالة الواجهة
//                 builder: (context, activeIndex) {
//                   return CarouselSlider.builder(
//                     itemCount: imagePaths.length,
//                     itemBuilder: (context, index, realIndex) {
//                       final imagePath = imagePaths[index];
//                       return ClipRRect(
//                         borderRadius: BorderRadius.circular(12),
//                         child: Image.asset(
//                           imagePath,
//                           fit: BoxFit.cover,
//                           width: double.infinity,
//                         ),
//                       );
//                     },
//                     options: CarouselOptions(
//                       height: 150,
//                       autoPlay: true,
//                       enlargeCenterPage: true,
//                       onPageChanged: (index, reason) {
//                         context.read<SliderCubit>().changeIndex(index);
//                       },
//                     ),
//                   );
//                 },
//               ),
//               const SizedBox(height: 12),
//               BlocBuilder<SliderCubit, int>(
//                 builder: (context, activeIndex) {
//                   return AnimatedSmoothIndicator(
//                     activeIndex: activeIndex, // هون بيجي الاندكس من الكيوبت
//                     count: imagePaths.length,
//                     effect: WormEffect(
//                       dotHeight: 8,
//                       dotWidth: 8,
//                       spacing: 6,
//                       dotColor: Colors.grey.shade300,
//                       activeDotColor: ColorScheme.primary,
//                     ),
//                   );
//                 },
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
