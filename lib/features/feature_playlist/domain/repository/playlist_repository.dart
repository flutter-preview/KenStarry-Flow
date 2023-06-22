import 'package:flow/features/feature_playlist/domain/model/playlist.dart';

abstract class PlaylistRepository {

  /// Add Playlist
  Future<void> addPlaylist({required Playlist playlist});
  /// Update Playlist
  Future<void> updatePlaylist({required int index, required Playlist playlist});
  /// Delete Playlist
  Future<void> deletePlaylist({required int index});
  /// Get Playlist at index
  Future<Playlist> getPlaylist({required int index});
}