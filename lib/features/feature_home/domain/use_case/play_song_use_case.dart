import 'package:audio_service/audio_service.dart';
import 'package:flow/core/domain/repository/home_repository.dart';

import '../../../../di/locator.dart';

class PlaySongUseCase {
  final repo = locator.get<HomeRepository>();

  Future<void> invoke() async =>
      await repo.playSong();
}
