import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

class CoreController extends GetxController {
  /// Checking system brightness
  final brightness = MediaQuery.of(Get.context!).platformBrightness.obs;
}
