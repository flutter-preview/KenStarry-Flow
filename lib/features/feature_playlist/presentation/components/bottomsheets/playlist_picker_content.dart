import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../controller/playlist_controller.dart';

class PlaylistPickerContent extends StatefulWidget {
  const PlaylistPickerContent({super.key});

  @override
  State<PlaylistPickerContent> createState() => _PlaylistPickerContentState();
}

class _PlaylistPickerContentState extends State<PlaylistPickerContent> {
  late final PlaylistController _playlistController;

  @override
  void initState() {
    super.initState();

    _playlistController = Get.find<PlaylistController>();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 350,
      width: double.infinity,
      margin: const EdgeInsets.all(16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: Theme.of(context).scaffoldBackgroundColor,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Playlists", style: Theme.of(context).textTheme.titleSmall,),

          //  all playlists
        ],
      ),
    );
  }
}
