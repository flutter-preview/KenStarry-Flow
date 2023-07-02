import 'package:flow/features/feature_player/presentation/components/quick_action.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../../../core/domain/models/speed_state.dart';
import '../../../../core/presentation/controller/player_controller.dart';

class QuickActionsPlayerSection extends StatefulWidget {

  final VoidCallback onPlaylistClicked;

  const QuickActionsPlayerSection({super.key, required this.onPlaylistClicked});

  @override
  State<QuickActionsPlayerSection> createState() => _QuickActionsPlayerSectionState();
}

class _QuickActionsPlayerSectionState extends State<QuickActionsPlayerSection> {

  late final PlayerController _playerController;

  @override
  void initState() {
    super.initState();

    _playerController = Get.find();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
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
                _playerController.speedState.value == SpeedState.one
                    ? "1 x"
                    : _playerController.speedState.value == SpeedState.two
                    ? "2 x"
                    : _playerController.speedState.value ==
                    SpeedState.three
                    ? "3 x"
                    : _playerController.speedState.value ==
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
              _playerController.setSpeed();
            })
      ],
    );
  }
}
