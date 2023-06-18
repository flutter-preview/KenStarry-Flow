import 'package:flow/features/feature_artists/presentation/controller/artists_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ArtistsList extends StatelessWidget {
  final ArtistsController artistsController;

  const ArtistsList({super.key, required this.artistsController});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
        gridDelegate:
            const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
        itemBuilder: (context, index) {});
  }
}
