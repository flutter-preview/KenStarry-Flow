import 'package:flow/core/presentation/controller/player_controller.dart';
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
  late final PlayerController _playerController;

  @override
  void initState() {
    super.initState();

    _playlistController = Get.find<PlaylistController>();
    _playerController = Get.find<PlayerController>();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 400,
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
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                width: double.infinity,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Add to Playlist",
                      style: Theme.of(context).textTheme.titleSmall,
                    ),

                    //  playlist count
                    Row(
                      children: [
                        Container(
                          width: 30,
                          height: 30,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(100),
                              color: Theme.of(context).primaryColorDark),
                          child: Center(
                              child: Icon(
                            Icons.account_tree_rounded,
                            color: Theme.of(context).primaryColor,
                            size: 16,
                          )),
                        ),
                        const SizedBox(width: 8),
                        Text(
                          _playlistController.playlists.length == 1
                              ? "${_playlistController.playlists.length} playlist"
                              : "${_playlistController.playlists.length} playlists",
                          style: Theme.of(context).textTheme.bodySmall,
                        )
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 8,
              ),
              //  create playlist button
              UnconstrainedBox(
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  decoration: BoxDecoration(
                      color: Theme.of(context).primaryColorDark,
                      borderRadius: BorderRadius.circular(30)),
                  child: Row(
                    children: [
                      Icon(
                        Icons.add,
                        color: Theme.of(context).primaryColor,
                      ),
                      Text(
                        "New Playlist",
                        style: Theme.of(context).textTheme.bodySmall,
                      )
                    ],
                  ),
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

                            //  current playing song
                            final currentSong = _playerController.songs
                                .elementAt(_playerController
                                    .currentPlayingSongIndex.value!);

                            return PlaylistCardSmall(
                              playlist: playlist,
                              playlistController: _playlistController,
                              isChecked: playlist.playlistSongIds!
                                  .contains(currentSong.id.toString()),
                              onTap: () {
                                final songIdsInPlaylist =
                                    playlist.playlistSongIds!;

                                if (playlist.playlistSongIds!
                                    .contains(currentSong.id.toString())) {
                                  _playlistController.unPickPlaylistToAddSong(
                                      playlist: playlist);
                                  //  remove song from DB
                                  songIdsInPlaylist
                                      .remove(currentSong.id.toString());
                                } else {
                                  _playlistController.pickPlaylistToAddSong(
                                      playlist: playlist);
                                  //  add song to playlist in DB and update the database with new value
                                  songIdsInPlaylist
                                      .add(currentSong.id.toString());
                                }

                                final updatedPlaylist = Playlist(
                                    playlistSongIds: songIdsInPlaylist);

                                //  publish playlist back to database
                                _playlistController.updatePlaylist(
                                    index: playlists.indexOf(playlist),
                                    playlist: updatedPlaylist);
                              },
                            );
                          },
                          separatorBuilder: (context, index) => const SizedBox(
                            height: 16,
                          ),
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
                  onPressed: () {
                    //  remove the songs from the database
                    Navigator.pop(context);
                  },
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
                  onPressed: () async {
                    Get.back(canPop: true);
                  },
                  child: Text("Save"))
            ],
          )
        ],
      ),
    );
  }
}
