import 'package:flow/core/domain/use_cases/player_use_cases/check_permission_use_case.dart';
import 'package:flow/core/domain/use_cases/player_use_cases/get_songs_use_case.dart';
import 'package:flow/core/domain/use_cases/player_use_cases/pause_song_use_case.dart';
import 'package:flow/core/domain/use_cases/player_use_cases/play_next_song_use_case.dart';
import 'package:flow/core/domain/use_cases/player_use_cases/play_prev_song_use_case.dart';
import 'package:flow/core/domain/use_cases/player_use_cases/play_song_at_index_use_case.dart';
import 'package:flow/core/domain/use_cases/player_use_cases/play_song_use_case.dart';
import 'package:flow/core/domain/use_cases/player_use_cases/seek_song_use_case.dart';

import 'is_song_playing_use_case.dart';
import 'observe_song_dur_use_case.dart';
import 'observe_song_pos_use_case.dart';

class HomeUseCases {
  final CheckPermissionUseCase checkPermissionUseCase;
  final GetSongsUseCase getSongsUseCase;
  final PlaySongUseCase playSongUseCase;
  final PauseSongUseCase pauseSongUseCase;
  final SeekSongUseCase seekSongUseCase;
  final IsSongPlayingUseCase isSongPlayingUseCase;
  final ObserveSongDurUseCase observeSongDurUseCase;
  final ObserveSongPosUseCase observeSongPosUseCase;
  final PlayNextSongUseCase playNextSongUseCase;
  final PlayPrevSongUseCase playPrevSongUseCase;
  final PlaySongAtIndexUseCase playSongAtIndexUseCase;

  HomeUseCases(
      {required this.checkPermissionUseCase,
      required this.getSongsUseCase,
      required this.playSongUseCase,
      required this.pauseSongUseCase,
      required this.seekSongUseCase,
      required this.isSongPlayingUseCase,
      required this.observeSongDurUseCase,
      required this.observeSongPosUseCase,
      required this.playNextSongUseCase,
      required this.playPrevSongUseCase,
      required this.playSongAtIndexUseCase});
}
