import 'package:carousel_slider/carousel_slider.dart';
import 'package:charity_app/core/extensions/context_extensions.dart';
import 'package:charity_app/home/cubits/slider_cubit.dart';
import 'package:charity_app/home/widgets/home/part1/container_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class HomeSliderSection1 extends StatelessWidget {
  const HomeSliderSection1({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = context.colorScheme;

    final List<Widget> containerSlides = [
      CustomContainerSlider(
        imagePath: "assets/images/care.png",
        title: "كيف نقدم المساعدة؟",
        description:
            "نقدّم الدعم للأسر المحتاجة عبر مساعدات غذائية، تعليمية، صحية وسكنية، وننفّذ مبادرات مجتمعية بالتعاون مع متطوعين ومتبرعين.",
        backgroundColor: colorScheme.secondary,
      ),
      CustomContainerSlider(
          imagePath: "assets/images/online-chat.png",
          title: "مهمتنا",
          description:
              "تقديم الدعم الإنساني والاجتماعي للأسر المحتاجة عبر مبادرات مستدامة، وتعزيز قيم التضامن والعطاء لبناء مجتمع متماسك يسوده الرحمة.",
          backgroundColor: colorScheme.secondary),
      CustomContainerSlider(
        imagePath: "assets/images/contact-us.png",
        title: "كيف تتواصل معنا؟",
        description:
            "إذا كنت بحاجة للمساعدة، نحن هنا من أجلك. تواصل معنا بسهولة عبر الهاتف، الرسائل، أو زيارة مراكز الدعم.",
        backgroundColor: colorScheme.secondary,
      ),
    ];

    return BlocProvider(
      create: (_) => SliderCubit(),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Align(
          alignment: Alignment.topCenter,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              BlocBuilder<SliderCubit, int>(
                builder: (context, activeIndex) {
                  return CarouselSlider.builder(
                    itemCount: containerSlides.length,
                    itemBuilder: (context, index, realIndex) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: containerSlides[index],
                      );
                    },
                    options: CarouselOptions(
                      height: 180,
                      autoPlay: true,
                      enlargeCenterPage: true,
                      viewportFraction: 1,
                      onPageChanged: (index, reason) {
                        context.read<SliderCubit>().changeIndex(index);
                      },
                    ),
                  );
                },
              ),
              // const SizedBox(height: 12),
              BlocBuilder<SliderCubit, int>(
                builder: (context, activeIndex) {
                  return AnimatedSmoothIndicator(
                    activeIndex: activeIndex,
                    count: containerSlides.length,
                    effect: WormEffect(
                      dotHeight: 7,
                      dotWidth: 7,
                      spacing: 4,
                      dotColor: Colors.grey.shade300,
                      activeDotColor: colorScheme.secondary,
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
