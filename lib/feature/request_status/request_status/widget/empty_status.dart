import 'package:charity_app/core/extensions/context_extensions.dart';
import 'package:flutter/material.dart';
class EmptyStatus extends StatelessWidget {
  const EmptyStatus({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = context.isDarkMode;
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/images/emptyscreen.png',
              height: 150,
            ),
            const SizedBox(height: 24),
            Text(
              'لا توجد أي طلبات مساعدة حاليًا',
              style: TextStyle(
                fontSize: 18,
                color: isDark ? Colors.grey[400] : Colors.black,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'لم تقم بتقديم أي طلب مساعدة بعد.\nعندما تقوم بإرسال طلب، ستتمكن من متابعة حالته هنا.',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 16,
                color: isDark ? Colors.grey[400] : Colors.grey,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
