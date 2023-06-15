import 'package:get_it/get_it.dart';
import 'package:just_audio/just_audio.dart';
import 'package:on_audio_query/on_audio_query.dart';

var locator = GetIt.instance;

void invokeDI() {

  /// Initialize Audio Player
  locator.registerLazySingleton<AudioPlayer>(() => AudioPlayer());

  /// Initialize Audio Query
  locator.registerLazySingleton<OnAudioQuery>(() => OnAudioQuery());
}