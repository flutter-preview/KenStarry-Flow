import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../../../core/presentation/components/show_toast.dart';
import '../../../../core/presentation/controller/player_controller.dart';

class SeekbarPlayerSection extends StatefulWidget {
  final FToast toast;
  final VoidCallback onNextSong;
  final VoidCallback onPreviousSong;
  final VoidCallback onPlaylistClicked;

  const SeekbarPlayerSection(
      {super.key,
      required this.toast,
      required this.onNextSong,
      required this.onPreviousSong,
      required this.onPlaylistClicked});

  @override
  State<SeekbarPlayerSection> createState() => _SeekbarPlayerSectionState();
}

class _SeekbarPlayerSectionState extends State<SeekbarPlayerSection> {
  late final PlayerController _playerController;

  @override
  void initState() {
    super.initState();

    _playerController = Get.find();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        //  shuffle playback
        GestureDetector(
          onTap: () {
            //  shuffle songs
            _playerController.shuffleSongs();

            if (_playerController.isShuffleModeEnabled.value) {
              showToast(
                  toast: widget.toast,
                  iconData: Icons.shuffle_rounded,
                  msg: "Shuffle on");
            } else {
              showToast(
                  toast: widget.toast,
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
              child: _playerController.isShuffleModeEnabled.value
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
                    toast: _toast, iconData: Icons.repeat, msg: "Repeat off");
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
              child: playerController.repeatButtonState.value == RepeatState.off
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
    );
  }
}
