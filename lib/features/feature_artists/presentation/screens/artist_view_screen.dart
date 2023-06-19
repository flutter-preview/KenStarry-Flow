import 'package:flow/features/feature_artists/presentation/components/artist_view_appbar.dart';
import 'package:flow/features/feature_artists/presentation/components/artist_view_card.dart';
import 'package:flow/features/feature_artists/presentation/controller/artists_controller.dart';
import 'package:flow/features/feature_home/presentation/controller/player_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:get/get.dart';

import '../../../../core/presentation/controller/core_controller.dart';

class ArtistViewScreen extends StatefulWidget {
  final ArtistModel artist;

  const ArtistViewScreen({super.key, required this.artist});

  @override
  State<ArtistViewScreen> createState() => _ArtistViewScreenState();
}

class _ArtistViewScreenState extends State<ArtistViewScreen> {
  late final ArtistsController _artistsController;
  late final CoreController _coreController;
  late final PlayerController _playerController;
  late PageController _pageController;

  @override
  void initState() {
    super.initState();

    _artistsController = Get.find<ArtistsController>();
    _coreController = Get.find<CoreController>();
    _playerController = Get.find<PlayerController>();

    //  scroll to the index where the artist has been clicked
    _pageController = PageController(
        viewportFraction: 0.7,
        initialPage: _artistsController.artists
            .indexWhere((a) => a.artist == widget.artist.artist));

    //  get all artist songs
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _artistsController.getArtistSongs(
          artist: widget.artist, songs: _playerController.songs);
    });
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColorDark,
      appBar: artistAppBar(controller: _coreController),
      body: SafeArea(
        child: Column(
          children: [
            //  Page View
            Obx(
              () => SizedBox(
                height: 250,
                child: PageView.builder(
                  controller: _pageController,
                  physics: const BouncingScrollPhysics(),
                  itemCount: _artistsController.artists.length,
                  itemBuilder: (context, index) {
                    return ArtistViewCard(
                        artistModel: _artistsController.artists[index]);
                  },
                  onPageChanged: (page) {
                    //  get all artist songs
                    _artistsController.getArtistSongs(
                        artist: _artistsController.artists[page],
                        songs: _playerController.songs);
                  },
                ),
              ),
            ),

            //  songs
            Expanded(
              flex: 2,
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                    color: Theme.of(context).scaffoldBackgroundColor,
                    borderRadius: const BorderRadius.only(
                        topRight: Radius.circular(24),
                        topLeft: Radius.circular(24))),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        //  title
                        Text(
                          "Songs",
                          style: Theme.of(context).textTheme.titleSmall,
                        ),
                        Icon(
                          Icons.chevron_right,
                          color: Theme.of(context).iconTheme.color,
                          size: 16,
                        ),
                        //  song count
                        Obx(
                          () => Text(
                            "${_artistsController.artistSongs.length} songs",
                            style: Theme.of(context).textTheme.titleSmall,
                          ),
                        ),
                        //  total song duration
                      ],
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
