import 'package:flow/features/feature_playlist/domain/model/playlist.dart';
import 'package:flutter/material.dart';

class ViewPlaylistScreen extends StatefulWidget {

  final Playlist playlist;

  const ViewPlaylistScreen({super.key, required this.playlist});

  @override
  State<ViewPlaylistScreen> createState() => _ViewPlaylistScreenState();
}

class _ViewPlaylistScreenState extends State<ViewPlaylistScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Text("Hello"),
    );
  }
}
