import 'package:flow/core/presentation/controller/core_controller.dart';
import 'package:flow/core/utils/extensions/text_extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

SliverAppBar settingsAppBar() {
  final CoreController controller = Get.find();

  return SliverAppBar(
    systemOverlayStyle: SystemUiOverlayStyle(
        statusBarColor: Theme.of(Get.context!).scaffoldBackgroundColor,
        statusBarIconBrightness: controller.brightness.value == Brightness.dark
            ? Brightness.light
            : Brightness.dark),
    expandedHeight: 100,
    floating: false,
    pinned: true,
    backgroundColor: Theme.of(Get.context!).scaffoldBackgroundColor,
    flexibleSpace: FlexibleSpaceBar(
      title: Text(
        "Settings",
        style: Theme.of(Get.context!).textTheme.titleSmall,
      ),
      centerTitle: true,
      collapseMode: CollapseMode.parallax,
    ),
  );
}
