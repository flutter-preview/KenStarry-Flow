import 'package:flow/features/feature_home/presentation/controller/home_controller.dart';
import 'package:flow/core/presentation/controller/player_controller.dart';
import 'package:flow/features/feature_playlist/presentation/components/bottomsheets/playlist_picker_sheet.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../features/feature_player/presentation/player_screen.dart';

void showPlayerBottomSheet(
    {required PlayerController playerController,
    required HomeController homeController}) {
  homeController.scrollToIndex(
      index: playerController.currentPlayingSongIndex.value!);

  showModalBottomSheet(
    isDismissible: true,
    enableDrag: true,
    showDragHandle: true,
    isScrollControlled: true,
    backgroundColor: Theme.of(Get.context!).scaffoldBackgroundColor,
    shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(24), topRight: Radius.circular(24))),
    context: Get.context!,
    builder: (context) => StatefulBuilder(
      builder: (context, modalSetState) {
        return PlayerScreen(
          songs: playerController.songs,
          onNextSong: () => playerController.playNextSong(
              index: playerController.currentPlayingSongIndex.value! + 1),
          onPreviousSong: () => playerController.playNextSong(
              index: playerController.currentPlayingSongIndex.value! - 1),
          onPlaylistClicked: () => playlistPickerSheet(),
        );
      },
    ),
  ).whenComplete(() {
    //  open home screen
    homeController.setBottomNavTabIndex(index: 0);
  });
}
