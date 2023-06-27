import 'package:flow/di/locator.dart';
import 'package:flow/core/domain/repository/player_repository.dart';

class PauseSongUseCase {

  final repo = locator.get<PlayerRepository>();

  Future<void> invoke() async => await repo.pauseSong();
}