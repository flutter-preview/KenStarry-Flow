import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

Widget customToast({required IconData iconData, required String msg}) =>
    IgnorePointer(
      ignoring: true,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30),
            color: Theme.of(Get.context!).primaryColorDark),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              iconData,
              color: Theme.of(Get.context!).primaryColor,
            ),
            const SizedBox(
              width: 8,
            ),
            Text(
              msg,
              style: Theme.of(Get.context!).textTheme.bodyMedium,
            )
          ],
        ),
      ),
    );

void showToast(
        {required FToast toast,
        required IconData iconData,
        required String msg}) =>
    toast.showToast(
        child: customToast(iconData: iconData, msg: msg),
        gravity: ToastGravity.BOTTOM);

void cancelToast() => Fluttertoast.cancel();
