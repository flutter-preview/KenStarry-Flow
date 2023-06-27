import 'package:audio_service/audio_service.dart';
import 'package:on_audio_query/on_audio_query.dart';

import '../../../features/feature_home/domain/model/player_states.dart';

abstract class PlayerRepository {
  /// Check Storage Permission
  Future<bool> checkPermission();

  /// Get All songs
  Future<List<SongModel>> getAllSongs();

  /// Play Song
  Future<void> playSong();

  Future<void> playSongAtIndex({required int index});

  /// Pause Song
  Future<void> pauseSong();

  /// Next Song
  Future<void> playNextSong();

  /// Prev Song
  Future<void> playPrevSong();

  /// Seek song using slider
  void seekSong({required int seconds});

  /// Check if song is playing
  void isSongPlaying({required void Function(PlayerStates) onStateChanged});

  /// Observe Song Duration
  void observeSongDuration({required void Function(Duration dur) onDurationChanged});

  /// Observe Song Position
  void observeSongPosition({required void Function(Duration pos) onPositionChanged});
}
