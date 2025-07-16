import 'package:flutter/material.dart';
import 'package:readmore/readmore.dart';

class CompletedProjectBox extends StatelessWidget {
  final String name;
  final String description;
  final String photoUrl;

  const CompletedProjectBox({
    super.key,
    required this.name,
    required this.description,
    required this.photoUrl,
  });

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size;
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          color: isDark ? Colors.grey[850] : const Color(0xFFF9F9F9),
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 2,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: SizedBox(
                    width: screenWidth.width * 0.35,
                    height: screenWidth.height * 0.30,
                    child: Image.asset(
                      photoUrl,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) =>
                          const Icon(Icons.broken_image, size: 40),
                    )),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '$name',
                      style: const TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: 14,
                      ),
                    ),
                    const SizedBox(height: 8),
                    ReadMoreText(
                      description,
                      trimLines: 6,
                      trimMode: TrimMode.Line,
                      trimCollapsedText: 'عرض المزيد',
                      trimExpandedText: 'عرض أقل',
                      moreStyle: const TextStyle(
                          color: Colors.grey, fontWeight: FontWeight.bold),
                      lessStyle: const TextStyle(
                          color: Colors.grey, fontWeight: FontWeight.bold),
                      style: const TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 12.5,
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
