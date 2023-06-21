import 'package:flow/features/feature_playlist/domain/model/playlist.dart';
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
      //  update text inside controller
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
            maxLength: 200,
            maxLines: 1,
            textInputAction: TextInputAction.done,
            style: Theme.of(context).textTheme.bodyLarge,
            cursorColor: Theme.of(context).primaryColor,
            decoration: InputDecoration(
                hintText: "Playlist Name",
                icon: Icon(
                  Icons.playlist_add,
                  color: Theme.of(context).primaryColor,
                ),
                contentPadding: const EdgeInsets.all(16),
                filled: true,
                fillColor: Theme.of(context).primaryColorDark,
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16),
                    borderSide: BorderSide.none)),
            cursorOpacityAnimates: true,
            onChanged: (text) {},
          ),

          //  playlist submit buttons
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              TextButton(
                  style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(
                          Theme.of(context).scaffoldBackgroundColor),
                      foregroundColor: MaterialStateProperty.all(
                          Theme.of(context).primaryColor)),
                  onPressed: () => Navigator.pop(context),
                  child: Text("Cancel")),
              const SizedBox(
                width: 8,
              ),
              TextButton(
                  style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(
                          Theme.of(context).primaryColor),
                      foregroundColor: MaterialStateProperty.all(Colors.white),
                      shape: MaterialStateProperty.all(RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(50)))),
                  onPressed: () {
                    //  add playlist to database
                    _playlistController.addPlaylist(
                        playlist: Playlist(
                            playlistName: _playlistNameController.text));
                  },
                  child: Text("Save"))
            ],
          )
        ],
      ),
    );
  }
}
