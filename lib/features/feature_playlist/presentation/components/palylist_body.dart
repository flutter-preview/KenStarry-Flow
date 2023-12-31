import 'package:flow/core/presentation/components/my_lottie.dart';
import 'package:flow/core/presentation/components/show_snackbar.dart';
import 'package:flow/features/feature_playlist/domain/model/playlist.dart';
import 'package:flow/features/feature_playlist/presentation/components/playlist_card.dart';
import 'package:flow/features/feature_playlist/presentation/controller/playlist_controller.dart';
import 'package:flow/features/feature_playlist/presentation/screens/view_playlist_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PlaylistBody extends StatefulWidget {
  const PlaylistBody({super.key});

  @override
  State<PlaylistBody> createState() => _PlaylistBodyState();
}

class _PlaylistBodyState extends State<PlaylistBody> {
  late final PlaylistController _playlistController;

  @override
  void initState() {
    super.initState();

    _playlistController = Get.find<PlaylistController>();
  }

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: ValueListenableBuilder(
            valueListenable: _playlistController.playlistsBox.value,
            builder: (context, box, widget) {
              final List<Playlist>? playlists =
                  box.values.cast<Playlist>().toList();

              _playlistController.initializePlaylists(playlists: playlists);

              //  playlists
              return box.length != 0 && playlists != null
                  ? GridView.builder(
                      gridDelegate:
                          const SliverGridDelegateWithMaxCrossAxisExtent(
                              maxCrossAxisExtent: 200,
                              mainAxisExtent: 200,
                              mainAxisSpacing: 8,
                              crossAxisSpacing: 8),
                      physics: const BouncingScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: playlists.length,
                      itemBuilder: (context, index) {
                        var playlist = playlists[index];

                        return PlaylistCard(
                          playlist: playlist,
                          onDelete: () {
                            //  delete playlist
                            _playlistController.deletePlaylist(
                                index: playlists.indexOf(playlist));

                            showSnackbar(
                                title:
                                    "${playlist.playlistName} Deleted Successfully",
                                message: "Playlist successfully!",
                                iconData: Icons.delete_outline_rounded);
                          },
                          onTap: (){
                            //  open view playlist screen
                            Get.to(() => ViewPlaylistScreen(playlist: playlist,));
                          },
                        );
                      },
                    )
                  : const Center(
                      child: Column(
                        children: [
                          SizedBox(
                              child: MyLottie(
                            lottie: 'assets/lottie/playlist_grey_2.json',
                            width: 300,
                            height: 300,
                          )),
                          Text("No Playlists yet.")
                        ],
                      ),
                    );
            }),
      ),
    );
  }
}
