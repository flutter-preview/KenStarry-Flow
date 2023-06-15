import 'package:flow/features/feature_home/domain/use_case/check_permission_use_case.dart';
import 'package:flow/features/feature_home/domain/use_case/get_songs_use_case.dart';
import 'package:flow/features/feature_home/domain/use_case/home_use_cases.dart';
import 'package:flow/features/feature_home/domain/use_case/play_song_use_case.dart';
import 'package:get_it/get_it.dart';
import 'package:just_audio/just_audio.dart';
import 'package:on_audio_query/on_audio_query.dart';

import '../features/feature_home/data/repository/home_repository_impl.dart';
import '../features/feature_home/domain/repository/home_repository.dart';

void playerDI({required GetIt locator}) {
  /// Initialize Audio Player
  locator.registerLazySingleton<AudioPlayer>(() => AudioPlayer());

  /// Initialize Audio Query
  locator.registerLazySingleton<OnAudioQuery>(() => OnAudioQuery());

  /// Provide Home Repository
  locator.registerLazySingleton<HomeRepository>(() => HomeRepositoryImpl());

  /// Provide Home Use Cases
  locator.registerLazySingleton<HomeUseCases>(() => HomeUseCases(
      checkPermissionUseCase: CheckPermissionUseCase(),
      getSongsUseCase: GetSongsUseCase(),
      playSongUseCase: PlaySongUseCase()));
}