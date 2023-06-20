import 'package:flow/features/feature_playlist/domain/model/playlist.dart';

abstract class PlaylistRepository {

  /// Add Playlist
  Future<void> addPlaylist({required Playlist playlist});
  /// Update Playlist
  Future<void> updatePlaylist();
  /// Delete Playlist
  Future<void> deletePlaylist();
}