import 'package:flutter/material.dart';

import '../../../../../theme/colors.dart';
import 'package:get/get.dart';

Widget createPlaylistError({required String msg}) => Row(
  children: [
    const Icon(
      Icons.error,
      color: errorColor,
      size: 16,
    ),
    const SizedBox(
      width: 8,
    ),
    Text(
      msg,
      style: TextStyle(
        fontSize:
        Theme.of(Get.context!).textTheme.bodySmall?.fontSize,
        fontWeight:
        Theme.of(Get.context!).textTheme.bodySmall?.fontWeight,
        color: errorColor,
      ),
    )
  ],
);