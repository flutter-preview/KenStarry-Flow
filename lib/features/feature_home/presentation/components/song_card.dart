import 'package:flow/core/presentation/controller/core_controller.dart';
import 'package:flow/theme/colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:on_audio_query/on_audio_query.dart';

class SongCard extends StatelessWidget {

  final SongModel song;
  final CoreController coreController;

  const SongCard({super.key, required this.song, required this.coreController});

  @override
  Widget build(BuildContext context) {
    return Obx(
        () => Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          color: coreController.isDarkMode.value ? bgDarkColor : accentLight,
        ),
        child: Row(
          children: [
            //  image
            Flexible(
              child: Text(
                song.displayNameWOExt,
                style: Theme.of(context).textTheme.bodyMedium,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            // QueryArtworkWidget(id: songs[index].id, type: ArtworkType.AUDIO)
          ],
        ),
      ),
    );
  }
}
