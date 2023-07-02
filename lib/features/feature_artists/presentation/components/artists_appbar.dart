import 'package:flow/core/presentation/controller/core_controller.dart';
import 'package:flow/core/utils/extensions/text_extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

SliverAppBar artistsAppBar() {
  final CoreController controller = Get.find();

  return SliverAppBar(
    systemOverlayStyle: SystemUiOverlayStyle(
        statusBarColor: Theme.of(Get.context!).scaffoldBackgroundColor,
        statusBarIconBrightness: controller.brightness.value == Brightness.dark
            ? Brightness.light
            : Brightness.dark),
    actions: [
      IconButton(
          onPressed: () {},
          icon: Icon(
            Icons.sort_rounded,
            color: Theme.of(Get.context!).iconTheme.color,
          )),
      IconButton(
          onPressed: () {},
          icon: Icon(
            Icons.search,
            color: Theme.of(Get.context!).iconTheme.color,
          )),
    ],
    expandedHeight: 100,
    leading: IconButton(
        onPressed: () => Get.back(),
        icon: Icon(
          Icons.arrow_back,
          color: Theme.of(Get.context!).iconTheme.color,
        )),
    floating: false,
    pinned: true,
    backgroundColor: Theme.of(Get.context!).scaffoldBackgroundColor,
    flexibleSpace: FlexibleSpaceBar(
      title: Text(
        "Artists",
        style: Theme.of(Get.context!).textTheme.titleSmall,
      ),
      centerTitle: true,
      collapseMode: CollapseMode.parallax,
    ),
  );
}
