import 'package:flow/features/feature_playlist/domain/model/playlist.dart';
import 'package:flow/features/feature_playlist/presentation/controller/playlist_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PlaylistCard extends StatefulWidget {
  final Playlist playlist;
  final VoidCallback onDelete;
  final VoidCallback onTap;

  PlaylistCard(
      {super.key, required this.playlist, required this.onDelete, required this.onTap});

  @override
  State<PlaylistCard> createState() => _PlaylistCardState();
}

class _PlaylistCardState extends State<PlaylistCard> {

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    return GestureDetector(
      onTap: widget.onTap,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          //  playlist Image
          Stack(
            children: [
              Container(
                width: 150,
                height: 150,
                decoration: BoxDecoration(
                    color: Theme.of(context).primaryColorDark,
                    borderRadius: BorderRadius.circular(24)),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(24),
                  child: Center(
                    child: Icon(
                      Icons.music_note_outlined,
                      size: 32,
                    ),
                  ),
                ),
              ),
              //  songs count
              Align(
                alignment: AlignmentDirectional.centerEnd,
                child: Container(
                  padding:
                  const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                  decoration: BoxDecoration(
                      color: Theme.of(context).primaryColorDark,
                      borderRadius: BorderRadius.circular(30),
                      border: Border.all(
                          color: Theme.of(context).scaffoldBackgroundColor,
                          width: 5)),
                  child: Text(
                    widget.playlist.playlistSongIds?.length.toString() ?? '0',
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                ),
              )
            ],
          ),

          Padding(
            padding: const EdgeInsets.only(left: 8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                //  playlist name
                Expanded(
                  child: Text(
                    widget.playlist.playlistName ?? "No name",
                    style: Theme.of(context).textTheme.bodyMedium,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                //  playlist more action
                PopupMenuButton(
                    itemBuilder: (context) => [
                          //  delete icon
                          PopupMenuItem(
                            onTap: widget.onDelete,
                            child: Row(
                              children: [
                                Icon(
                                  Icons.delete_outline_rounded,
                                  size: 16,
                                  color: Theme.of(context).iconTheme.color,
                                ),
                                const SizedBox(
                                  width: 8,
                                ),
                                Text(
                                  "Delete",
                                  style: Theme.of(context).textTheme.bodyMedium,
                                )
                              ],
                            ),
                          ),
                        ])
              ],
            ),
          )
        ],
      ),
    );
  }
}
