import 'package:flow/core/utils/extensions/string_extensions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../../../core/presentation/controller/player_controller.dart';

class SongCountPlayerSection extends StatefulWidget {
  const SongCountPlayerSection({super.key});

  @override
  State<SongCountPlayerSection> createState() => _SongCountPlayerSectionState();
}

class _SongCountPlayerSectionState extends State<SongCountPlayerSection> {

  late final PlayerController _playerController;

  @override
  void initState() {
    super.initState();

    _playerController = Get.find();
  }

  @override
  Widget build(BuildContext context) {
    return Obx(
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
                "${(_playerController.currentPlayingSongIndexDynamic.value! + 1).toString().addCommas} / "
                    "${_playerController.mediaItemsDynamic.length.toString().addCommas}",
                style: Theme.of(context).textTheme.bodySmall,
              )
            ],
          ),
        ),
      ),
    );
  }
}
