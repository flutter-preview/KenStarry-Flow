import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../../../core/presentation/controller/player_controller.dart';
import '../controller/artists_controller.dart';

class ArtistViewHeader extends StatelessWidget {
  final ArtistsController _artistsController = Get.find<ArtistsController>();
  final PlayerController _playerController = Get.find<PlayerController>();

  ArtistViewHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        children: [
          Expanded(
            child: Row(
              children: [
                //  title
                Text(
                  "Songs",
                  style: Theme.of(context).textTheme.titleSmall,
                ),
                const SizedBox(
                  width: 8,
                ),
                Icon(
                  Icons.chevron_right,
                  color: Theme.of(context).iconTheme.color,
                  size: 16,
                ),
                const SizedBox(
                  width: 8,
                ),
                //  song count
                Obx(
                  () => Text(
                    _artistsController.artistSongs.length == 1
                        ? "${_artistsController.artistSongs.length} song"
                        : "${_artistsController.artistSongs.length} songs",
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                ),
                //  total song duration
              ],
            ),
          ),

          //  song duration
          Obx(
            () => Text(
              _playerController.totalSongsDuration.value,
              style: Theme.of(context).textTheme.bodyMedium,
            ),
          ),
        ],
      ),
    );
  }
}
