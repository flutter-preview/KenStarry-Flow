import 'package:flow/core/utils/hive_utils.dart';
import 'package:flow/features/feature_playlist/domain/repository/playlist_repository.dart';
import 'package:hive/hive.dart';

import '../../domain/model/playlist.dart';

class PlaylistRepositoryImpl implements PlaylistRepository {
  final playlistBox = Hive.box(HiveUtils.playlistBox);

  @override
  Future<void> addPlaylist({required Playlist playlist}) async {
    await playlistBox.add(playlist);
  }

  @override
  Future<void> deletePlaylist({required int index}) async {
    await playlistBox.deleteAt(index);
  }

  @override
  Future<void> updatePlaylist(
      {required int index, required Playlist playlist}) async {
    await playlistBox.putAt(index, playlist);
  }
}
