import 'package:charity_app/feature/HealthSupport/screen/health_form_screen.dart';
import 'package:charity_app/feature/HousingSupport/screen/housing_form_screen.dart';
import 'package:flutter/material.dart';

class HomeSection2 extends StatelessWidget {
  const HomeSection2({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    final List<Map<String, dynamic>> supportOptions = [
      {
        "title": "دعم صحي",
        "icon": Icons.medical_services,
        "page": () => const HealthFormScreen(),
      },
      {
        "title": "دعم غذائي",
        "icon": Icons.fastfood,
        "page": () => const HealthFormScreen(),
      },
      {
        "title": "دعم سكني",
        "icon": Icons.cottage,
        "page": () => const HousingFormScreen(),
      },
      {
        "title": "دعم تعليمي",
        "icon": Icons.menu_book,
        "page": () => const HousingFormScreen(),
      },
    ];

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "ابدأ بطلب الدعم الذي يناسب حالتك",
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 16),
          SizedBox(
            height: 100,
            //بتحط فواصل واحسن من بيلدر
            child: ListView.separated(
              //مشان السكرول
              scrollDirection: Axis.horizontal,
              itemCount: supportOptions.length,
              separatorBuilder: (_, __) => const SizedBox(width: 30),
              itemBuilder: (context, index) {
                final item = supportOptions[index];
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => item["page"]()),
                    );
                  },
                  child: Column(
                    children: [
                      CircleAvatar(
                        radius: 30,
                        backgroundColor: Colors.grey[100],
                        child: Icon(
                          item["icon"],
                          size: 30,
                          color: colorScheme.secondary,
                        ),
                      ),
                      const SizedBox(height: 8),
                      SizedBox(
                        width: 70,
                        child: Text(
                          item["title"]!,
                          style: TextStyle(
                            fontSize: 12,
                            color: colorScheme.onSurface,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
