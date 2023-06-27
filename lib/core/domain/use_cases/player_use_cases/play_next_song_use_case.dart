import 'package:flow/di/locator.dart';
import 'package:flow/core/domain/repository/player_repository.dart';

import '../../models/repeat_state.dart';

class PlayNextSongUseCase {
  final repo = locator.get<PlayerRepository>();

  Future<void> invoke({required RepeatState currentRepeatState}) async =>
      await repo.playNextSong(currentRepeatState: currentRepeatState);
}
