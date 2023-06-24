import 'package:flow/features/feature_settings/presentation/controller/theme_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AppearanceCarousel extends StatefulWidget {
  final Widget mockup;
  final int index;

  const AppearanceCarousel(
      {super.key, required this.mockup, required this.index});

  @override
  State<AppearanceCarousel> createState() => _AppearanceCarouselState();
}

class _AppearanceCarouselState extends State<AppearanceCarousel> {
  late final ThemeController _themeController;

  @override
  void initState() {
    super.initState();
    _themeController = Get.find<ThemeController>();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => _themeController.setSelectedThemeIndex(index: widget.index),
      child: Column(
        children: [
          widget.mockup,
          const SizedBox(
            height: 16,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Obx(
                () => Radio(
                    value: _themeController.themeTypes[widget.index],
                    groupValue: _themeController
                        .themeTypes[_themeController.selectedThemeIndex.value],
                    onChanged: (value) => _themeController
                        .setSelectedThemeIndex(index: widget.index)),
              ),
              Text(
                _themeController.themeTypes[widget.index],
                style: Theme.of(context).textTheme.bodyMedium,
              )
            ],
          )
        ],
      ),
    );
  }
}
