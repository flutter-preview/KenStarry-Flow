import 'package:flow/core/presentation/components/show_toast.dart';
import 'package:flow/core/utils/extensions/string_extensions.dart';
import 'package:flow/di/locator.dart';
import 'package:flow/core/presentation/controller/player_controller.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:just_audio/just_audio.dart';
import 'package:marquee/marquee.dart';
import 'package:on_audio_query/on_audio_query.dart';

import '../../feature_home/domain/model/player_states.dart';

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
  late final AnimationController _animationController;
  late final FToast _toast;

  @override
  void initState() {
    super.initState();

    _animationController =
        AnimationController(duration: const Duration(seconds: 1), vsync: this);

    _toast = FToast();
    _toast.init(context);
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
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
          Obx(
            () => UnconstrainedBox(
              child: SizedBox(
                  width: 250,
                  height: 250,
                  child: QueryArtworkWidget(
                    id: widget
                        .songs[playerController.currentPlayingSongIndex.value!]
                        .id,
                    keepOldArtwork: true,
                    type: ArtworkType.AUDIO,
                    artworkWidth: double.infinity,
                    artworkHeight: double.infinity,
                    artworkBorder: BorderRadius.circular(300),
                    artworkFit: BoxFit.cover,
                    artworkQuality: FilterQuality.high,
                    nullArtworkWidget: Container(
                      width: double.infinity,
                      height: double.infinity,
                      decoration: BoxDecoration(
                          color: Theme.of(context).primaryColorDark,
                          borderRadius: BorderRadius.circular(300)),
                      child: Icon(
                        Icons.music_note_outlined,
                        size: 120,
                        color: Theme.of(context).iconTheme.color,
                      ),
                    ),
                    quality: 100,
                  )),
            ),
          ),

          //  artist and song name
          Obx(
            () => Column(
              children: [
                SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: Marquee(
                    text: playerController.mediaItemsInitial
                        .elementAt(
                            playerController.currentPlayingSongIndex.value!)
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
                        .artist ?? "Unknow Artist",
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
                      "${(playerController.currentPlayingSongIndex.value! + 1).toString().addCommas} / "
                      "${playerController.mediaItemsInitial.length.toString().addCommas}",
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
                  playerController.shuffle();

                  if (playerController.isShuffleModeEnabled.value) {
                    showToast(toast: _toast, iconData: Icons.shuffle_rounded, msg: "Shuffle on");
                  } else {
                    showToast(toast: _toast, iconData: Icons.shuffle_rounded, msg: "Shuffle off");
                  }
                },
                child: Container(
                  width: 35,
                  height: 35,
                  decoration: BoxDecoration(
                      color: Theme.of(context).primaryColorDark,
                      borderRadius: BorderRadius.circular(100)),
                  child: Obx(
                    () => playerController.isShuffleModeEnabled.value
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
                            _animationController.forward();
                            playerController.pauseSong();
                          } else {
                            _animationController.reverse();
                            var player = locator.get<AudioPlayer>();
                            player.play();
                          }
                        },
                        borderRadius: BorderRadius.circular(100),
                        child: Container(
                            width: 70,
                            height: 70,
                            decoration: BoxDecoration(
                                color: Theme.of(context).primaryColorDark,
                                borderRadius: BorderRadius.circular(100)),
                            child: Center(
                              child: AnimatedIcon(
                                icon: AnimatedIcons.pause_play,
                                progress: _animationController,
                                size: 36,
                                color: Theme.of(context).primaryColor,
                              ),
                            ))),
                    InkWell(
                      onTap: widget.onNextSong,
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
                onTap: (){},
                child: Container(
                  width: 35,
                  height: 35,
                  decoration: BoxDecoration(
                      color: Theme.of(context).primaryColorDark,
                      borderRadius: BorderRadius.circular(100)),
                  child: Icon(
                    Icons.repeat,
                    size: 16,
                    color: Theme.of(context).iconTheme.color,
                  ),
                ),
              ),
            ],
          ),

          //  slider
          Obx(
            () => Row(
              children: [
                SizedBox(
                  width: 40,
                  child: Text(
                    playerController.position.value,
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                ),
                Expanded(
                    child: Slider(
                  value: playerController.sliderValue.value,
                  min: const Duration(seconds: 0).inSeconds.toDouble(),
                  max: playerController.maxSlider.value,
                  onChanged: (newValue) {
                    playerController.seekSong(seconds: newValue.toInt());
                    newValue = newValue;

                    if (playerController.sliderValue.value ==
                        playerController.maxSlider.value) {
                      //  go to next song
                      playerController.playSong(
                          index:
                              playerController.currentPlayingSongIndex.value! +
                                  1);
                    }
                  },
                  thumbColor: Theme.of(context).primaryColor,
                  activeColor: Theme.of(context).primaryColor,
                  inactiveColor: Theme.of(context).primaryColorDark,
                )),
                SizedBox(
                  width: 40,
                  child: Text(
                    playerController.duration.value,
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                )
              ],
            ),
          ),

          //  quick actions
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              //  playlist icon
              IconButton(
                  onPressed: widget.onPlaylistClicked,
                  color: Theme.of(context).primaryColorDark,
                  icon: Icon(
                    Icons.playlist_add,
                    color: Theme.of(context).primaryColor,
                  )),

              //  favourites
              IconButton(
                  onPressed: () {},
                  color: Theme.of(context).primaryColorDark,
                  icon: Icon(
                    Icons.favorite_outline_rounded,
                    color: Theme.of(context).primaryColor,
                  )),

              //  playback
              IconButton(
                  onPressed: () {},
                  color: Theme.of(context).primaryColorDark,
                  icon: Icon(
                    Icons.one_x_mobiledata_rounded,
                    color: Theme.of(context).primaryColor,
                  )),
            ],
          )
        ],
      ),
    );
  }
}
