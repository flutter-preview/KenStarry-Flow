import 'package:flow/features/feature_playlist/domain/model/playlist.dart';
import 'package:flutter/material.dart';

class ViewPlaylistCarouselCard extends StatelessWidget {
  final Playlist playlist;

  const ViewPlaylistCarouselCard({super.key, required this.playlist});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(24)),
      child: Column(
        children: [
          //  image
          Expanded(
            flex: 5,
            child: Stack(
              fit: StackFit.loose,
              children: [
                Container(
                  width: 220,
                  height: 220,
                  decoration: BoxDecoration(
                      color: Theme.of(context).primaryColorDark,
                    borderRadius: BorderRadius.circular(500)
                  ),
                  child: Icon(
                    Icons.music_note_outlined,
                    size: 64,
                    color: Theme.of(context).iconTheme.color,
                  ),
                ),
                //  play button
                // Align(
                //   alignment: AlignmentDirectional.bottomEnd,
                //   child: Container(
                //     width: 60,
                //     height: 60,
                //     decoration: BoxDecoration(
                //       borderRadius: BorderRadius.circular(100),
                //       border: Border.all(
                //           color: Theme.of(context).scaffoldBackgroundColor,
                //           width: 5),
                //       color: Theme.of(context).primaryColorDark,
                //     ),
                //     child: Icon(
                //       Icons.play_arrow_rounded,
                //       color: Theme.of(context).primaryColor,
                //       size: 32,
                //     ),
                //   ),
                // )
              ],
            ),
          ),

          const SizedBox(height: 16,),

          Expanded(
            child: Align(
              alignment: AlignmentDirectional.center,
              child: Text(
                playlist.playlistName ?? "",
                style: Theme.of(context).textTheme.titleMedium,
              ),
            ),
          )
        ],
      ),
    );
  }
}
