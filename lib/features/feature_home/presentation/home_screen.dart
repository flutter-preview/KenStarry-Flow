import 'package:azlistview/azlistview.dart';
import 'package:draggable_scrollbar/draggable_scrollbar.dart';
import 'package:flow/core/presentation/components/show_player_bottom_sheet.dart';
import 'package:flow/core/presentation/controller/core_controller.dart';
import 'package:flow/core/domain/models/player_states.dart';
import 'package:flow/features/feature_home/presentation/components/song_card.dart';
import 'package:flow/features/feature_home/presentation/controller/home_controller.dart';
import 'package:flow/core/presentation/controller/player_controller.dart';
import 'package:flow/features/feature_main/presentation/components/my_appbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:get/get.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

import '../../../core/presentation/components/show_toast.dart';
import '../../../core/utils/extensions/color_extensions.dart';

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
  late final ItemScrollController _scrollController;
  late final FToast _toast;

  @override
  void initState() {
    super.initState();

    _playerController = Get.find();
    _coreController = Get.find();
    _homeController = Get.find();
    _scrollController = ItemScrollController();
    _toast = FToast();
    _toast.init(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(left: 8.0, top: 8),
        child: CustomScrollView(
          physics: const BouncingScrollPhysics(),
          slivers: [
            myAppBar(),
            SliverToBoxAdapter(
              child: //  play all songs from the start
                  Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    //  library button
                    Expanded(
                        child: Align(
                      alignment: AlignmentDirectional.centerStart,
                      child: UnconstrainedBox(
                        child: Container(
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                              color: Theme.of(context).primaryColorDark,
                              borderRadius: BorderRadius.circular(30)),
                          child: Row(
                            children: [
                              Icon(
                                Icons.library_books,
                                color: Theme.of(context).primaryColor,
                                size: 16,
                              ),
                              const SizedBox(
                                width: 8,
                              ),
                              Text(
                                "Library",
                                style: Theme.of(context).textTheme.bodyMedium,
                              ),
                            ],
                          ),
                        ),
                      ),
                    )),

                    //  shuffle songs
                    InkWell(
                      borderRadius: BorderRadius.circular(100),
                      onTap: () {
                        //  shuffle songs
                        _playerController.shuffle();

                        if (_playerController.isShuffleModeEnabled.value) {
                          showToast(
                              toast: _toast,
                              iconData: Icons.shuffle_rounded,
                              msg: "Shuffle on");
                        } else {
                          showToast(
                              toast: _toast,
                              iconData: Icons.shuffle_rounded,
                              msg: "Shuffle off");
                        }
                      },
                      child: Obx(
                        () => Ink(
                          width: 35,
                          height: 35,
                          decoration: BoxDecoration(
                              color:
                                  _playerController.isShuffleModeEnabled.value
                                      ? Theme.of(context).primaryColor
                                      : Theme.of(context).primaryColorDark,
                              borderRadius: BorderRadius.circular(50)),
                          child: _playerController.isShuffleModeEnabled.value
                              ? Icon(
                                  Icons.shuffle,
                                  size: 16,
                                  color: getTextColorForBackground(
                                      Theme.of(context).primaryColor),
                                )
                              : Icon(
                                  Icons.shuffle,
                                  size: 16,
                                  color: Theme.of(context).iconTheme.color,
                                ),
                        ),
                      ),
                    ),

                    const SizedBox(width: 8),

                    //  play button
                    InkWell(
                      borderRadius: BorderRadius.circular(100),
                      onTap: () {
                        if (_playerController.mediaItemsInitial.isNotEmpty) {
                          //  play or pause music
                          if (_playerController.playerState.value ==
                              PlayerStates.playing) {
                            _playerController.pauseSong();
                          } else {
                            //  play first song
                            _playerController.playSongAtIndex(index: 0);
                          }
                        }
                      },
                      child: Obx(
                          () => Ink(
                            width: 50,
                            height: 50,
                            decoration: BoxDecoration(
                                color: Theme.of(context).primaryColorDark,
                                borderRadius: BorderRadius.circular(50)),
                            child: Icon(
                              _playerController.playerState.value ==
                                  PlayerStates.playing
                                  ? Icons.pause_rounded
                                  : Icons.play_arrow_rounded,
                              color: Theme.of(context).primaryColor,
                              size: 32,
                            )),
                      ),
                    ),
                  ],
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

                return SliverFillRemaining(
                  child: AzListView(
                      data: _playerController.azSongs,
                      itemScrollController: _scrollController,
                      physics: const BouncingScrollPhysics(),
                      indexBarOptions: IndexBarOptions(
                          needRebuild: true,
                          textStyle: Theme.of(context).textTheme.bodySmall!,
                          selectTextStyle: TextStyle(
                              fontSize: Theme.of(context)
                                  .textTheme
                                  .bodySmall
                                  ?.fontSize,
                              fontWeight: Theme.of(context)
                                  .textTheme
                                  .bodySmall
                                  ?.fontWeight,
                              color: Colors.black),
                          selectItemDecoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(16),
                              color: Theme.of(context).primaryColor),
                          indexHintAlignment: Alignment.centerRight,
                          indexHintOffset: Offset(-15, 0)),
                      indexBarMargin: EdgeInsets.symmetric(vertical: 16),
                      indexHintBuilder: (context, hint) => Container(
                            width: 60,
                            height: 60,
                            decoration: BoxDecoration(
                                color: Theme.of(context).primaryColor,
                                borderRadius: BorderRadius.circular(16)),
                            child: Center(
                              child: Text(hint,
                                  style: TextStyle(
                                      fontWeight: Theme.of(context)
                                          .textTheme
                                          .titleLarge
                                          ?.fontWeight,
                                      fontSize: Theme.of(context)
                                          .textTheme
                                          .titleMedium
                                          ?.fontSize,
                                      color: Colors.black)),
                            ),
                          ),
                      itemCount: _playerController.mediaItemsInitial.length,
                      itemBuilder: (context, index) => Padding(
                            padding: const EdgeInsets.only(
                                top: 8.0, bottom: 8, left: 8, right: 24),
                            child: SongCard(
                              song: _playerController.mediaItemsInitial[index],
                              songIndex: index,
                              coreController: _coreController,
                              playerController: _playerController,
                              onSongTapped: () {
                                //  DISABLE SHUFFLE MODE
                                if (_playerController
                                    .isShuffleModeEnabled.value) {
                                  _playerController.disableShuffle();
                                  //  Reenable shuffle
                                  _playerController.shuffle();
                                }

                                if (_playerController.playerState.value ==
                                        PlayerStates.playing &&
                                    _playerController
                                            .currentPlayingSongIndex.value ==
                                        index) {
                                  //  open player screen bottom sheet
                                  showPlayerBottomSheet(
                                      playerController: _playerController,
                                      homeController: _homeController);
                                } else {
                                  _playerController.playSongAtIndex(
                                      index: index);

                                  //  open player screen bottom sheet
                                  showPlayerBottomSheet(
                                      playerController: _playerController,
                                      homeController: _homeController);
                                }
                              },
                            ),
                          )),
                );
              },
            )
          ],
        ),
      ),
    );
  }
}
