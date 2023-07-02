import 'package:flow/core/presentation/controller/core_controller.dart';
import 'package:flow/core/presentation/controller/player_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

import '../../../../core/presentation/components/show_toast.dart';
import '../../../../core/utils/extensions/color_extensions.dart';

SliverAppBar songsAppBar({required FToast toast}) {

  final CoreController controller = Get.find();
  final PlayerController playerController = Get.find<PlayerController>();

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
    title: Text("Songs", style: Theme.of(Get.context!).textTheme.titleMedium,),
    toolbarHeight: 70,
    floating: false,
    pinned: true,
    centerTitle: false,
    backgroundColor: Theme.of(Get.context!).scaffoldBackgroundColor,
  );
}
