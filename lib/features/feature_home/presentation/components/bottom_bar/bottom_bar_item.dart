import 'package:flutter/material.dart';
import 'package:get/get.dart';

Widget bottomBarItem({required String title, required IconData icon}) => Column(
      children: [
        IconButton(
            onPressed: () {},
            icon: Icon(
              icon,
              size: 22,
              color: Theme.of(Get.context!).iconTheme.color,
            )),

        //  Title
        Text(title, style: Theme.of(Get.context!).textTheme.bodySmall,)
      ],
    );
