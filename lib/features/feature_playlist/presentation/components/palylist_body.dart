import 'package:flow/core/presentation/components/my_lottie.dart';
import 'package:flow/features/feature_playlist/domain/model/playlist.dart';
import 'package:flow/features/feature_playlist/presentation/controller/playlist_controller.dart';
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
      child: ValueListenableBuilder(
          valueListenable: _playlistController.playlists.value,
          builder: (context, box, widget) {
            //  playlists
            return box.length != 0
                ? ListView.builder(
                    itemCount: box.length,
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      final playlist = box.getAt(index) as Playlist?;

                      return Text(playlist?.playlistName ?? "Nothing");
                    })
                : Center(
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
    );
  }
}
