import 'package:flow/core/presentation/controller/core_controller.dart';
import 'package:flow/core/utils/extensions/text_extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

SliverAppBar themeSettingAppBar() {
  final CoreController controller = Get.find();

  return SliverAppBar(
    systemOverlayStyle: SystemUiOverlayStyle(
        statusBarColor: Theme.of(Get.context!).scaffoldBackgroundColor,
        statusBarIconBrightness: controller.brightness.value == Brightness.dark
            ? Brightness.light
            : Brightness.dark),
    floating: false,
    pinned: true,
    leading: IconButton(
        onPressed: () => Get.back(canPop: true),
        icon: Icon(
          Icons.arrow_back,
          color: Theme.of(Get.context!).iconTheme.color,
        )),
    backgroundColor: Theme.of(Get.context!).scaffoldBackgroundColor,
    flexibleSpace: FlexibleSpaceBar(
      title: Text(
        "Theme",
        style: Theme.of(Get.context!).textTheme.titleSmall,
      ),
      centerTitle: true,
      collapseMode: CollapseMode.parallax,
    ),
  );
}
