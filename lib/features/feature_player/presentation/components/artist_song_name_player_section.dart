import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:marquee/marquee.dart';

import '../../../../core/presentation/controller/player_controller.dart';

class ArtistSongNamePlayerSection extends StatefulWidget {
  const ArtistSongNamePlayerSection({super.key});

  @override
  State<ArtistSongNamePlayerSection> createState() => _ArtistSongNamePlayerSectionState();
}

class _ArtistSongNamePlayerSectionState extends State<ArtistSongNamePlayerSection> {

  late final PlayerController _playerController;

  @override
  void initState() {
    super.initState();

    _playerController = Get.find();
  }

  @override
  Widget build(BuildContext context) {
    return Obx(
          () => Column(
        children: [
          SizedBox(
            width: double.infinity,
            height: 50,
            child: Marquee(
              text: _playerController.mediaItemsDynamic.isEmpty
                  ? "Unknown"
                  : _playerController.mediaItemsDynamic
                  .elementAt(_playerController
                  .currentPlayingSongIndexDynamic.value!)
                  .title,
              style: Theme.of(context).textTheme.bodyLarge,
              pauseAfterRound: const Duration(seconds: 1),
              crossAxisAlignment: CrossAxisAlignment.center,
            ),
          ),
          Text(
              _playerController.mediaItemsInitial
                  .elementAt(
                  _playerController.currentPlayingSongIndex.value!)
                  .artist ??
                  "Unknow Artist",
              style: Theme.of(context).textTheme.bodySmall)
        ],
      ),
    );
  }
}
