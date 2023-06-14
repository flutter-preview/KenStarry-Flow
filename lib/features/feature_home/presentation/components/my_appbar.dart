import 'package:flow/core/presentation/controller/core_controller.dart';
import 'package:flow/core/utils/extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

PreferredSizeWidget myAppBar({required CoreController controller}) => AppBar(
      title: const Text(
        "My Songs",
        style: TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.bold,
        ),
      ),
      centerTitle: true,
      systemOverlayStyle: SystemUiOverlayStyle(
          statusBarColor: Theme.of(Get.context!).scaffoldBackgroundColor,
          statusBarIconBrightness: controller.isDarkMode.value ? Brightness.light : Brightness.dark),
      backgroundColor: Theme.of(Get.context!).scaffoldBackgroundColor,
      elevation: 0,
    );
