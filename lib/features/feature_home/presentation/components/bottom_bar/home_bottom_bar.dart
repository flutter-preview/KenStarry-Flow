import 'package:flow/core/presentation/components/show_player_bottom_sheet.dart';
import 'package:flow/features/feature_home/domain/model/player_states.dart';
import 'package:flow/features/feature_home/presentation/components/bottom_bar/bottom_bar_item.dart';
import 'package:flow/features/feature_home/presentation/controller/home_controller.dart';
import 'package:flow/core/presentation/controller/player_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:just_audio/just_audio.dart';
import 'package:marquee/marquee.dart';

import '../../../../../di/locator.dart';

class HomeBottomBar extends StatefulWidget {
  const HomeBottomBar({super.key});

  @override
  State<HomeBottomBar> createState() => _HomeBottomBarState();
}

class _HomeBottomBarState extends State<HomeBottomBar>
    with TickerProviderStateMixin {
  late final PlayerController _playerController;
  late final HomeController _homeController;

  @override
  void initState() {
    super.initState();
    _playerController = Get.find();
    _homeController = Get.find();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          color: Theme.of(context).primaryColorDark),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Obx(
              () => Wrap(
            alignment: WrapAlignment.start,
            runSpacing: 8,
            children: [
              //  Bottom Nav Currently playing music
              _playerController.songs.isNotEmpty
                  ? GestureDetector(
                onTap: () {
                  showPlayerBottomSheet(
                      playerController: _playerController,
                      homeController: _homeController);
                },
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    //  Track name
                    Row(
                      children: [
                        //  track name
                        Expanded(
                          child: SizedBox(
                            height: 16,
                            child: Marquee(
                              text: _playerController
                                  .songs[_playerController
                                  .currentPlayingSongIndex.value!]
                                  .displayNameWOExt,
                              style: Theme.of(context)
                                  .textTheme
                                  .bodySmall,
                              pauseAfterRound:
                              const Duration(seconds: 1),
                              crossAxisAlignment:
                              CrossAxisAlignment.center,
                            ),
                          ),
                        ),

                        const SizedBox(
                          width: 16,
                        ),

                        //  collapse icon
                        GestureDetector(
                          onTap: () {
                            //  collapse bottom bar
                            _homeController
                                .setBottomBarCollapsedState(
                                isCollapsed: !_homeController
                                    .isBottomBarCollapsed.value);
                          },
                          child: Icon(
                            _homeController
                                .isBottomBarCollapsed.value ==
                                true
                                ? Icons.keyboard_arrow_up_rounded
                                : Icons.keyboard_arrow_down_rounded,
                            size: 24,
                            color: Theme.of(context).primaryColor,
                          ),
                        )
                      ],
                    ),

                    const SizedBox(
                      height: 8,
                    ),

                    //  elapsed time (Hide based on collapsed mode
                    Visibility(
                      visible:
                      !_homeController.isBottomBarCollapsed.value,
                      maintainAnimation: true,
                      maintainState: true,
                      maintainSize: false,
                      child: Row(
                        children: [
                          //  slider and elapsed time
                          Expanded(
                            flex: 2,
                            child: Row(
                              children: [
                                Text(
                                  _playerController.position.value
                                      .toString(),
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodySmall,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                //  slider
                                Expanded(
                                  child: SliderTheme(
                                    data: SliderTheme.of(context)
                                        .copyWith(
                                        trackHeight: 5,
                                        thumbColor:
                                        Colors.transparent,
                                        thumbShape:
                                        SliderComponentShape
                                            .noThumb),
                                    child: Slider(
                                      value: _playerController
                                          .sliderValue.value,
                                      min: const Duration(seconds: 0)
                                          .inSeconds
                                          .toDouble(),
                                      max: _playerController
                                          .maxSlider.value,
                                      onChanged: (newValue) {
                                        _playerController.seekSong(
                                            seconds:
                                            newValue.toInt());
                                        newValue = newValue;

                                        if (_playerController
                                            .sliderValue.value ==
                                            _playerController
                                                .maxSlider.value) {
                                          //  go to next song
                                          _playerController.playSong(
                                              path: _playerController
                                                  .songs[_playerController
                                                  .currentPlayingSongIndex
                                                  .value! +
                                                  1]
                                                  .uri!,
                                              index: _playerController
                                                  .currentPlayingSongIndex
                                                  .value! +
                                                  1);
                                        }
                                      },
                                      thumbColor: Theme.of(context)
                                          .primaryColor,
                                      activeColor: Theme.of(context)
                                          .primaryColor,
                                      inactiveColor: Theme.of(context)
                                          .primaryColorDark,
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),

                          //  next, play and previous icons
                          Expanded(
                            child: Row(
                              mainAxisAlignment:
                              MainAxisAlignment.spaceBetween,
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    _playerController.playSong(
                                        path: _playerController
                                            .songs[_playerController
                                            .currentPlayingSongIndex
                                            .value! -
                                            1]
                                            .uri!,
                                        index: _playerController
                                            .currentPlayingSongIndex
                                            .value! -
                                            1);
                                  },
                                  child: const Icon(
                                      Icons.skip_previous_rounded),
                                ),

                                //  play icon
                                GestureDetector(
                                  onTap: () {
                                    //  play or pause music
                                    if (_playerController
                                        .playerState.value ==
                                        PlayerStates.playing) {
                                      _playerController.pauseSong();
                                    } else {
                                      var player =
                                      locator.get<AudioPlayer>();
                                      player.play();
                                    }
                                  },
                                  child: Icon(
                                    _playerController
                                        .playerState.value ==
                                        PlayerStates.playing
                                        ? Icons.pause
                                        : Icons.play_arrow_rounded,
                                    size: 24,
                                    color: Theme.of(context)
                                        .primaryColor,
                                  ),
                                ),

                                GestureDetector(
                                  onTap: () {
                                    _playerController.playSong(
                                        path: _playerController
                                            .songs[_playerController
                                            .currentPlayingSongIndex
                                            .value! +
                                            1]
                                            .uri!,
                                        index: _playerController
                                            .currentPlayingSongIndex
                                            .value! +
                                            1);
                                  },
                                  child: const Icon(
                                      Icons.skip_next_rounded),
                                )
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              )
                  : const SizedBox.shrink(),

              //  Bottom nav icons
              Obx(
                    () => Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    //  home icon
                    bottomBarItem(
                        title: "Home",
                        icon: Icons.home,
                        isSelected:
                        _homeController.currentTabIndex.value == 0,
                        onTap: () {
                          _homeController.setBottomNavTabIndex(index: 0);
                        }),
                    bottomBarItem(
                        title: "Playlist",
                        icon: Icons.playlist_play_rounded,
                        isSelected:
                        _homeController.currentTabIndex.value == 1,
                        onTap: () {
                          _homeController.setBottomNavTabIndex(index: 1);
                        }),
                    bottomBarItem(
                        title: "Artists",
                        icon: Icons.music_note_outlined,
                        isSelected:
                        _homeController.currentTabIndex.value == 2,
                        onTap: () {
                          _homeController.setBottomNavTabIndex(index: 2);
                        }),
                    bottomBarItem(
                        title: "Settings",
                        icon: Icons.settings,
                        isSelected:
                        _homeController.currentTabIndex.value == 3,
                        onTap: () {
                          _homeController.setBottomNavTabIndex(index: 3);
                        }),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
