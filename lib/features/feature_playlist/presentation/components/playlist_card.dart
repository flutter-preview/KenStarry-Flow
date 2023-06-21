import 'package:flow/features/feature_playlist/domain/model/playlist.dart';
import 'package:flutter/material.dart';

class PlaylistCard extends StatelessWidget {
  final Playlist playlist;

  const PlaylistCard({super.key, required this.playlist});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        //  playlist Image
        Stack(
          children: [
            Container(
              width: 150,
              height: 150,
              decoration: BoxDecoration(
                  color: Colors.red, borderRadius: BorderRadius.circular(24)),
            ),
            //  songs count
            Align(
              alignment: AlignmentDirectional.centerEnd,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                decoration: BoxDecoration(
                  color: Theme.of(context).primaryColorDark,
                  borderRadius: BorderRadius.circular(30),
                  border: Border.all(color: Theme.of(context).scaffoldBackgroundColor, width: 5)
                ),
                child: Text(
                  "30",
                  style: Theme.of(context).textTheme.bodySmall,
                ),
              ),
            )
          ],
        ),

        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Row(
            children: [
              //  playlist name
              Text(
                playlist.playlistName ?? "No name",
                style: Theme.of(context).textTheme.bodyMedium,
              )
            ],
          ),
        )
      ],
    );
  }
}
