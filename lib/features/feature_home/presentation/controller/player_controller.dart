import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:permission_handler/permission_handler.dart';

class PlayerController extends GetxController {

  final audioQuery = OnAudioQuery();

  checkPermission() async {
    //  request access to storage
    var storagePermission = await Permission.storage.request();

    if (storagePermission.isGranted) {
      return audioQuery.querySongs(
        ignoreCase: true,
        orderType: OrderType.ASC_OR_SMALLER,
        sortType: null,
        uriType: UriType.EXTERNAL
      );
    } else {
      checkPermission();
    }
  }
}