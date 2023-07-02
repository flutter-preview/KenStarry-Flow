import 'package:audio_video_progress_bar/audio_video_progress_bar.dart';
import 'package:flow/core/domain/models/repeat_state.dart';
import 'package:flow/core/domain/models/speed_state.dart';
import 'package:flow/core/presentation/components/show_toast.dart';
import 'package:flow/core/utils/extensions/color_extensions.dart';
import 'package:flow/core/utils/extensions/string_extensions.dart';
import 'package:flow/di/locator.dart';
import 'package:flow/core/presentation/controller/player_controller.dart';
import 'package:flow/features/feature_player/presentation/components/artist_song_name_player_section.dart';
import 'package:flow/features/feature_player/presentation/components/artwork_player_section.dart';
import 'package:flow/features/feature_player/presentation/components/quick_action.dart';
import 'package:flow/features/feature_player/presentation/components/seekbar_player_section.dart';
import 'package:flow/features/feature_player/presentation/components/song_count_player_section.dart';
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
          const ArtworkPlayerSection(),

          //  artist and song name
          const ArtistSongNamePlayerSection(),

          //  song Count
          const SongCountPlayerSection(),

          //  seekbar buttons
          const SeekbarPlayerSection(),

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
