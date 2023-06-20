import 'package:flow/core/utils/hive_utils.dart';
import 'package:flow/features/feature_playlist/domain/repository/playlist_repository.dart';
import 'package:hive/hive.dart';

class PlaylistRepositoryImpl implements PlaylistRepository {

  final playlistBox = Hive.box(HiveUtils.playlistBox);

  @override
  Future<void> addPlaylist() {
    // TODO: implement addPlaylist
    throw UnimplementedError();
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