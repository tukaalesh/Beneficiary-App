import 'package:charity_app/core/extensions/context_extensions.dart';
import 'package:flutter/material.dart';

class ConstAppBar extends StatelessWidget implements PreferredSizeWidget {
  const ConstAppBar({super.key, required this.title});

  final String title;

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    final colorScheme = context.colorScheme;
    return AppBar(
      backgroundColor: colorScheme.surface,
      iconTheme: IconThemeData(color: colorScheme.onSurface),
      title: Text(
        title,
        style: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
          color: colorScheme.onSurface,
        ),
      ),
      leading: IconButton(
        icon: const Icon(Icons.arrow_back_ios_new),
        onPressed: () {
          Navigator.of(context).pop();
        },
      ),
      elevation: 0,
    );
  }
}

//إخفاء السهم
class ConstAppBar1 extends StatelessWidget implements PreferredSizeWidget {
  const ConstAppBar1({super.key, required this.title});

  final String title;

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    final colorScheme = context.colorScheme;
    final isDark = context.isDarkMode;
    return AppBar(
      automaticallyImplyLeading: false,
      backgroundColor: colorScheme.surface,
      // iconTheme: IconThemeData(color: colorScheme.onSurface),
      title: Text(
        title,
        style: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
          color: colorScheme.onSurface,
        ),
      ),
      leading: IconButton(
        icon: Icon(Icons.arrow_back_ios_new,
            color: isDark ? Colors.grey[400] : Colors.black),
        onPressed: () {},
      ),
      elevation: 0,
    );
  }
}
