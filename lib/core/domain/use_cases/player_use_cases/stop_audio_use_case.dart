import 'package:flow/core/domain/repository/player_repository.dart';
import 'package:flow/di/locator.dart';

class StopAudioUseCase {
  final repository = locator.get<PlayerRepository>();

  void call() => repository.stopAudio();
}
