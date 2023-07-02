import 'package:audio_video_progress_bar/audio_video_progress_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';

import '../../../../core/presentation/controller/player_controller.dart';

class ProgressBarPlayerSection extends StatefulWidget {
  const ProgressBarPlayerSection({super.key});

  @override
  State<ProgressBarPlayerSection> createState() =>
      _ProgressBarPlayerSectionState();
}

class _ProgressBarPlayerSectionState extends State<ProgressBarPlayerSection> {
  late final PlayerController _playerController;

  @override
  void initState() {
    super.initState();

    _playerController = Get.find();
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() => ProgressBar(
          progress: _playerController.progressElapsed.value,
          total: _playerController.progressDuration.value,
          timeLabelLocation: TimeLabelLocation.sides,
          timeLabelTextStyle: Theme.of(context).textTheme.bodySmall,
          baseBarColor: Theme.of(context).primaryColorDark,
          progressBarColor: Theme.of(context).primaryColor,
          thumbColor: Theme.of(context).primaryColor,
          thumbGlowColor: Theme.of(context).primaryColorDark.withOpacity(0.7),
          onSeek: (dur) {
            _playerController.seekSong(seconds: dur.inSeconds);
          },
        ));
  }
}
