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
            child: Stack(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8),
                  child: ClipRRect(
                      borderRadius: BorderRadius.circular(24),
                      child: Image.asset(
                        'assets/images/lady5.jpg',
                        fit: BoxFit.cover,
                        width: double.infinity,
                      )),
                ),
                //  play button
                Align(
                  alignment: AlignmentDirectional.bottomEnd,
                  child: Container(
                    width: 60,
                    height: 60,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(100),
                      border: Border.all(
                          color: Theme.of(context).scaffoldBackgroundColor,
                          width: 5),
                      color: Theme.of(context).primaryColorDark,
                    ),
                    child: Icon(
                      Icons.play_arrow_rounded,
                      color: Theme.of(context).primaryColor,
                      size: 32,
                    ),
                  ),
                )
              ],
            ),
          ),

          Text(
            playlist.playlistName ?? "",
            style: Theme.of(context).textTheme.titleSmall,
          )
        ],
      ),
    );
  }
}
