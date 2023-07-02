import 'package:flow/core/presentation/controller/core_controller.dart';
import 'package:flow/core/presentation/controller/player_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

import '../../../../core/presentation/components/show_toast.dart';
import '../../../../core/utils/extensions/color_extensions.dart';

SliverAppBar homeAppBar() {
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
            Icons.search,
            color: Theme.of(Get.context!).iconTheme.color,
          )),
    ],
    title: Row(
      children: [
        UnconstrainedBox(
          child: Container(
            width: 45,
            height: 45,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(100),
              color: Theme.of(Get.context!).primaryColorDark
            ),
            child: Icon(Icons.person, color: Theme.of(Get.context!).iconTheme.color,),
          ),
        ),
        const SizedBox(
          width: 16,
        ),
        Text('Flow', style: Theme.of(Get.context!).textTheme.titleMedium,)
      ],
    ),
    toolbarHeight: 100,
    elevation: 0,
    automaticallyImplyLeading: false,
    floating: false,
    pinned: true,
    backgroundColor: Theme.of(Get.context!).scaffoldBackgroundColor,
  );
}
