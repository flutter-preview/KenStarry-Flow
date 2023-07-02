import 'package:flow/core/utils/extensions/color_extensions.dart';
import 'package:flutter/material.dart';
import 'package:on_audio_query/on_audio_query.dart';

class ArtistsSubCard extends StatelessWidget {
  final ArtistModel artist;
  final VoidCallback onPlayTapped;
  final VoidCallback onArtworkTapped;

  const ArtistsSubCard(
      {super.key,
      required this.artist,
      required this.onPlayTapped,
      required this.onArtworkTapped});

  @override
  Widget build(BuildContext context) {
    return UnconstrainedBox(
      child: Container(
        width: 130,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 130,
              height: 130,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(24),
              ),
              child: Stack(
                fit: StackFit.expand,
                children: [
                  //  artwork image
                  GestureDetector(
                    onTap: onArtworkTapped,
                    child: QueryArtworkWidget(
                      id: artist.id,
                      keepOldArtwork: true,
                      type: ArtworkType.ARTIST,
                      artworkFit: BoxFit.cover,
                      artworkWidth: double.infinity,
                      artworkHeight: double.infinity,
                      artworkBorder: BorderRadius.circular(24),
                      nullArtworkWidget: Icon(Icons.music_note,
                          color: Theme.of(context).primaryColor),
                    ),
                  ),

                  //  play icon
                  GestureDetector(
                    onTap: onPlayTapped,
                    child: Padding(
                      padding: const EdgeInsets.all(8),
                      child: Align(
                        alignment: AlignmentDirectional.bottomEnd,
                        child: UnconstrainedBox(
                          child: Container(
                            width: 40,
                            height: 40,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(100),
                                color: Theme.of(context)
                                    .primaryColor
                                    .darkenColor(80)),
                            child: Center(
                                child: Icon(
                              Icons.play_arrow_rounded,
                              color: Theme.of(context).primaryColor,
                            )),
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),

            const SizedBox(
              height: 8,
            ),
            //  artist name
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    artist.artist,
                    style: Theme.of(context).textTheme.bodyMedium,
                    overflow: TextOverflow.ellipsis,
                  ),
                  Text(
                    "${artist.numberOfTracks.toString()} songs",
                    style: Theme.of(context).textTheme.bodySmall,
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
