import 'package:carousel_slider/carousel_slider.dart';
import 'package:flow/features/feature_settings/presentation/components/setting_types/theme_settings/appearance_carousel.dart';
import 'package:flow/features/feature_settings/presentation/components/setting_types/theme_settings/dark_theme_mockup.dart';
import 'package:flow/features/feature_settings/presentation/components/setting_types/theme_settings/light_theme_mockup.dart';
import 'package:flow/features/feature_settings/presentation/controller/theme_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AppearanceSection extends StatefulWidget {
  const AppearanceSection({super.key});

  @override
  State<AppearanceSection> createState() => _AppearanceSectionState();
}

class _AppearanceSectionState extends State<AppearanceSection> {
  late final List<Widget> themeMockups;
  late final CarouselController _carouselController;
  late final ThemeController _themeController;

  @override
  void initState() {
    super.initState();

    themeMockups = const [LightThemeMockup(), DarkThemeMockup(), LightThemeMockup()];
    _carouselController = CarouselController();
    _themeController = Get.find<ThemeController>();

    // _carouselController.animateToPage(_themeController.selectedThemeIndex.value);
  }

  @override
  Widget build(BuildContext context) {

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // themes carousel
        CarouselSlider.builder(
            itemCount: themeMockups.length,
            itemBuilder: (context, index, realIndex) {
              return AppearanceCarousel(mockup: themeMockups[index], index: index,);
            },
            carouselController: _carouselController,
            options: CarouselOptions(
              height: 450,
              enableInfiniteScroll: false,
              viewportFraction: 0.7,
            ))
      ],
    );
  }
}
