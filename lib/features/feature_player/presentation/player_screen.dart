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
import 'package:flow/features/feature_player/presentation/components/progress_bar_player_section.dart';
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
          SeekbarPlayerSection(
            toast: _toast,
            onNextSong: widget.onNextSong,
            onPreviousSong: widget.onPreviousSong,
            onPlaylistClicked: widget.onPlaylistClicked,
          ),

          //  Progress bar
          const ProgressBarPlayerSection(),

          //  quick actions

        ],
      ),
    );
  }
}
