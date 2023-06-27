import 'package:audio_service/audio_service.dart';
import 'package:flow/core/domain/models/repeat_state.dart';
import 'package:on_audio_query/on_audio_query.dart';

import '../models/player_states.dart';

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
  Future<void> playNextSong({required RepeatState currentRepeatState});

  /// Prev Song
  Future<void> playPrevSong();

  /// Seek song using slider
  void seekSong({required int seconds});

  /// Shuffle Songs
  void shuffle({required bool isShuffleModeEnabled});

  /// Repeat
  void repeat({required RepeatState repeatState});

  /// Check if song is playing
  void isSongPlaying({required void Function(PlayerStates) onStateChanged});

  /// Observe Song Duration
  void observeSongDuration({required void Function(Duration dur) onDurationChanged});

  /// Observe Song Position
  void observeSongPosition({required void Function(Duration pos) onPositionChanged});
}
