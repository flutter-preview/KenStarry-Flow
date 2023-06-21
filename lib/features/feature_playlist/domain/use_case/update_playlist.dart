import 'package:flow/di/locator.dart';
import 'package:flow/features/feature_playlist/domain/repository/playlist_repository.dart';

import '../model/playlist.dart';

class UpdatePlaylist {
  final repository = locator.get<PlaylistRepository>();

  Future<void> call({required int index, required Playlist playlist}) async =>
      await repository.updatePlaylist(index: index, playlist: playlist);
}
