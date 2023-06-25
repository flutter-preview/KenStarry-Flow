import 'package:flow/core/utils/extensions/string_extensions.dart';
import 'package:flow/features/feature_settings/domain/model/theme_type.dart';
import 'package:flow/features/feature_settings/presentation/controller/theme_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../../core/domain/models/user.dart';
import '../../../../../../core/presentation/controller/user_controller.dart';

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
  late final UserController _userController;

  @override
  void initState() {
    super.initState();
    _themeController = Get.find<ThemeController>();
    _userController = Get.find<UserController>();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        _themeController.setSelectedThemeIndex(index: widget.index);
      },
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
                    fillColor: MaterialStateProperty.all((_themeController
                        .selectedAccentColorHex.value.toColor as Color)),
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
