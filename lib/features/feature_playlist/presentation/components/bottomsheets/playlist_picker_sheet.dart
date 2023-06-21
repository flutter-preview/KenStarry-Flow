import 'package:flow/features/feature_playlist/presentation/components/bottomsheets/playlist_picker_content.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

Future playlistPickerSheet() => showModalBottomSheet(
    isDismissible: true,
    isScrollControlled: true,
    showDragHandle: true,
    backgroundColor: Theme.of(Get.context!).scaffoldBackgroundColor,
    shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(24), topRight: Radius.circular(24))),
    context: Get.context!,
    builder: (context) => const PlaylistPickerContent());