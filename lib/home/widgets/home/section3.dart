// import 'package:charity_app/core/extensions/context_extensions.dart';
// import 'package:charity_app/core/extensions/widget_extentions.dart';

// import 'package:flutter/material.dart';
// import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';

// class Section3 extends StatelessWidget {
//   const Section3({super.key});

//   @override
//   Widget build(BuildContext context) {
//     final isDark = context.isDarkMode;
//     final List<SectionItem> items = [
//       SectionItem(
//         title: "مشاريع التطوع",
//         image: "assets/images/closure.png",
//         onTap: () {
//           Navigator.pushNamed(context, 'VolunteeringFields');
//         },
//       ),
//       SectionItem(
//         title: "استبيان التطوع",
//         image: "assets/images/form.png",
//         onTap: () {
//           Navigator.pushNamed(context, 'VolunteerForm');
//         },
//       ),
//       SectionItem(
//         title: "التبرع الشهري",
//         image: "assets/images/costs.png",
//         onTap: () {
//           Navigator.pushNamed(context, 'EnableMonthlyOnation');
//         },
//       ),
//       SectionItem(
//         title: "أبرز المحسنين",
//         image: "assets/images/section2.png",
//         onTap: () {
//           // Navigator.push(
//           //   context,
//           //   MaterialPageRoute(builder: (_) => const TheBestPage()),
//           // );
//         },
//       ),
//       SectionItem(
//         title: "آراء المستفيدين",
//         image: "assets/images/feedback.png",
//         onTap: () {
//           // Navigator.push(
//           //   context,
//           //   MaterialPageRoute(builder: (_) => const FeedbackPage()),
//           // );
//         },
//       ),
//       SectionItem(
//         title: "المشاريع المنجزة",
//         image: "assets/images/complete-task.png",
//         onTap: () {
//           Navigator.pushNamed(context, 'CompletedProjects');
//         },
//       ),
//     ];

//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Text(
//           'أخبار الجمعية',
//           style: TextStyle(
//               color: isDark ? Colors.grey[400] : Colors.black,
//               fontSize: 20,
//               fontWeight: FontWeight.bold),
//         ),
//         const SizedBox(height: 16),
//         SizedBox(
//           height: 100,
//           child: AnimationLimiter(
//             child: ListView.builder(
//               scrollDirection: Axis.horizontal,
//               itemCount: items.length,
//               itemBuilder: (context, index) {
//                 final item = items[index];
//                 return GestureDetector(
//                   onTap: item.onTap,
//                   child: Container(
//                     width: 140,
//                     margin: const EdgeInsets.only(right: 12),
//                     decoration: BoxDecoration(
//                       color:
//                           isDark ? Colors.grey[850] : const Color(0xFFF3F4F6),

//                       borderRadius: BorderRadius.circular(15),
//                       // boxShadow: [
//                       //   BoxShadow(
//                       //     blurRadius: 3,
//                       //     offset: const Offset(5, 5),
//                       //     color: Colors.grey.withOpacity(0.1),
//                       //   ),
//                       //   BoxShadow(
//                       //     blurRadius: 3,
//                       //     offset: const Offset(-5, -5),
//                       //     color: Colors.grey.withOpacity(0.1),
//                       //   ),
//                       // ],
//                     ),
//                     child: Column(
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       children: [
//                         Image.asset(
//                           item.image,
//                           width: 30,
//                           height: 30,
//                         ),
//                         const SizedBox(height: 10),
//                         Text(
//                           item.title,
//                           textAlign: TextAlign.center,
//                           style: TextStyle(
//                             fontSize: 16,
//                             color: isDark ? Colors.grey[400] : Colors.black,
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ).staggerListVertical(index);
//               },
//             ),
//           ),
//         ),
//       ],
//     );
//   }
// }

// class SectionItem {
//   final String title;
//   final String image;
//   final VoidCallback onTap;

//   SectionItem({
//     required this.title,
//     required this.image,
//     required this.onTap,
//   });
// }
