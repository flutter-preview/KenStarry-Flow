import 'package:flow/core/presentation/controller/core_controller.dart';
import 'package:flow/features/feature_home/presentation/components/song_card_playing.dart';
import 'package:flow/features/feature_home/presentation/components/song_card_standard.dart';
import 'package:flow/features/feature_home/presentation/controller/player_controller.dart';
import 'package:flow/theme/colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:on_audio_query/on_audio_query.dart';

class SongCard extends StatelessWidget {
  final SongModel song;
  final int songIndex;
  final CoreController coreController;
  final PlayerController playerController;
  final VoidCallback onSongTapped;

  const SongCard(
      {super.key,
      required this.song,
      required this.songIndex,
      required this.coreController,
      required this.playerController,
      required this.onSongTapped});

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => playerController.currentPlayingSongIndex.value == songIndex &&
              playerController.isPlaying.value == true
          ? SongCardPlaying(
              song: song,
              songIndex: songIndex,
              coreController: coreController,
              playerController: playerController,
              onSongTapped: onSongTapped)
          : SongCardStandard(
              song: song,
              songIndex: songIndex,
              coreController: coreController,
              playerController: playerController,
              onSongTapped: onSongTapped),
    );
  }
}
