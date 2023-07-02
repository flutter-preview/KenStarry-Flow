import 'package:audio_video_progress_bar/audio_video_progress_bar.dart';
import 'package:flow/core/domain/models/repeat_state.dart';
import 'package:flow/core/domain/models/speed_state.dart';
import 'package:flow/core/presentation/components/show_toast.dart';
import 'package:flow/core/utils/extensions/color_extensions.dart';
import 'package:flow/core/utils/extensions/string_extensions.dart';
import 'package:flow/di/locator.dart';
import 'package:flow/core/presentation/controller/player_controller.dart';
import 'package:flow/features/feature_player/presentation/components/artwork_player_section.dart';
import 'package:flow/features/feature_player/presentation/components/quick_action.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:just_audio/just_audio.dart';
import 'package:marquee/marquee.dart';
import 'package:on_audio_query/on_audio_query.dart';

import '../../../core/domain/models/player_states.dart';

class PlayerScreen extends StatefulWidget {
  final List<SongModel> songs;
  final VoidCallback onNextSong;
  final VoidCallback onPreviousSong;
  final VoidCallback onPlaylistClicked;

  PlayerScreen(
      {super.key,
      required this.songs,
      required this.onNextSong,
      required this.onPreviousSong,
      required this.onPlaylistClicked});

  @override
  State<PlayerScreen> createState() => _PlayerScreenState();
}

