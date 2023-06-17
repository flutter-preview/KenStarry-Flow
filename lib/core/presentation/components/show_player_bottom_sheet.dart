import 'package:flow/features/feature_home/presentation/controller/player_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../features/feature_player/presentation/player_screen.dart';

void showPlayerBottomSheet({required PlayerController playerController}) => showModalBottomSheet(
  isDismissible: true,
  enableDrag: true,
  showDragHandle: true,
  isScrollControlled: true,
  backgroundColor: Theme.of(Get.context!)
      .scaffoldBackgroundColor,
  shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.only(
          topLeft: Radius.circular(24),
          topRight: Radius.circular(24))),
  context: Get.context!,
  builder: (context) => StatefulBuilder(
    builder: (context, modalSetState) =>
        PlayerScreen(
            songs: playerController.songs,
            onNextSong: () {
              playerController.playSong(
                  path: playerController.songs[playerController
                      .currentPlayingSongIndex
                      .value! +
                      1]
                      .uri!,
                  index: playerController
                      .currentPlayingSongIndex
                      .value! +
                      1);
            },
            onPreviousSong: () =>
                playerController.playSong(
                    path: playerController.songs[playerController
                        .currentPlayingSongIndex
                        .value! -
                        1]
                        .uri!,
                    index: playerController
                        .currentPlayingSongIndex
                        .value! -
                        1)),
  ),
).whenComplete(() {
  //  continue playing song
});