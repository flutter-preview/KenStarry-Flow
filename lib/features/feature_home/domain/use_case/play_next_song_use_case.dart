import 'package:flow/di/locator.dart';
import 'package:flow/core/domain/repository/player_repository.dart';

class PlayNextSongUseCase {
  final repo = locator.get<PlayerRepository>();

  Future<void> invoke() async => await repo.playNextSong();
}