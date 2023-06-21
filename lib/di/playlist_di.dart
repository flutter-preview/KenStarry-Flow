import 'package:flow/features/feature_playlist/data/repository/playlist_repository_impl.dart';
import 'package:flow/features/feature_playlist/domain/repository/playlist_repository.dart';
import 'package:get_it/get_it.dart';

void playlistDI({required GetIt locator}) {

  /// Playlist repository
  locator.registerLazySingleton<PlaylistRepository>(() => PlaylistRepositoryImpl());
}