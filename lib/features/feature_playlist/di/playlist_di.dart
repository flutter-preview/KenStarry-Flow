import 'package:flow/features/feature_playlist/data/repository/playlist_repository_impl.dart';
import 'package:flow/features/feature_playlist/domain/repository/playlist_repository.dart';
import 'package:flow/features/feature_playlist/domain/use_case/add_playlist.dart';
import 'package:flow/features/feature_playlist/domain/use_case/delete_playlist.dart';
import 'package:flow/features/feature_playlist/domain/use_case/get_playlist.dart';
import 'package:flow/features/feature_playlist/domain/use_case/playlist_use_cases.dart';
import 'package:flow/features/feature_playlist/domain/use_case/update_playlist.dart';
import 'package:get_it/get_it.dart';

void playlistDI({required GetIt locator}) {
  /// Playlist repository
  locator.registerLazySingleton<PlaylistRepository>(
      () => PlaylistRepositoryImpl());

  /// Playlist Use Cases
  locator.registerLazySingleton<PlaylistUseCases>(() => PlaylistUseCases(
      addPlaylist: AddPlaylist(),
      deletePlaylist: DeletePlaylist(),
      updatePlaylist: UpdatePlaylist(),
      getPlaylist: GetPlaylist()));
}
