import 'package:flutter/material.dart';
import 'package:on_audio_query/on_audio_query.dart';

class ArtistViewCard extends StatelessWidget {

  final ArtistModel artistModel;

  const ArtistViewCard({super.key, required this.artistModel});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        //  Artist image
        ClipRRect(
          borderRadius: BorderRadius.circular(300),
          child: QueryArtworkWidget(
            id: artistModel.id,
            type: ArtworkType.ARTIST,
            artworkFit: BoxFit.cover,
            artworkWidth: 200,
            artworkHeight: 200,
            artworkQuality: FilterQuality.high,
            keepOldArtwork: true,
            quality: 100,
            nullArtworkWidget: Container(
                width: 200,
                height: 200,
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

        const SizedBox(height: 24,),
        //  Artist details
        Text(
          artistModel.artist,
          style: Theme.of(context).textTheme.titleSmall,
        ),
      ],
    );
  }
}
