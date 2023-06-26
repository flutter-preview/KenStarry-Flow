import 'package:flow/core/presentation/components/show_toast.dart';
import 'package:flow/core/presentation/controller/core_controller.dart';
import 'package:flow/features/feature_playlist/domain/model/playlist.dart';
import 'package:flow/features/feature_playlist/presentation/controller/playlist_controller.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

import '../../../../../core/presentation/components/show_snackbar.dart';

class CreatePlaylistBottomSheetContent extends StatefulWidget {
  const CreatePlaylistBottomSheetContent({super.key});

  @override
  State<CreatePlaylistBottomSheetContent> createState() =>
      _CreatePlaylistBottomSheetContentState();
}

class _CreatePlaylistBottomSheetContentState
    extends State<CreatePlaylistBottomSheetContent> {
  late final PlaylistController _playlistController;
  late final TextEditingController _playlistNameController;
  late final FToast toast;

  @override
  void initState() {
    super.initState();
    _playlistController = Get.find<PlaylistController>();
    _playlistNameController = TextEditingController();
    toast = FToast();
    toast.init(context);

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
                hintStyle: TextStyle(
                    color: Theme.of(context).textTheme.bodyMedium?.color,
                    fontSize: Theme.of(context).textTheme.bodyMedium?.fontSize,
                    fontWeight:
                        Theme.of(context).textTheme.bodyMedium?.fontWeight),
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
                    if (_playlistController.playlists
                        .map((playlist) => playlist.playlistName)
                        .contains(_playlistNameController.text)) {
                      //  playlist already exists
                      showToast(toast: toast, iconData: Icons.error, msg: "Playlist Already exists.");
                    } else {
                      //  add playlist to database
                      _playlistController.addPlaylist(
                          playlist: Playlist(
                              playlistName: _playlistNameController.text));

                      Navigator.of(context).pop();

                      showSnackbar(
                          title: "${_playlistNameController.text} Created",
                          message: "Playlist created successfully!",
                          iconData: Icons.playlist_add_check_rounded);
                    }
                  },
                  child: Text("Save"))
            ],
          )
        ],
      ),
    );
  }
}
