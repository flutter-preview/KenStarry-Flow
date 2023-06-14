import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CoreController extends GetxController {

  /// Checking system brightness
  final isDarkMode = (MediaQuery.of(Get.context!).platformBrightness == Brightness.dark).obs;

  /// Checking system Theme Mode
  final themeMode = ThemeMode.system.obs;
}