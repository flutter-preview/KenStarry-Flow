import 'package:flow/core/presentation/controller/core_controller.dart';
import 'package:flow/core/utils/extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

PreferredSizeWidget myAppBar({required CoreController controller}) => AppBar(
      title: Text(
        "Flow",
        style: Theme.of(Get.context!).textTheme.titleSmall,
      ),
      centerTitle: true,
      systemOverlayStyle: SystemUiOverlayStyle(
          statusBarColor: Theme.of(Get.context!).scaffoldBackgroundColor,
          statusBarIconBrightness:
              controller.isDarkMode.value ? Brightness.light : Brightness.dark),
      backgroundColor: Theme.of(Get.context!).scaffoldBackgroundColor,
      elevation: 0,
      actions: [
        IconButton(
            onPressed: () {},
            icon: Icon(
              Icons.search,
              color: Theme.of(Get.context!).iconTheme.color,
            ))
      ],
    );
