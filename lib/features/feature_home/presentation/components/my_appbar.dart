import 'package:flow/core/utils/extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

PreferredSizeWidget myAppBar() => AppBar(
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
          statusBarIconBrightness: Brightness.light),
      backgroundColor: Theme.of(Get.context!).scaffoldBackgroundColor,
      elevation: 0,
    );
