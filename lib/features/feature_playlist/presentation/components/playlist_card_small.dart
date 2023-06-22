import 'package:flow/features/feature_playlist/domain/model/playlist.dart';
import 'package:flutter/material.dart';

class PlaylistCardSmall extends StatelessWidget {
  final Playlist playlist;

  const PlaylistCardSmall({super.key, required this.playlist});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        //  playlist Image
        SizedBox(
          width: 80,
          height: 80,
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
                    child: Image.asset(
                      'assets/images/lady5.jpg',
                      width: double.infinity,
                      height: double.infinity,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),

              //  playlist selected
              Align(
                alignment: AlignmentDirectional.topStart,
                child: Container(
                  width: 30,
                  height: 30,
                  decoration: BoxDecoration(
                      color: Theme.of(context).primaryColorDark,
                      borderRadius: BorderRadius.circular(100),
                      border: Border.all(
                          color: Theme.of(context).scaffoldBackgroundColor,
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
            ],
          ),
        ),

        const SizedBox(width: 16,),

        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                playlist.playlistName ?? "No name",
                style: Theme.of(context).textTheme.bodyMedium,
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(height: 8,),
              Text(
                "5 songs",
                style: Theme.of(context).textTheme.bodySmall,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        )
      ],
    );
  }
}
