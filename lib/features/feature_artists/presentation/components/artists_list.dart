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
              maxCrossAxisExtent: 200, crossAxisSpacing: 8, mainAxisSpacing: 8, childAspectRatio: 1),
          itemCount: artistsController.artists.length,
          itemBuilder: (context, index) {
            return Text("Hey");
          }),
    );
  }
}
