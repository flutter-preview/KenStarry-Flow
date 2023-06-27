import 'package:flow/core/domain/repository/player_repository.dart';
import 'package:flow/di/locator.dart';

class SetSpeedUseCase {
  final repo = locator.get<PlayerRepository>();

  void invoke({required double speed}) => repo.setSpeed(speed: speed);
}
