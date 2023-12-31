import 'package:flow/core/utils/hive_utils.dart';
import 'package:flow/features/feature_playlist/domain/repository/playlist_repository.dart';
import 'package:hive/hive.dart';

import '../../domain/model/playlist.dart';

class PlaylistRepositoryImpl implements PlaylistRepository {
  final playlistBox = Hive.box(HiveUtils.playlistBox);

  @override
  Future<void> addPlaylist({required Playlist playlist}) async {
    var newPlaylist = Playlist(
      playlistName: playlist.playlistName ?? '',
      playlistImageUri: playlist.playlistImageUri ?? '',
      playlistCreatedDate: playlist.playlistCreatedDate ?? DateTime.now(),
      playlistSongIds: playlist.playlistSongIds ?? []
    );
    await playlistBox.add(newPlaylist);
  }

  @override
  Future<void> deletePlaylist({required int index}) async {
    await playlistBox.deleteAt(index);
  }

  @override
  Future<void> updatePlaylist(
      {required int index, required Playlist playlist}) async {
    //  get current playlist data
    var currentPlaylist = playlistBox.getAt(index) as Playlist;
    var updatedPlaylist = Playlist(
        playlistName: playlist.playlistName ?? currentPlaylist.playlistName,
        playlistImageUri:
            playlist.playlistImageUri ?? currentPlaylist.playlistImageUri,
        playlistCreatedDate:
            playlist.playlistCreatedDate ?? currentPlaylist.playlistCreatedDate,
        playlistSongIds:
            playlist.playlistSongIds ?? currentPlaylist.playlistSongIds);

    await playlistBox.putAt(index, updatedPlaylist);
  }

  @override
  Future<Playlist> getPlaylist({required int index}) async {
    return await playlistBox.getAt(index) as Playlist;
  }
}