class _PlayerScreenState extends State<PlayerScreen>
    with TickerProviderStateMixin {
  final PlayerController playerController = Get.find();
  late final FToast _toast;

  @override
  void initState() {
    super.initState();

    _toast = FToast();
    _toast.init(context);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24.0),
      child: Wrap(
        alignment: WrapAlignment.center,
        runSpacing: 20,
        crossAxisAlignment: WrapCrossAlignment.center,
        children: [
          ArtworkPlayerSection()

          //  artist and song name
          Obx(
            () => Column(
              children: [
                SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: Marquee(
                    text: playerController.mediaItemsDynamic.isEmpty
                        ? "Unknown"
                        : playerController.mediaItemsDynamic
                            .elementAt(playerController
                                .currentPlayingSongIndexDynamic.value!)
                            .title,
                    style: Theme.of(context).textTheme.bodyLarge,
                    pauseAfterRound: const Duration(seconds: 1),
                    crossAxisAlignment: CrossAxisAlignment.center,
                  ),
                ),
                Text(
                    playerController.mediaItemsInitial
                            .elementAt(
                                playerController.currentPlayingSongIndex.value!)
                            .artist ??
                        "Unknow Artist",
                    style: Theme.of(context).textTheme.bodySmall)
              ],
            ),
          ),

          //  song Count
          Obx(
            () => UnconstrainedBox(
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                decoration: BoxDecoration(
                  color: Theme.of(context).primaryColorDark,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Row(
                  children: [
                    Text(
                      "${(playerController.currentPlayingSongIndexDynamic.value! + 1).toString().addCommas} / "
                      "${playerController.mediaItemsDynamic.length.toString().addCommas}",
                      style: Theme.of(context).textTheme.bodySmall,
                    )
                  ],
                ),
              ),
            ),
          ),

          //  seekbar buttons
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              //  shuffle playback
              GestureDetector(
                onTap: () {
                  //  shuffle songs
                  playerController.shuffleSongs();

                  if (playerController.isShuffleModeEnabled.value) {
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
                  () => Container(
                    width: 35,
                    height: 35,
                    decoration: BoxDecoration(
                        color: Theme.of(context).primaryColorDark,
                        borderRadius: BorderRadius.circular(100)),
                    child: playerController.isShuffleModeEnabled.value
                        ? Icon(
                            Icons.shuffle,
                            size: 16,
                            color: Theme.of(context).primaryColor,
                          )
                        : Icon(
                            Icons.shuffle,
                            size: 16,
                            color: Theme.of(context).iconTheme.color,
                          ),
                  ),
                ),
              ),

              //  seek buttons
              Flexible(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    InkWell(
                      onTap: widget.onPreviousSong,
                      borderRadius: BorderRadius.circular(100),
                      child: Container(
                        width: 45,
                        height: 45,
                        decoration: BoxDecoration(
                            color: Colors.transparent,
                            borderRadius: BorderRadius.circular(100)),
                        child: Icon(
                          Icons.skip_previous_rounded,
                          size: 24,
                          color: Theme.of(context).iconTheme.color,
                        ),
                      ),
                    ),
                    InkWell(
                        onTap: () {
                          //  play or pause music
                          if (playerController.playerState.value ==
                              PlayerStates.playing) {
                            playerController.pauseSong();
                          } else {
                            playerController.playSong();
                          }
                        },
                        borderRadius: BorderRadius.circular(100),
                        child: Obx(
                          () => Container(
                              width: 70,
                              height: 70,
                              decoration: BoxDecoration(
                                  color: Theme.of(context).primaryColorDark,
                                  borderRadius: BorderRadius.circular(100)),
                              child: Center(
                                  child: Icon(
                                playerController.playerState.value ==
                                        PlayerStates.playing
                                    ? Icons.pause_rounded
                                    : Icons.play_arrow_rounded,
                                color: Theme.of(context).primaryColor,
                                size: 36,
                              ))),
                        )),
                    InkWell(
                      onTap: widget.onNextSong,
                      borderRadius: BorderRadius.circular(100),
                      child: Container(
                        width: 45,
                        height: 45,
                        decoration: BoxDecoration(
                            color: Colors.transparent,
                            borderRadius: BorderRadius.circular(100)),
                        child: Icon(
                          Icons.skip_next_rounded,
                          size: 24,
                          color: Theme.of(context).iconTheme.color,
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              //  repeat playback
              GestureDetector(
                onTap: () {
                  playerController.repeat();
                  switch (playerController.repeatButtonState.value) {
                    case RepeatState.off:
                      showToast(
                          toast: _toast,
                          iconData: Icons.repeat,
                          msg: "Repeat off");
                      break;
                    case RepeatState.repeatSong:
                      showToast(
                          toast: _toast,
                          iconData: Icons.repeat_one_rounded,
                          msg: "Repeating current song");
                      break;
                    case RepeatState.repeatPlaylist:
                      showToast(
                          toast: _toast,
                          iconData: Icons.repeat,
                          msg: "Repeating all songs");
                      break;
                  }
                },
                child: Obx(
                  () => Container(
                    width: 35,
                    height: 35,
                    decoration: BoxDecoration(
                        color: Theme.of(context).primaryColorDark,
                        borderRadius: BorderRadius.circular(100)),
                    child: playerController.repeatButtonState.value ==
                            RepeatState.off
                        ? Icon(
                            Icons.repeat,
                            size: 16,
                            color: Theme.of(context).iconTheme.color,
                          )
                        : playerController.repeatButtonState.value ==
                                RepeatState.repeatSong
                            ? Icon(
                                Icons.repeat_one_rounded,
                                size: 16,
                                color: Theme.of(context).primaryColor,
                              )
                            : Icon(
                                Icons.repeat,
                                size: 16,
                                color: Theme.of(context).primaryColor,
                              ),
                  ),
                ),
              ),
            ],
          ),

          //  slider
          Obx(() => ProgressBar(
                progress: playerController.progressElapsed.value,
                total: playerController.progressDuration.value,
                timeLabelLocation: TimeLabelLocation.sides,
                timeLabelTextStyle: Theme.of(context).textTheme.bodySmall,
                baseBarColor: Theme.of(context).primaryColorDark,
                progressBarColor: Theme.of(context).primaryColor,
                thumbColor: Theme.of(context).primaryColor,
                thumbGlowColor:
                    Theme.of(context).primaryColorDark.withOpacity(0.7),
                onSeek: (dur) {
                  playerController.seekSong(seconds: dur.inSeconds);
                },
              )),

          //  quick actions
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              //  playlist icon
              quickAction(
                  child: Icon(
                    Icons.playlist_add,
                    color: Theme.of(context).primaryColor,
                  ),
                  onTap: widget.onPlaylistClicked),

              const SizedBox(
                width: 8,
              ),

              //  favourites
              quickAction(
                  child: Icon(
                    Icons.favorite_outline_rounded,
                    color: Theme.of(context).primaryColor,
                  ),
                  onTap: () {}),

              const SizedBox(
                width: 8,
              ),

              //  playback
              quickAction(
                  child: Obx(
                    () => Text(
                      playerController.speedState.value == SpeedState.one
                          ? "1 x"
                          : playerController.speedState.value == SpeedState.two
                              ? "2 x"
                              : playerController.speedState.value ==
                                      SpeedState.three
                                  ? "3 x"
                                  : playerController.speedState.value ==
                                          SpeedState.five
                                      ? "5 x"
                                      : "1 x",
                      style: TextStyle(
                          fontSize:
                              Theme.of(context).textTheme.bodyLarge?.fontSize,
                          fontWeight:
                              Theme.of(context).textTheme.bodyLarge?.fontWeight,
                          color: Theme.of(context).primaryColor),
                    ),
                  ),
                  onTap: () {
                    //  add current song speed
                    playerController.setSpeed();
                  })
            ],
          )
        ],
      ),
    );
  }
}
