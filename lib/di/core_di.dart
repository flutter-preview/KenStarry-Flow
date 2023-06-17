import 'package:audio_service/audio_service.dart';
import 'package:flow/core/data/repository/core_repository_impl.dart';
import 'package:flow/core/domain/repository/core_repository.dart';
import 'package:get_it/get_it.dart';

import '../core/data/source/my_audio_handler.dart';

Future<void> coreDI({required GetIt locator}) async {
  /// Registering our audio handler
  locator.registerSingleton<AudioHandler>(await AudioService.init(
      builder: () => MyAudioHandler(),
      config: const AudioServiceConfig(
          androidNotificationChannelId: 'com.kenstarry.flow.audio',
          androidNotificationChannelName: 'Flow Audio Service',
          androidNotificationOngoing: true,
          androidStopForegroundOnPause: true)));

  /// Registering our repository
  locator.registerLazySingleton<CoreRepository>(() => CoreRepositoryImpl());
}
