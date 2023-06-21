import 'package:flutter/material.dart';
import 'package:get/get.dart';

Widget addNewPlaylistBtn({required VoidCallback onTap}) =>
    GestureDetector(onTap: onTap, child: Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(50),
        color: Theme.of(Get.context!).primaryColorDark
      ),
      child: Row(
        children: [
          Icon(Icons.add, color: Theme.of(Get.context!).iconTheme.color,),
          const SizedBox(width: 8,),
          Text("Add playlist", style: Theme.of(Get.context!).textTheme.bodySmall,)
        ],
      ),
    ));
