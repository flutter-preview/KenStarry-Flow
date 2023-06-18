import 'package:flow/core/presentation/controller/core_controller.dart';
import 'package:flow/core/utils/text_extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

PreferredSizeWidget artistsAppBar() {

  final CoreController controller = Get.find();

  return AppBar(
      title: Text(
        "Artists",
        style: Theme.of(Get.context!).textTheme.titleSmall,
      ),
      centerTitle: false,
      toolbarHeight: 100,
      systemOverlayStyle: SystemUiOverlayStyle(
          statusBarColor: Theme.of(Get.context!).scaffoldBackgroundColor,
          statusBarIconBrightness:
          controller.brightness.value == Brightness.dark ? Brightness.light : Brightness.dark),
      backgroundColor: Theme.of(Get.context!).scaffoldBackgroundColor,
      elevation: 0,
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
    );
}
