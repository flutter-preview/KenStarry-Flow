import 'package:carousel_slider/carousel_slider.dart';
import 'package:flow/features/feature_playlist/domain/model/playlist.dart';
import 'package:flow/features/feature_playlist/presentation/components/view_playlist_carousel_card.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../controller/playlist_controller.dart';

class ViewPlaylistScreen extends StatefulWidget {
  final Playlist playlist;

  const ViewPlaylistScreen({super.key, required this.playlist});

  @override
  State<ViewPlaylistScreen> createState() => _ViewPlaylistScreenState();
}

class _ViewPlaylistScreenState extends State<ViewPlaylistScreen> {
  late final PlaylistController _playlistController;

  @override
  void initState() {
    super.initState();
    _playlistController = PlaylistController();
  }

  @override
  Widget build(BuildContext context) {
    var playlist = widget.playlist;

    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
              onPressed: () {},
              icon: Icon(
                Icons.arrow_back,
                color: Theme.of(context).iconTheme.color,
              )),
          elevation: 0,
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        ),
        body: ValueListenableBuilder(
            valueListenable: _playlistController.playlistsBox.value,
            builder: (context, box, widget) {
              final List<Playlist>? playlists =
                  box.values.cast<Playlist>().toList();

              return playlists != null
                  ? Column(
                      children: [
                        //  carousel playlist slider
                        CarouselSlider.builder(
                            itemCount: playlists.length,
                            itemBuilder: (context, index, realIndex) {
                              final currentPlaylist = playlists[index];

                              return ViewPlaylistCarouselCard(
                                  playlist: currentPlaylist);
                            },
                            options: CarouselOptions(
                                height: 250,
                                initialPage: playlists.indexOf(playlist),
                                enlargeCenterPage: true,
                                enableInfiniteScroll: false,
                                scrollPhysics: const BouncingScrollPhysics(),
                                onPageChanged: (index, reason) {
                                  _playlistController.setSelectedPlaylistIndex(
                                      index: index);
                                })),

                        //  carousel indicators
                        Obx(
                          () => AnimatedSmoothIndicator(
                            activeIndex:
                                _playlistController.selectedPlaylistIndex.value,
                            count: playlists.length,
                            effect: ExpandingDotsEffect(
                              dotHeight: 12,
                              dotWidth: 12,
                              activeDotColor: Theme.of(context).primaryColor,
                              dotColor: Theme.of(context).textTheme.bodySmall!.color!.withOpacity(0.5)
                            ),
                            onDotClicked: (index){},
                          ),
                        )
                      ],
                    )
                  : const CircularProgressIndicator();
            }));
  }
}
