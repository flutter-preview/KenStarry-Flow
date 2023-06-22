import 'package:flow/features/feature_playlist/presentation/components/bottomsheets/playlist_picker_content.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

Future playlistPickerSheet() => showModalBottomSheet(
    isDismissible: true,
    isScrollControlled: true,
    showDragHandle: false,
    backgroundColor: Colors.transparent,
    context: Get.context!,
    builder: (context) => const PlaylistPickerContent());
