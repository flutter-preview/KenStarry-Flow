import 'package:on_audio_query/on_audio_query.dart';

import '../model/player_states.dart';

abstract class HomeRepository {
  /// Check Storage Permission
  Future<bool> checkPermission();

  /// Get All songs
  Future<List<SongModel>> getAllSongs();

  /// Play Song
  Future<void> playSong({required String path});

  /// Pause Song
  Future<void> pauseSong();

  /// Check if song is playing
  void isSongPlaying({required void Function(PlayerStates) onStateChanged});

  /// Observe Song Duration
  void observeSongDuration({required void Function(Duration dur) onDurationChanged});

  /// Observe Song Position
  void observeSongPosition({required void Function(Duration pos) onPositionChanged});
}
