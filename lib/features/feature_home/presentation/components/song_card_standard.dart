import 'package:flutter/material.dart';
import 'package:on_audio_query/on_audio_query.dart';

import '../../../../core/presentation/controller/core_controller.dart';
import '../../../../theme/colors.dart';
import '../controller/player_controller.dart';

class SongCardStandard extends StatelessWidget {
  final SongModel song;
  final int songIndex;
  final CoreController coreController;
  final PlayerController playerController;
  final VoidCallback onSongTapped;

  const SongCardStandard(
      {super.key,
        required this.song,
        required this.songIndex,
        required this.coreController,
        required this.playerController,
        required this.onSongTapped});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onSongTapped,
      child: Container(
        padding:
        const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            color: Theme.of(context).primaryColorDark),
        child: Row(
          children: [
            //  image
            Container(
              width: 60,
              height: 60,
              decoration:
              BoxDecoration(borderRadius: BorderRadius.circular(8)),
              child: QueryArtworkWidget(
                id: song.id,
                type: ArtworkType.AUDIO,
                artworkFit: BoxFit.cover,
                artworkWidth: double.infinity,
                artworkHeight: double.infinity,
                artworkBorder: BorderRadius.circular(8),
                nullArtworkWidget:
                const Icon(Icons.music_note, color: accent),
              ),
            ),

            const SizedBox(
              width: 12,
            ),

            //  songname
            Flexible(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    song.displayNameWOExt,
                    style: Theme.of(context).textTheme.bodyMedium,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  Text(
                    "${song.artist}",
                    style: Theme.of(context).textTheme.bodySmall,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}