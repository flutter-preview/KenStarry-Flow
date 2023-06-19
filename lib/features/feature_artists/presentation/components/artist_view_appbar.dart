import 'package:flow/core/presentation/controller/core_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

PreferredSizeWidget artistAppBar({required CoreController controller}) => AppBar(
  systemOverlayStyle: SystemUiOverlayStyle(
      statusBarColor: Theme.of(Get.context!).primaryColorDark,
      statusBarIconBrightness:
      controller.brightness.value == Brightness.dark
          ? Brightness.light
          : Brightness.dark),
  backgroundColor: Theme.of(Get.context!).primaryColorDark,
  elevation: 0,
  leading: IconButton(
    onPressed: () {
      Get.back(canPop: true);
    },
    icon: Icon(
      Icons.arrow_back,
      color: Theme.of(Get.context!).iconTheme.color,
    ),
  ),
);