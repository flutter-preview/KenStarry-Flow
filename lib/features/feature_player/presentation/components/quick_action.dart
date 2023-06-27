import 'package:flutter/material.dart';
import 'package:get/get.dart';

Widget quickAction({required Widget child, required VoidCallback onTap}) =>
    InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(100),
      child: Ink(
        width: 40,
        height: 40,
        decoration: BoxDecoration(
            color: Theme.of(Get.context!).scaffoldBackgroundColor,
            borderRadius: BorderRadius.circular(100)),
        child: Center(child: child),
      ),
    );
