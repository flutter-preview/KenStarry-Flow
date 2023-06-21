import 'package:flow/features/feature_playlist/domain/use_case/add_playlist.dart';
import 'package:flow/features/feature_playlist/domain/use_case/delete_playlist.dart';
import 'package:flow/features/feature_playlist/domain/use_case/update_playlist.dart';

class PlaylistUseCases {
  final AddPlaylist addPlaylist;
  final DeletePlaylist deletePlaylist;
  final UpdatePlaylist updatePlaylist;

  PlaylistUseCases(
      {required this.addPlaylist,
      required this.deletePlaylist,
      required this.updatePlaylist});
}
