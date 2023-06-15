import 'package:flow/core/presentation/controller/core_controller.dart';
import 'package:flow/features/feature_home/presentation/components/song_card.dart';
import 'package:flow/features/feature_home/presentation/controller/player_controller.dart';
import 'package:flow/features/feature_player/presentation/player_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:on_audio_query/on_audio_query.dart';

import '../../../../theme/colors.dart';

class HomeContent extends StatelessWidget {
  final PlayerController playerController;
  final CoreController coreController;

  const HomeContent(
      {super.key,
      required this.playerController,
      required this.coreController});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Obx(
      () => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: playerController.isPermissionGranted.value
            ? Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 16,
                  ),
                  //  title
                  Row(
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
                                path: playerController.songs[0].uri!, index: 0);
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

                        return SizedBox(
                          width: double.infinity,
                          height: double.infinity,
                          child: ListView.separated(
                            physics: const BouncingScrollPhysics(),
                            itemCount: songs.length,
                            itemBuilder: (context, index) {
                              var song = songs[index];
                              //  song item
                              return SongCard(
                                song: song,
                                songIndex: index,
                                coreController: coreController,
                                playerController: playerController,
                                onSongTapped: () {
                                  //  open player screen bottom sheet
                                  showModalBottomSheet(
                                    isDismissible: true,
                                    enableDrag: true,
                                    showDragHandle: true,
                                    isScrollControlled: true,
                                    backgroundColor: Theme.of(context)
                                        .scaffoldBackgroundColor,
                                    shape: const RoundedRectangleBorder(
                                        borderRadius: BorderRadius.only(
                                            topLeft: Radius.circular(16),
                                            topRight: Radius.circular(16))),
                                    context: context,
                                    builder: (context) => PlayerScreen(song: song,),
                                  ).whenComplete(() {
                                    //  continue playing song
                                  });

                                  playerController.playSong(
                                      path: song.uri!, index: index);
                                },
                              );
                            },
                            separatorBuilder: (context, index) =>
                                const SizedBox(
                              height: 16,
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              )
            : const Center(child: Text("Permission not granted")),
      ),
    ));
  }
}
