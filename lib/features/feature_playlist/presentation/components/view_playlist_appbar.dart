import 'package:flow/core/presentation/controller/core_controller.dart';
import 'package:flow/core/utils/extensions/text_extensions.dart';
import 'package:flow/features/feature_settings/presentation/controller/theme_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

SliverAppBar viewPlaylistAppBar() {
  final CoreController controller = Get.find();
  final ThemeController themeController = Get.find();

  return SliverAppBar(
    systemOverlayStyle: SystemUiOverlayStyle(
        statusBarColor: Theme.of(Get.context!).scaffoldBackgroundColor,
        statusBarIconBrightness:
            controller.brightness.value == Brightness.dark ||
                    themeController.selectedThemeMode.value == ThemeMode.dark
                ? Brightness.light
                : Brightness.dark),
    expandedHeight: 100,
    floating: false,
    elevation: 0,
    leading: IconButton(
        onPressed: () {},
        icon: Icon(
          Icons.arrow_back,
          color: Theme.of(Get.context!).iconTheme.color,
        )),
    pinned: true,
    backgroundColor: Theme.of(Get.context!).scaffoldBackgroundColor,
  );
}
