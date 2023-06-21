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
  late final TextEditingController _playlistNameController;

  @override
  void initState() {
    super.initState();
    _playlistController = Get.find<PlaylistController>();
    _playlistNameController = TextEditingController();

    _playlistNameController.addListener(() {
      //  do something with our text
    });
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
          Align(
              alignment: AlignmentDirectional.center,
              child: Text(
                "Add Playlist",
                style: Theme.of(context).textTheme.titleSmall,
              )),

          //  Playlist Name
          TextField(
            autofocus: true,
            controller: _playlistNameController,
            keyboardType: TextInputType.text,
            textInputAction: TextInputAction.done,
            style: Theme.of(context).textTheme.bodyLarge,
            cursorColor: Theme.of(context).primaryColor,
            cursorOpacityAnimates: true,
            onChanged: (text) {},
          )
        ],
      ),
    );
  }
}























