import 'package:flow/features/feature_playlist/domain/model/playlist.dart';
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
      body: Text("Hello"),
    );
  }
}
