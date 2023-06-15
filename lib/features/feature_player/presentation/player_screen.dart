import 'package:flutter/material.dart';
import 'package:on_audio_query/on_audio_query.dart';

class PlayerScreen extends StatelessWidget {
  final SongModel song;

  const PlayerScreen({super.key, required this.song});

  @override
  Widget build(BuildContext context) {
    return Wrap(
      children: [
        Column(
          children: [
            //  Album Art
            UnconstrainedBox(
              child: Container(
                  width: 280,
                  height: 280,
                  child: QueryArtworkWidget(
                    id: song.id,
                    type: ArtworkType.AUDIO,
                    artworkWidth: double.infinity,
                    artworkHeight: double.infinity,
                    artworkBorder: BorderRadius.circular(16),
                    artworkFit: BoxFit.cover,
                    artworkQuality: FilterQuality.high,
                    quality: 100,
                  )),
            )
          ],
        )
      ],
    );
  }
}
