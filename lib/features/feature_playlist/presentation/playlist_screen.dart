import 'package:flow/features/feature_playlist/presentation/components/playlist_appbar.dart';
import 'package:flutter/material.dart';

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
                children: [
                  //  add new playlist
                  addNewPlaylistBtn(onTap: () {})
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
