import 'package:flow/core/presentation/controller/core_controller.dart';
import 'package:flow/features/feature_home/presentation/controller/player_controller.dart';
import 'package:flow/theme/colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:on_audio_query/on_audio_query.dart';

class SongCard extends StatelessWidget {
  final SongModel song;
  final int songIndex;
  final CoreController coreController;
  final PlayerController playerController;
  final VoidCallback onSongTapped;

  const SongCard(
      {super.key,
      required this.song,
      required this.songIndex,
      required this.coreController,
      required this.playerController,
      required this.onSongTapped});

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => InkWell(
        onTap: onSongTapped,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            color:
                playerController.currentPlayingSongIndex.value == songIndex &&
                        playerController.isPlaying.value
                    ? Theme.of(context).primaryColor.withOpacity(0.9)
                    : Theme.of(context).primaryColorDark,
          ),
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
                  nullArtworkWidget: Icon(
                    Icons.music_note,
                    color: playerController.currentPlayingSongIndex.value ==
                                songIndex &&
                            playerController.isPlaying.value
                        ? bgDarkColor
                        : accent,
                  ),
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
      ),
    );
  }
}
