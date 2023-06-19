import 'package:flow/features/feature_artists/presentation/components/artist_view_card.dart';
import 'package:flow/features/feature_artists/presentation/controller/artists_controller.dart';
import 'package:flutter/material.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:get/get.dart';

class ArtistViewScreen extends StatefulWidget {
  final ArtistModel artist;

  const ArtistViewScreen({super.key, required this.artist});

  @override
  State<ArtistViewScreen> createState() => _ArtistViewScreenState();
}

class _ArtistViewScreenState extends State<ArtistViewScreen> {
  late final ArtistsController _artistsController;
  late PageController _pageController;

  @override
  void initState() {
    super.initState();

    _artistsController = Get.find();

    //  scroll to the index where the artist has been clicked
    _pageController = PageController(
        viewportFraction: 0.7,
        initialPage: _artistsController.artists
            .indexWhere((a) => a.artist == widget.artist.artist));
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            //  Page View
            Obx(
              () => Container(
                height: 300,
                padding: const EdgeInsets.symmetric(vertical: 16),
                child: PageView.builder(
                    controller: _pageController,
                    physics: const BouncingScrollPhysics(),
                    itemCount: _artistsController.artists.length,
                    itemBuilder: (context, index) {
                      return ArtistViewCard(
                          artistModel: _artistsController.artists[index]);
                    }),
              ),
            )
          ],
        ),
      ),
    );
  }
}
