import 'package:carousel_slider/carousel_slider.dart';
import 'package:flow/features/feature_settings/presentation/components/setting_types/theme_settings/appearance_carousel.dart';
import 'package:flow/features/feature_settings/presentation/components/setting_types/theme_settings/dark_theme_mockup.dart';
import 'package:flow/features/feature_settings/presentation/components/setting_types/theme_settings/light_theme_mockup.dart';
import 'package:flutter/material.dart';

class AppearanceSection extends StatefulWidget {
  const AppearanceSection({super.key});

  @override
  State<AppearanceSection> createState() => _AppearanceSectionState();
}

class _AppearanceSectionState extends State<AppearanceSection> {
  late final List<Widget> themeMockups;

  @override
  void initState() {
    super.initState();

    themeMockups = const [LightThemeMockup(), DarkThemeMockup()];
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Appearance",
          style: Theme.of(context).textTheme.titleSmall,
        ),
        const SizedBox(
          height: 16,
        ),
        // themes carousel
        CarouselSlider.builder(
            itemCount: themeMockups.length,
            itemBuilder: (context, index, realIndex) {
              return AppearanceCarousel(mockup: themeMockups[index], index: index,);
            },
            options: CarouselOptions(
              height: 400,
              enableInfiniteScroll: false,
              viewportFraction: 0.7
            ))
      ],
    );
  }
}
