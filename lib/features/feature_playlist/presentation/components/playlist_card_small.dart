import 'package:flow/features/feature_playlist/domain/model/playlist.dart';
import 'package:flow/features/feature_playlist/presentation/controller/playlist_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PlaylistCardSmall extends StatelessWidget {
  final Playlist playlist;
  final PlaylistController playlistController;
  final bool isChecked;
  final VoidCallback onTap;

  const PlaylistCardSmall(
      {super.key,
      required this.playlist,
      required this.playlistController,
      required this.isChecked,
      required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 70,
        color: Theme.of(context).scaffoldBackgroundColor,
        child: Row(
          children: [
            //  playlist Image
            SizedBox(
              width: 70,
              height: double.infinity,
              child: Stack(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      width: double.infinity,
                      height: double.infinity,
                      decoration: BoxDecoration(
                          color: Theme.of(context).primaryColorDark,
                          borderRadius: BorderRadius.circular(16)),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(16),
                        child: const Center(
                          child: Icon(
                            Icons.music_note_outlined,
                            size: 24,
                          ),
                        ),
                      ),
                    ),
                  ),

                  //  playlist selected
                  isChecked
                      ? Align(
                    alignment: AlignmentDirectional.topStart,
                    child: Container(
                      width: 30,
                      height: 30,
                      decoration: BoxDecoration(
                          color: Theme.of(context).primaryColorDark,
                          borderRadius: BorderRadius.circular(100),
                          border: Border.all(
                              color: Theme.of(context)
                                  .scaffoldBackgroundColor,
                              width: 4)),
                      child: Center(
                        child: Icon(
                          Icons.done,
                          size: 16,
                          color: Theme.of(context).primaryColor,
                        ),
                      ),
                    ),
                  )
                      : const SizedBox.shrink()
                ],
              ),
            ),

            Expanded(
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      playlist.playlistName ?? "No name",
                      style: Theme.of(context).textTheme.bodyMedium,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    Text(
                      playlist.playlistSongIds == null
                          ? '0 songs'
                          : playlist.playlistSongIds!.length == 1
                              ? '1 song'
                              : '${playlist.playlistSongIds!.length} songs',
                      style: Theme.of(context).textTheme.bodySmall,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
