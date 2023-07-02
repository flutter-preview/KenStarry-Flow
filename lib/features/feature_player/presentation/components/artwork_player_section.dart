import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:on_audio_query/on_audio_query.dart';

class ArtworkPlayerSection extends StatelessWidget {
  const ArtworkPlayerSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => UnconstrainedBox(
        child: SizedBox(
            width: 250,
            height: 250,
            child: QueryArtworkWidget(
              id: playerController.mediaItemsInitial
                  .elementAt(playerController.currentPlayingSongIndex.value!)
                  .extras!['imageUrl'],
              keepOldArtwork: true,
              type: ArtworkType.AUDIO,
              artworkWidth: double.infinity,
              artworkHeight: double.infinity,
              artworkBorder: BorderRadius.circular(300),
              artworkFit: BoxFit.cover,
              artworkQuality: FilterQuality.high,
              nullArtworkWidget: Container(
                width: double.infinity,
                height: double.infinity,
                decoration: BoxDecoration(
                    color: Theme.of(context).primaryColorDark,
                    borderRadius: BorderRadius.circular(300)),
                child: Icon(
                  Icons.music_note_outlined,
                  size: 120,
                  color: Theme.of(context).iconTheme.color,
                ),
              ),
              quality: 100,
            )),
      ),
    );
  }
}
