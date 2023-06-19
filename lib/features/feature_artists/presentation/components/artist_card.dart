import 'package:flow/features/feature_artists/presentation/screens/artist_view_screen.dart';
import 'package:flutter/material.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:get/get.dart';

class ArtistCard extends StatelessWidget {
  final ArtistModel artist;

  const ArtistCard({super.key, required this.artist});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        // Open Artist View screen
        Get.to(() => ArtistViewScreen(artist: artist,));
      },
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          //  Artist image
          ClipRRect(
            borderRadius: BorderRadius.circular(100),
            child: QueryArtworkWidget(
              id: artist.id,
              type: ArtworkType.ARTIST,
              artworkFit: BoxFit.cover,
              artworkWidth: 140,
              artworkHeight: 140,
              artworkQuality: FilterQuality.high,
              keepOldArtwork: true,
              quality: 100,
              nullArtworkWidget: Container(
                  width: 140,
                  height: 140,
                  decoration: BoxDecoration(
                      color: Theme.of(context).primaryColorDark,
                      borderRadius: BorderRadius.circular(100)),
                  child: Icon(
                    Icons.broken_image_rounded,
                    color: Theme.of(context).iconTheme.color,
                    size: 48,
                  )),
            ),
          ),
          //  Artist details
          Text(
            artist.artist,
            style: Theme.of(context).textTheme.bodyMedium,
          ),
        ],
      ),
    );
  }
}
