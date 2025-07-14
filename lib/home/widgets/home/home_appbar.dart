// import 'package:charity_app/core/extensions/context_extensions.dart';
// import 'package:flutter/material.dart';

// class appBarWidget extends StatelessWidget implements PreferredSizeWidget {
//   const appBarWidget({super.key});

//   @override
//   Widget build(BuildContext context) {
//     final colorScheme = context.colorScheme;
//     return AppBar(
//       backgroundColor: Colors.transparent,
//       elevation: 0,
//       leadingWidth: 140,
//       leading: Padding(
//         padding: const EdgeInsets.only(left: 12),
//         child: Builder(
//           builder: (context) => Row(
//             children: [
//               IconButton(
//                 icon: const Icon(Icons.menu),
//                 color: colorScheme.primary,
//                 iconSize: 30,
//                 onPressed: () {
//                   Scaffold.of(context).openDrawer();
//                 },
//               ),
//               const SizedBox(width: 8),
//               // IconButton(
//               //   icon: const Icon(Icons.notifications_none),
//               //   color: colorScheme.primary,
//               //   iconSize: 30,
//               //   onPressed: () {
//               //     Navigator.pushNamed(context, 'NotifictionPage');
//               //   },
//               // ),
//             ],
//           ),
//         ),
//       ),
//       actions: const [
//         Padding(
//           padding: EdgeInsets.only(left: 15, right: 15, top: 8),
//           child: Text(
//             'الصفحة الرئيسية',
//             style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
//           ),
//         )
//       ],
//     );
//   }

//   @override
//   Size get preferredSize =>
//       const Size.fromHeight(kToolbarHeight); //هاد شي ثابت بفلاتر ارتفاعه 56
// }
