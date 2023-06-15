import 'package:flow/features/feature_home/domain/use_case/check_permission_use_case.dart';
import 'package:flow/features/feature_home/domain/use_case/get_songs_use_case.dart';
import 'package:flow/features/feature_home/domain/use_case/pause_song_use_case.dart';
import 'package:flow/features/feature_home/domain/use_case/play_song_use_case.dart';

import 'is_song_playing_use_case.dart';
import 'observe_song_dur_use_case.dart';
import 'observe_song_pos_use_case.dart';

class HomeUseCases {
  final CheckPermissionUseCase checkPermissionUseCase;
  final GetSongsUseCase getSongsUseCase;
  final PlaySongUseCase playSongUseCase;
  final PauseSongUseCase pauseSongUseCase;
  final IsSongPlayingUseCase isSongPlayingUseCase;
  final ObserveSongDurUseCase observeSongDurUseCase;
  final ObserveSongPosUseCase observeSongPosUseCase;

  HomeUseCases(
      {required this.checkPermissionUseCase,
      required this.getSongsUseCase,
      required this.playSongUseCase,
      required this.pauseSongUseCase,
      required this.isSongPlayingUseCase,
      required this.observeSongDurUseCase,
      required this.observeSongPosUseCase});
}
