import 'package:flow/features/feature_playlist/presentation/components/bottomsheets/create_playlist_bottom_sheet.dart';
import 'package:flow/features/feature_playlist/presentation/components/palylist_body.dart';
import 'package:flow/features/feature_playlist/presentation/components/playlist_appbar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import 'components/new_playlist_button.dart';

class PlaylistScreen extends StatefulWidget {
  const PlaylistScreen({super.key});

  @override
  State<PlaylistScreen> createState() => _PlaylistScreenState();
}

class _PlaylistScreenState extends State<PlaylistScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: CustomScrollView(
        slivers: [
          playlistAppBar(),
          //  header
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  //  add new playlist
                  addNewPlaylistBtn(onTap: () {
                    //  open create playlist bottomsheet
                    createPlaylistBottomSheet();
                  }),

                  Row(
                    children: [
                      //  shuffle songs
                      InkWell(
                        borderRadius: BorderRadius.circular(100),
                        onTap: () {
                          //  show songs
                        },
                        child: Ink(
                            width: 35,
                            height: 35,
                            decoration: BoxDecoration(
                                color: Theme.of(Get.context!).primaryColorDark,
                                borderRadius: BorderRadius.circular(50)),
                            child: Icon(
                              Icons.shuffle,
                              color: Theme.of(Get.context!).iconTheme.color,
                              size: 20,
                            )),
                      ),

                      const SizedBox(width: 8),

                      //  play button
                      InkWell(
                        borderRadius: BorderRadius.circular(100),
                        onTap: () {
                          //  start playing songs from first playlist
                        },
                        child: Ink(
                            width: 50,
                            height: 50,
                            decoration: BoxDecoration(
                                color: Theme.of(Get.context!).primaryColorDark,
                                borderRadius: BorderRadius.circular(50)),
                            child: Icon(
                              Icons.play_arrow,
                              color: Theme.of(Get.context!).primaryColor,
                              size: 32,
                            )),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
          //  body
          PlaylistBody()
        ],
      ),
    );
  }
}
