import 'package:audio_service/audio_service.dart';
import 'package:flow/features/feature_home/domain/use_case/check_permission_use_case.dart';
import 'package:flow/features/feature_home/domain/use_case/get_songs_use_case.dart';
import 'package:flow/features/feature_home/domain/use_case/home_use_cases.dart';
import 'package:flow/features/feature_home/domain/use_case/is_song_playing_use_case.dart';
import 'package:flow/features/feature_home/domain/use_case/observe_song_dur_use_case.dart';
import 'package:flow/features/feature_home/domain/use_case/observe_song_pos_use_case.dart';
import 'package:flow/features/feature_home/domain/use_case/pause_song_use_case.dart';
import 'package:flow/features/feature_home/domain/use_case/play_next_song_use_case.dart';
import 'package:flow/features/feature_home/domain/use_case/play_prev_song_use_case.dart';
import 'package:flow/features/feature_home/domain/use_case/play_song_at_index_use_case.dart';
import 'package:flow/features/feature_home/domain/use_case/play_song_use_case.dart';
import 'package:flow/features/feature_home/domain/use_case/seek_song_use_case.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:just_audio/just_audio.dart';
import 'package:on_audio_query/on_audio_query.dart';

import '../core/data/source/my_audio_handler.dart';
import '../features/feature_home/data/repository/home_repository_impl.dart';
import '../features/feature_home/domain/repository/home_repository.dart';

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
  locator.registerSingleton<HomeRepository>(HomeRepositoryImpl());

  /// Provide Home Use Cases
  locator.registerSingleton<HomeUseCases>(HomeUseCases(
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
