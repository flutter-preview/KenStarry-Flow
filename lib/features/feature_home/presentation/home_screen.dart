import 'package:azlistview/azlistview.dart';
import 'package:flow/core/presentation/components/show_player_bottom_sheet.dart';
import 'package:flow/core/presentation/controller/core_controller.dart';
import 'package:flow/features/feature_home/domain/model/player_states.dart';
import 'package:flow/features/feature_home/presentation/components/bottom_bar/home_bottom_bar.dart';
import 'package:flow/features/feature_home/presentation/components/song_card.dart';
import 'package:flow/features/feature_home/presentation/controller/home_controller.dart';
import 'package:flow/features/feature_home/presentation/controller/player_controller.dart';
import 'package:flow/features/feature_player/presentation/player_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:on_audio_query/on_audio_query.dart';

import '../../../theme/colors.dart';

class HomeScreen extends StatelessWidget {
  final PlayerController playerController;
  final CoreController coreController;
  final HomeController homeController;

  const HomeScreen(
      {super.key,
      required this.playerController,
      required this.coreController,
      required this.homeController});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: //  main content
          Obx(
        () => playerController.isPermissionGranted.value
            ? Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 16,
                  ),
                  //  title
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "All Songs",
                          style: Theme.of(context).textTheme.titleSmall,
                        ),
                        //  play all songs from the start
                        InkWell(
                          borderRadius: BorderRadius.circular(50),
                          onTap: () {
                            if (playerController.songs.isNotEmpty) {
                              //  start playing the first song
                              playerController.playSong(
                                  path: playerController.songs[0].uri!,
                                  index: 0);
                            }
                          },
                          child: Ink(
                              width: 50,
                              height: 50,
                              decoration: BoxDecoration(
                                  color: Theme.of(context).primaryColorDark,
                                  borderRadius: BorderRadius.circular(50)),
                              child: const Icon(
                                Icons.play_arrow,
                                color: accent,
                              )),
                        )
                      ],
                    ),
                  ),

                  const SizedBox(
                    height: 16,
                  ),
                  //  songs list
                  Expanded(
                    child: FutureBuilder<List<SongModel>>(
                      future: playerController.getSongs(),
                      builder: (context, snapshot) {
                        if (snapshot.data == null) {
                          return const Text(
                            "No data found",
                            style: TextStyle(color: Colors.white),
                          );
                        }

                        if (snapshot.data!.isEmpty) {
                          return const Text("Empty data",
                              style: TextStyle(color: Colors.white));
                        }

                        //  my songs
                        var songs = snapshot.data!;
                        playerController.initializeSongs(songs: songs);

                        return SizedBox(
                          width: double.infinity,
                          height: double.infinity,
                          child: AzListView(
                            data: playerController.azSongs,
                            physics: const BouncingScrollPhysics(),
                            indexBarOptions: IndexBarOptions(
                                needRebuild: true,
                                selectTextStyle:
                                    Theme.of(context).textTheme.bodyMedium,
                                selectItemDecoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Theme.of(context).primaryColorDark),
                                indexHintAlignment: Alignment.centerRight,
                                indexHintOffset: Offset(-16, 0)),
                            indexHintBuilder: (context, hint) => Container(
                              width: 60,
                              height: 60,
                              decoration: BoxDecoration(
                                  color: Theme.of(context).primaryColor,
                                  shape: BoxShape.circle),
                              child: Center(
                                  child: Text(
                                hint,
                                style: Theme.of(context).textTheme.titleSmall,
                              )),
                            ),
                            indexBarMargin: const EdgeInsets.all(0),
                            itemCount: songs.length,
                            itemBuilder: (context, index) {
                              var song = songs[index];
                              //  song item
                              return Padding(
                                padding: const EdgeInsets.only(
                                    left: 16.0, top: 8, bottom: 8, right: 28),
                                child: SongCard(
                                  song: song,
                                  songIndex: index,
                                  coreController: coreController,
                                  playerController: playerController,
                                  onSongTapped: () {
                                    if (playerController.playerState.value ==
                                            PlayerStates.playing &&
                                        playerController.currentPlayingSongIndex
                                                .value ==
                                            index) {
                                      //  open player screen bottom sheet
                                      showPlayerBottomSheet(
                                          playerController: playerController,
                                      homeController: homeController);
                                    } else {
                                      playerController.playSong(
                                          path: song.uri!, index: index);

                                      //  open player screen bottom sheet
                                      showPlayerBottomSheet(
                                          playerController: playerController,
                                      homeController: homeController);
                                    }
                                  },
                                ),
                              );
                            },
                          ),
                        );
                      },
                    ),
                  ),
                ],
              )
            : const Center(child: Text("Permission not granted")),
      ),
    );
  }
}
