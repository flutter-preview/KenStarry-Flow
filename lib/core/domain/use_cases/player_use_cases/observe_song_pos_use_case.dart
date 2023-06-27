import 'package:flow/di/locator.dart';
import 'package:flow/core/domain/repository/player_repository.dart';

class ObserveSongPosUseCase {
  final repo = locator.get<PlayerRepository>();

  void invoke({required void Function(Duration pos) onPositionChanged}) =>
      repo.observeSongPosition(onPositionChanged: onPositionChanged);
}
