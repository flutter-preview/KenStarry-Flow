import 'package:flow/features/feature_playlist/presentation/controller/playlist_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PlaylistBottomSheetContent extends StatefulWidget {
  const PlaylistBottomSheetContent({super.key});

  @override
  State<PlaylistBottomSheetContent> createState() =>
      _PlaylistBottomSheetContentState();
}

class _PlaylistBottomSheetContentState
    extends State<PlaylistBottomSheetContent> {
  late final PlaylistController _playlistController;

  @override
  void initState() {
    super.initState();
    _playlistController = Get.find<PlaylistController>();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom,
          top: 8,
          left: 16,
          right: 16),
      child: Wrap(
        runSpacing: 16,
        children: [
          //  Header
          Text("Add Playlist")
        ],
      ),
    );
  }
}
