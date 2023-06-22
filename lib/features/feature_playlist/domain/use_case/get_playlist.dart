import 'package:flow/di/locator.dart';
import 'package:flow/features/feature_playlist/domain/repository/playlist_repository.dart';

import '../model/playlist.dart';

class GetPlaylist {
  final repository = locator.get<PlaylistRepository>();

  Future<Playlist> call({required int index}) =>
      repository.getPlaylist(index: index);
}
