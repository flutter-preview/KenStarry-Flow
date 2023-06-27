import 'package:audio_service/audio_service.dart';
import 'package:flow/core/domain/repository/player_repository.dart';

import '../../../../di/locator.dart';

class PlaySongUseCase {
  final repo = locator.get<PlayerRepository>();

  Future<void> invoke() async =>
      await repo.playSong();
}
