import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class CoreController extends GetxController {

  /// Checking system brightness
  final isDarkMode = (MediaQuery.of(Get.context!).platformBrightness == Brightness.dark).obs;
}