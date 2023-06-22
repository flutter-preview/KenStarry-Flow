import 'package:carousel_slider/carousel_slider.dart';
import 'package:flow/features/feature_playlist/domain/model/playlist.dart';
import 'package:flow/features/feature_playlist/presentation/components/view_playlist_carousel_card.dart';
import 'package:flutter/material.dart';

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
    return Scaffold(
        appBar: AppBar(
          leading:
              IconButton(onPressed: () {}, icon: const Icon(Icons.arrow_back)),
          elevation: 0,
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        ),
        body: ValueListenableBuilder(
            valueListenable: _playlistController.playlistsBox.value,
            builder: (context, box, widget) {
              final List<Playlist>? playlists =
                  box.values.cast<Playlist>().toList();

              return Column(
                children: [
                  //  carousel playlist slider
                  CarouselSlider.builder(
                      itemCount: playlists?.length ?? 0,
                      itemBuilder: (context, index, realIndex) {
                        final currentPlaylist = playlists?[index];
                        return ViewPlaylistCarouselCard(
                            playlist: currentPlaylist!);
                      },
                      options:
                          CarouselOptions(height: 300))
                ],
              );
            }));
  }
}
