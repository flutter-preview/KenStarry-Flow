import 'package:audio_service/audio_service.dart';
import 'package:flow/core/domain/use_cases/player_use_cases/check_permission_use_case.dart';
import 'package:flow/core/domain/use_cases/player_use_cases/get_songs_use_case.dart';
import 'package:flow/core/domain/use_cases/player_use_cases/player_use_case.dart';
import 'package:flow/core/domain/use_cases/player_use_cases/is_song_playing_use_case.dart';
import 'package:flow/core/domain/use_cases/player_use_cases/observe_song_dur_use_case.dart';
import 'package:flow/core/domain/use_cases/player_use_cases/observe_song_pos_use_case.dart';
import 'package:flow/core/domain/use_cases/player_use_cases/pause_song_use_case.dart';
import 'package:flow/core/domain/use_cases/player_use_cases/play_next_song_use_case.dart';
import 'package:flow/core/domain/use_cases/player_use_cases/play_prev_song_use_case.dart';
import 'package:flow/core/domain/use_cases/player_use_cases/play_song_at_index_use_case.dart';
import 'package:flow/core/domain/use_cases/player_use_cases/play_song_use_case.dart';
import 'package:flow/core/domain/use_cases/player_use_cases/seek_song_use_case.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:just_audio/just_audio.dart';
import 'package:on_audio_query/on_audio_query.dart';

import '../core/data/source/my_audio_handler.dart';
import '../core/data/repository/player_repository_impl.dart';
import '../core/domain/repository/player_repository.dart';

/// ORDER MATTERS!!
Future<void> playerDI({required GetIt locator}) async {
  /// Initialize Audio Player
  locator.registerSingleton<AudioPlayer>(AudioPlayer());

  /// Initialize Audio Query
  locator.registerSingleton<OnAudioQuery>(OnAudioQuery());

  /// Registering our audio handler
  locator.registerSingleton<AudioHandler>(await AudioService.init(
      builder: () => MyAudioHandler(),
      config: const AudioServiceConfig(
          androidNotificationChannelId: 'com.kenstarry.flow.audio',
          androidNotificationChannelName: 'Flow Audio Service',
          androidNotificationClickStartsActivity: true,
          androidNotificationOngoing: true,
          androidStopForegroundOnPause: true)));

  /// Provide Home Repository
  locator.registerSingleton<PlayerRepository>(PlayerRepositoryImpl());

  /// Provide Home Use Cases
  locator.registerSingleton<PlayerUseCases>(PlayerUseCases(
      checkPermissionUseCase: CheckPermissionUseCase(),
      getSongsUseCase: GetSongsUseCase(),
      playSongUseCase: PlaySongUseCase(),
      pauseSongUseCase: PauseSongUseCase(),
      seekSongUseCase: SeekSongUseCase(),
      isSongPlayingUseCase: IsSongPlayingUseCase(),
      observeSongDurUseCase: ObserveSongDurUseCase(),
      observeSongPosUseCase: ObserveSongPosUseCase(),
      playNextSongUseCase: PlayNextSongUseCase(),
      playPrevSongUseCase: PlayPrevSongUseCase(),
      playSongAtIndexUseCase: PlaySongAtIndexUseCase()));
}
