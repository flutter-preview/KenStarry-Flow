import 'package:flow/core/utils/hive_utils.dart';
import 'package:flow/features/feature_playlist/domain/repository/playlist_repository.dart';
import 'package:hive/hive.dart';

import '../../domain/model/playlist.dart';

class PlaylistRepositoryImpl implements PlaylistRepository {

  final playlistBox = Hive.box(HiveUtils.playlistBox);

  @override
  Future<void> addPlaylist({required Playlist playlist}) async {
    // await playlistBox.add();
  }

  @override
  Future<void> deletePlaylist() {
    // TODO: implement deletePlaylist
    throw UnimplementedError();
  }

  @override
  Future<void> updatePlaylist() {
    // TODO: implement updatePlaylist
    throw UnimplementedError();
  }


}