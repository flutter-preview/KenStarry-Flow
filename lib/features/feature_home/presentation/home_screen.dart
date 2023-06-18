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
import 'package:scroll_to_index/scroll_to_index.dart';
import 'package:get/get.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';
import 'package:draggable_scrollbar/draggable_scrollbar.dart';
import 'package:vs_scrollbar/vs_scrollbar.dart';

import '../../../theme/colors.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({
    super.key,
  });

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late final PlayerController _playerController;
  late final CoreController _coreController;
  late final HomeController _homeController;

  @override
  void initState() {
    super.initState();

    _playerController = Get.find();
    _coreController = Get.find();
    _homeController = Get.find();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: VsScrollbar(
          controller: _homeController.controller,
          showTrackOnHover: true,
          isAlwaysShown: true,
          style: VsScrollbarStyle(
            color: Theme.of(context).primaryColor
          ),
          child: CustomScrollView(
            controller: _homeController.controller,
            physics: const BouncingScrollPhysics(),
            slivers: [
              myAppBar(),
              SliverToBoxAdapter(
                child: //  play all songs from the start
                    UnconstrainedBox(
                  child: InkWell(
                    borderRadius: BorderRadius.circular(50),
                    onTap: () {
                      if (_playerController.songs.isNotEmpty) {
                        //  start playing the first song
                        _playerController.playSong(
                            path: _playerController.songs[0].uri!, index: 0);
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
                future: _playerController.getSongs(),
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
                  _playerController.initializeSongs(songs: songs);

                  return SliverList(
                      delegate: SliverChildBuilderDelegate(
                          (context, index) => AutoScrollTag(
                                key: ValueKey(index),
                                controller: _homeController.controller,
                                index: index,
                                child: Padding(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 8.0),
                                  child: SongCard(
                                    song: songs[index],
                                    songIndex: index,
                                    coreController: _coreController,
                                    playerController: _playerController,
                                    onSongTapped: () {
                                      if (_playerController.playerState.value ==
                                              PlayerStates.playing &&
                                          _playerController
                                                  .currentPlayingSongIndex
                                                  .value ==
                                              index) {
                                        //  open player screen bottom sheet
                                        showPlayerBottomSheet(
                                            playerController: _playerController,
                                            homeController: _homeController);
                                      } else {
                                        _playerController.playSong(
                                            path: songs[index].uri!,
                                            index: index);

                                        //  open player screen bottom sheet
                                        showPlayerBottomSheet(
                                            playerController: _playerController,
                                            homeController: _homeController);
                                      }
                                    },
                                  ),
                                ),
                              ),
                          childCount: songs.length));
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
