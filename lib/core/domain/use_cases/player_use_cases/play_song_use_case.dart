import 'package:audio_service/audio_service.dart';
import 'package:flow/core/domain/repository/player_repository.dart';

import '../../../../di/locator.dart';

class PlaySongUseCase {
  final repository = locator.get<PlayerRepository>();

  Future<void> call() async => await repository.playSong();
}
