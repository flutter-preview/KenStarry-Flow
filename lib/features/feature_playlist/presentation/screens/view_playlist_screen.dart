import 'package:carousel_slider/carousel_slider.dart';
import 'package:flow/core/presentation/controller/core_controller.dart';
import 'package:flow/core/presentation/controller/player_controller.dart';
import 'package:flow/features/feature_home/presentation/controller/home_controller.dart';
import 'package:flow/features/feature_playlist/domain/model/playlist.dart';
import 'package:flow/features/feature_playlist/presentation/components/view_playlist_carousel_card.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../../../core/presentation/components/show_player_bottom_sheet.dart';
import '../../../feature_home/domain/model/player_states.dart';
import '../../../feature_home/presentation/components/song_card.dart';
import '../controller/playlist_controller.dart';

class ViewPlaylistScreen extends StatefulWidget {
  final Playlist playlist;

  const ViewPlaylistScreen({super.key, required this.playlist});

  @override
  State<ViewPlaylistScreen> createState() => _ViewPlaylistScreenState();
}

class _ViewPlaylistScreenState extends State<ViewPlaylistScreen> {
  late final PlaylistController _playlistController;
  late final PlayerController _playerController;
  late final CoreController _coreController;
  late final HomeController _homeController;
  late final CarouselController _carouselController;

  @override
  void initState() {
    super.initState();
    _playlistController = Get.find<PlaylistController>();
    _playerController = Get.find<PlayerController>();
    _coreController = Get.find<CoreController>();
    _homeController = Get.find<HomeController>();
    _carouselController = CarouselController();
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

              if (playlists != null) {
                WidgetsBinding.instance.addPostFrameCallback((_) {
                  _playlistController.setSelectedPlaylistIndex(
                      index: playlists.indexOf(playlist));

                  _playlistController.getPlaylistSongs(playlist: playlist);
                });
              }

              return playlists != null
                  ? Column(
                      children: [
                        Column(
                          children: [
                            //  carousel playlist slider
                            CarouselSlider.builder(
                                itemCount: playlists.length,
                                itemBuilder: (context, index, realIndex) {
                                  final currentPlaylist = playlists[index];

                                  return ViewPlaylistCarouselCard(
                                      playlist: currentPlaylist);
                                },
                                carouselController: _carouselController,
                                options: CarouselOptions(
                                    height: 300,
                                    initialPage: playlists.indexOf(playlist),
                                    enlargeCenterPage: true,
                                    enableInfiniteScroll: false,
                                    viewportFraction: 0.8,
                                    scrollPhysics:
                                        const BouncingScrollPhysics(),
                                    onPageChanged: (index, reason) {
                                      _playlistController
                                          .setSelectedPlaylistIndex(
                                              index: index);

                                      _playlistController.getPlaylistSongs(
                                          playlist: _playlistController
                                              .playlists[index]);
                                    })),

                            const SizedBox(
                              height: 8,
                            ),

                            //  carousel indicators
                            Obx(
                              () => AnimatedSmoothIndicator(
                                activeIndex: _playlistController
                                    .selectedPlaylistIndex.value,
                                count: playlists.length,
                                effect: ExpandingDotsEffect(
                                    dotHeight: 12,
                                    dotWidth: 12,
                                    activeDotColor:
                                        Theme.of(context).primaryColor,
                                    dotColor: Theme.of(context)
                                        .textTheme
                                        .bodySmall!
                                        .color!
                                        .withOpacity(0.5)),
                                onDotClicked: (index) {
                                  _carouselController.animateToPage(index);
                                },
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 16,
                        ),
                        Expanded(
                            flex: 3,
                            child: Obx(
                              () => _playlistController.playlistSongs.isNotEmpty
                                  ? ListView.builder(
                                      physics: const BouncingScrollPhysics(),
                                      itemCount: _playlistController
                                          .playlistSongs.length,
                                      itemBuilder: (context, index) {
                                        var currentSongIndex = _playerController
                                            .songs
                                            .indexOf(_playlistController
                                                .playlistSongs[index]);

                                        return SongCard(
                                          song: _playlistController
                                              .playlistSongs[index],
                                          songIndex: currentSongIndex,
                                          coreController: _coreController,
                                          playerController: _playerController,
                                          onSongTapped: () {
                                            if (_playerController
                                                        .playerState.value ==
                                                    PlayerStates.playing &&
                                                _playerController
                                                        .currentPlayingSongIndex
                                                        .value ==
                                                    currentSongIndex) {
                                              //  open player screen bottom sheet
                                              showPlayerBottomSheet(
                                                  playerController:
                                                      _playerController,
                                                  homeController:
                                                      _homeController);
                                            } else {
                                              _playerController.playSong(
                                                  path: _playerController
                                                      .songs[currentSongIndex]
                                                      .uri!,
                                                  index: currentSongIndex);

                                              //  open player screen bottom sheet
                                              showPlayerBottomSheet(
                                                  playerController:
                                                      _playerController,
                                                  homeController:
                                                      _homeController);
                                            }
                                          },
                                        );
                                      })
                                  : const Expanded(
                                      child: Align(
                                      alignment: AlignmentDirectional.center,
                                      child: Text("No songs yet"),
                                    )),
                            ))
                      ],
                    )
                  : const CircularProgressIndicator();
            }));
  }
}
