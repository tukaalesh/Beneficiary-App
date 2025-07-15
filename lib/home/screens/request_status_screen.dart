import 'package:charity_app/constants/const_appBar.dart';
import 'package:charity_app/constants/const_image.dart';
import 'package:charity_app/core/extensions/context_extensions.dart';
import 'package:flutter/material.dart';

class RequestStatusScreen extends StatelessWidget {
  const RequestStatusScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = context.colorScheme;
    double donatedAmount = 1800;
    double targetAmount = 2000;
    double progress = donatedAmount / targetAmount;

    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: const ConstAppBar1(title: 'تتبع حالة طلبك'),
        backgroundColor: Colors.white,
        body: SafeArea(
          child: Center(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
                decoration: BoxDecoration(
                  
                  color: const Color(0xFFF5F5F5),
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: const [
                    BoxShadow(
                      color: Colors.black12,
                      blurRadius: 10,
                      offset: Offset(0, 4),
                    ),
                  ],
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      "تتبع حالة طلبك",
                      style: TextStyle(
                        color: colorScheme.secondary,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(
                      height: 280,
                      width: 280,
                      child: charityLogoImage,
                    ),
                    const SizedBox(height: 18),
                    const Text(
                      "تقديم مساعدة صحية لأحد المحتاجين",
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.black87,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 20),
                    LinearProgressIndicator(
                      value: progress,
                      minHeight: 6,
                      backgroundColor: Colors.grey[300],
                      valueColor:
                          AlwaysStoppedAnimation<Color>(colorScheme.primary),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      "تم التبرع بـ ${donatedAmount.toInt()} من أصل ${targetAmount.toInt()}",
                      style: const TextStyle(
                        fontSize: 14,
                        color: Colors.black54,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
