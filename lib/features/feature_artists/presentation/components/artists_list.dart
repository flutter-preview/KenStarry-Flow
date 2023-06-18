import 'package:flow/features/feature_artists/presentation/components/artist_card.dart';
import 'package:flow/features/feature_artists/presentation/controller/artists_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ArtistsList extends StatelessWidget {
  final ArtistsController artistsController;

  const ArtistsList({super.key, required this.artistsController});

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => GridView.builder(
          physics: const BouncingScrollPhysics(),
          gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
              maxCrossAxisExtent: 200,
              mainAxisExtent: 200,
              crossAxisSpacing: 16,
              childAspectRatio: 1),
          itemCount: artistsController.artists.length,
          itemBuilder: (context, index) {
            return ArtistCard(artist: artistsController.artists[index]);
          }),
    );
  }
}
