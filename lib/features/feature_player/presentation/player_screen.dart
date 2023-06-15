import 'package:flutter/material.dart';
import 'package:marquee/marquee.dart';
import 'package:on_audio_query/on_audio_query.dart';

class PlayerScreen extends StatelessWidget {
  final SongModel song;

  const PlayerScreen({super.key, required this.song});

  @override
  Widget build(BuildContext context) {
    return Wrap(
      alignment: WrapAlignment.center,
      runSpacing: 24,
      crossAxisAlignment: WrapCrossAlignment.center,
      children: [
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
                nullArtworkWidget: Icon(
                  Icons.music_note_outlined,
                  size: 120,
                  color: Theme.of(context).iconTheme.color,
                ),
                quality: 100,
              )),
        ),
        //  song Name
        Container(
          width: double.infinity,
          height: 50,
          padding: const EdgeInsets.symmetric(horizontal: 48),
          child: Marquee(
            text: song.displayNameWOExt,
            style: Theme.of(context).textTheme.bodyLarge,
            pauseAfterRound: const Duration(seconds: 1),
            crossAxisAlignment: CrossAxisAlignment.center,
          ),
        )
      ],
    );
  }
}
