import 'package:azlistview/azlistview.dart';
import 'package:flow/core/presentation/components/show_player_bottom_sheet.dart';
import 'package:flow/core/presentation/controller/core_controller.dart';
import 'package:flow/features/feature_home/domain/model/player_states.dart';
import 'package:flow/features/feature_home/presentation/components/bottom_bar/home_bottom_bar.dart';
import 'package:flow/features/feature_home/presentation/components/song_card.dart';
import 'package:flow/features/feature_home/presentation/controller/home_controller.dart';
import 'package:flow/features/feature_home/presentation/controller/player_controller.dart';
import 'package:flow/features/feature_main/presentation/components/my_appbar.dart';
import 'package:flow/features/feature_player/presentation/player_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:on_audio_query/on_audio_query.dart';

import '../../../theme/colors.dart';

class HomeScreen extends StatefulWidget {
  final PlayerController playerController;
  final CoreController coreController;
  final HomeController homeController;

  const HomeScreen(
      {super.key,
      required this.playerController,
      required this.coreController,
      required this.homeController});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          myAppBar(),
          SliverToBoxAdapter(
            child: //  play all songs from the start
                UnconstrainedBox(
              child: InkWell(
                borderRadius: BorderRadius.circular(50),
                onTap: () {
                  if (widget.playerController.songs.isNotEmpty) {
                    //  start playing the first song
                    widget.playerController.playSong(
                        path: widget.playerController.songs[0].uri!, index: 0);
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
              ),
            ),
          ),
          FutureBuilder<List<SongModel>>(
            future: widget.playerController.getSongs(),
            builder: (context, snapshot) {
              if (snapshot.data == null) {
                return const SliverToBoxAdapter(
                  child: Text(
                    "No data found",
                    style: TextStyle(color: Colors.white),
                  ),
                );
              }

              if (snapshot.data!.isEmpty) {
                return const SliverToBoxAdapter(
                  child: Text("Empty data",
                      style: TextStyle(color: Colors.white)),
                );
              }

              //  my songs
              var songs = snapshot.data!;
              widget.playerController.initializeSongs(songs: songs);

              return SliverList(
                  delegate: SliverChildBuilderDelegate(
                          (context, index) => SongCard(
                        song: songs[index],
                        songIndex: index,
                        coreController: widget.coreController,
                        playerController: widget.playerController,
                        onSongTapped: () {
                          if (widget.playerController.playerState
                              .value ==
                              PlayerStates.playing &&
                              widget
                                  .playerController
                                  .currentPlayingSongIndex
                                  .value ==
                                  index) {
                            //  open player screen bottom sheet
                            showPlayerBottomSheet(
                                playerController:
                                widget.playerController,
                                homeController:
                                widget.homeController);
                          } else {
                            widget.playerController.playSong(
                                path: songs[index].uri!,
                                index: index);

                            //  open player screen bottom sheet
                            showPlayerBottomSheet(
                                playerController:
                                widget.playerController,
                                homeController:
                                widget.homeController);
                          }
                        },
                      ),
                      childCount: songs.length));
            },
          )
        ],
      ),
    );
  }
}
