import 'package:flow/core/presentation/controller/core_controller.dart';
import 'package:flow/core/presentation/controller/player_controller.dart';
import 'package:flow/features/feature_artists/presentation/controller/artists_controller.dart';
import 'package:flow/features/feature_songs/presentation/controller/songs_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:get/get.dart';

import '../../../../core/presentation/components/show_player_bottom_sheet.dart';
import '../../../../core/domain/models/player_states.dart';
import '../../../feature_songs/presentation/components/song_card.dart';

class ArtistViewList extends StatelessWidget {

  final ArtistsController _artistsController = Get.find<ArtistsController>();
  final PlayerController _playerController = Get.find<PlayerController>();
  final SongsController _homeController = Get.find<SongsController>();
  final CoreController _coreController = Get.find<CoreController>();

  ArtistViewList({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(
          () => Expanded(
        child: ListView.builder(
            physics: const BouncingScrollPhysics(),
            itemCount: _artistsController.artistSongs.length,
            itemBuilder: (context, index) {
              //  get index of this song from the main songs list
              final currentIndex = _playerController.mediaItemsInitial
                  .indexOf(
                  _artistsController.artistSongs[index]);

              return SongCard(
                song: _artistsController.artistSongs[index],
                songIndex: currentIndex,
                coreController: _coreController,
                playerController: _playerController,
                onSongTapped: () {
                  if (_playerController.playerState.value ==
                      PlayerStates.playing &&
                      _playerController
                          .currentPlayingSongIndex.value ==
                          currentIndex) {
                    //  open player screen bottom sheet
                    showPlayerBottomSheet(
                        playerController: _playerController,
                        homeController: _homeController);
                  } else {
                    _playerController.playSongAtIndex(index: currentIndex);

                    //  open player screen bottom sheet
                    showPlayerBottomSheet(
                        playerController: _playerController,
                        homeController: _homeController);
                  }
                },
              );
            }),
      ),
    );
  }
}
