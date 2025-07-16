import 'package:charity_app/home/widgets/home/part3/completed_project_box.dart';
import 'package:flutter/material.dart';

class HomeSection3 extends StatelessWidget {
  const HomeSection3({super.key});

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "نماذج من المشاريع المنجزة لجمعيتنا",
            textAlign: TextAlign.right,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 12),
          CompletedProjectBox(
            name: " زراعة قوقعة أذنية لطفلة تعاني من فقدان شديد في السمع",
            description:
                'بعد تقييم دقيق وشامل لحالة الطفلة الصحية والسمعية، تم اتخاذ القرار الطبي بزراعة القوقعة كحل علاجي فعّال. تأتي هذه الخطوة لتفتح آفاقاً جديدة أمام الطفلة لاستعادة حاسة السمع، وتحسين مهارات النطق والتواصل، بما يضمن دمجها بشكل سلس في بيئتها التعليمية والاجتماعية، ويمهد لمستقبل أفضل.',
            photoUrl: "assets/images/completedproject1.jpg",
          ),
          CompletedProjectBox(
            name: 'إجراء عملية زراعة قلب لطفل',
            description:
                'نجحت العملية بفضل الله، وبفضل الدعم الكريم من كل من تبرع وساهم في إنجاحها. تم تقديم الرعاية اللازمة لمتابعة تعافي الطفل وتحسين جودة حياته، مع متابعة طبية دقيقة لضمان استقرار حالته الصحية.',
            photoUrl: "assets/images/completedproject2.jpg",
          ),
        ],
      ),
    );
  }
}
