import 'package:flutter/material.dart';
import 'package:get/get.dart';

void showSnackbar(
        {required String title,
        required String message,
        required IconData iconData}) =>
    Get.showSnackbar(GetSnackBar(
      titleText: Text(
        title,
        style: TextStyle(
            fontWeight: Theme.of(Get.context!).textTheme.bodyMedium?.fontWeight,
            fontSize: Theme.of(Get.context!).textTheme.bodyMedium?.fontSize,
            color: Colors.white
        ),
      ),
      messageText: Text(
        message,
        style: TextStyle(
          fontWeight: Theme.of(Get.context!).textTheme.bodySmall?.fontWeight,
          fontSize: Theme.of(Get.context!).textTheme.bodySmall?.fontSize,
          color: Colors.white
        ),
      ),
      icon: Icon(
        iconData,
        size: 16,
        color: Theme.of(Get.context!).primaryColor,
      ),
      margin: const EdgeInsets.all(16),
      padding: const EdgeInsets.all(16),
      duration: const Duration(seconds: 3),
      isDismissible: true,

    ));
