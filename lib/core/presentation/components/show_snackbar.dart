import 'package:flutter/material.dart';
import 'package:get/get.dart';

void showSnackbar(
        {required String title,
        required String message,
        required IconData iconData}) =>
    Get.showSnackbar(GetSnackBar(
      titleText: Text(
        title,
        style: Theme.of(Get.context!).textTheme.bodyMedium,
      ),
      messageText: Text(
        message,
        style: Theme.of(Get.context!).textTheme.bodyMedium,
      ),
      backgroundColor: Theme.of(Get.context!).scaffoldBackgroundColor,
      icon: Icon(
        iconData,
        size: 16,
        color: Theme.of(Get.context!).primaryColor,
      ),
      margin: const EdgeInsets.all(16),
      padding: const EdgeInsets.all(16),
      duration: Duration(seconds: 3),
      isDismissible: true,

    ));
