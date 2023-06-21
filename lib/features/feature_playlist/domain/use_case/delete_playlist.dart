import 'package:flow/di/locator.dart';
import 'package:flow/features/feature_playlist/domain/repository/playlist_repository.dart';

class DeletePlaylist {
  final repository = locator.get<PlaylistRepository>();

  Future<void> call({required int index}) async =>
      await repository.deletePlaylist(index: index);
}
