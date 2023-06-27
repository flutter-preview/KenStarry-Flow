import 'package:flow/di/locator.dart';
import 'package:flow/features/feature_home/domain/model/player_states.dart';
import 'package:flow/core/domain/repository/player_repository.dart';

class IsSongPlayingUseCase {
  final repo = locator.get<PlayerRepository>();

  void invoke(
          {required void Function(PlayerStates) onStateChanged}) =>
      repo.isSongPlaying(onStateChanged: onStateChanged);
}
