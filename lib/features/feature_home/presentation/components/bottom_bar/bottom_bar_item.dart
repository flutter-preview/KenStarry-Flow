import 'package:flutter/material.dart';
import 'package:get/get.dart';

Widget bottomBarItem(
        {required String title,
        required IconData icon,
        required bool isSelected,
        required VoidCallback onTap}) =>
    InkWell(
      onTap: onTap,
      child: Column(
        children: [
          isSelected
              ? Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(24),
                    color: Theme.of(Get.context!).primaryColorDark
                  ),
                  child: Icon(
                    icon,
                    size: 22,
                    color: Theme.of(Get.context!).primaryColor,
                  ),
                )
              : Icon(
                  icon,
                  size: 22,
                  color: Theme.of(Get.context!).iconTheme.color
                ),

          const SizedBox(
            height: 8,
          ),

          //  Title
          Text(
            title,
            style: Theme.of(Get.context!).textTheme.bodySmall,
          )
        ],
      ),
    );
