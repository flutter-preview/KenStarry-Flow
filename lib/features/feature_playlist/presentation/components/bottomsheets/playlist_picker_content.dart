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
        borderRadius: BorderRadius.circular(24),
        color: Theme.of(context).scaffoldBackgroundColor,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          //  header
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Add to Playlist",
                style: Theme.of(context).textTheme.titleSmall,
              ),
              //  playlist count
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                decoration: BoxDecoration(
                    color: Theme.of(context).primaryColorDark,
                    borderRadius: BorderRadius.circular(30)),
                child: Text(
                  "${_playlistController.playlists.length} playlists",
                  style: Theme.of(context).textTheme.bodySmall,
                ),
              ),
            ],
          ),

          const SizedBox(
            height: 16,
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
                        child: ListView.separated(
                          physics: const BouncingScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: playlists.length,
                          itemBuilder: (context, index) {
                            var playlist = playlists[index];

                            return PlaylistCardSmall(
                              playlist: playlist,
                              playlistController: _playlistController,
                              onTap: () {
                                _playlistController.pickedPlaylists
                                        .contains(playlist)
                                    ? _playlistController
                                        .unPickPlaylistToAddSong(
                                            playlist: playlist)
                                    : _playlistController.pickPlaylistToAddSong(
                                        playlist: playlist);
                              },
                            );
                          },
                          separatorBuilder: (context, index) => const SizedBox(height: 16,),
                        ),
                      )
                    : const Center(
                        child: Column(
                          children: [Text("No Playlists yet.")],
                        ),
                      );
              }),

          const SizedBox(
            height: 16,
          ),

          //  sybmit button
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              TextButton(
                  style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(
                          Theme.of(context).scaffoldBackgroundColor),
                      foregroundColor: MaterialStateProperty.all(
                          Theme.of(context).primaryColor)),
                  onPressed: () => Navigator.pop(context),
                  child: Text("Cancel")),
              const SizedBox(
                width: 8,
              ),
              TextButton(
                  style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(
                          Theme.of(context).primaryColor),
                      foregroundColor: MaterialStateProperty.all(Colors.white),
                      shape: MaterialStateProperty.all(RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(50)))),
                  onPressed: () {
                    //  get the current playlist songs
                    //  add this song to the playlist
                    //  post the results back to the database and update with the new list
                  },
                  child: Text("Save"))
            ],
          )
        ],
      ),
    );
  }
}
