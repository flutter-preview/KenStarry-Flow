import 'package:flow/features/feature_playlist/presentation/components/playlist_card_small.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../../domain/model/playlist.dart';
import '../../controller/playlist_controller.dart';
import '../playlist_card.dart';

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
          Text(
            "Playlists",
            style: Theme.of(context).textTheme.titleSmall,
          ),

          //  all playlists
          ValueListenableBuilder(
              valueListenable: _playlistController.playlistsBox.value,
              builder: (context, box, widget) {
                final List<Playlist>? playlists =
                    box.values.cast<Playlist>().toList();

                _playlistController.initializePlaylists(playlists: playlists);

                //  playlists
                return box.length != 0 && playlists != null
                    ? Expanded(
                      child: GridView.builder(
                          gridDelegate:
                              const SliverGridDelegateWithMaxCrossAxisExtent(
                                  maxCrossAxisExtent: 150,
                                  mainAxisExtent: 200,
                                  mainAxisSpacing: 8,
                                  crossAxisSpacing: 8),
                          physics: const BouncingScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: playlists.length,
                          itemBuilder: (context, index) {
                            var playlist = playlists[index];

                            return PlaylistCardSmall(
                              playlist: playlist,
                            );
                          },
                        ),
                    )
                    : const Center(
                        child: Column(
                          children: [Text("No Playlists yet.")],
                        ),
                      );
              })
        ],
      ),
    );
  }
}
