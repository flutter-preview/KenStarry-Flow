import 'package:flow/di/locator.dart';
import 'package:flow/core/domain/repository/player_repository.dart';

class PauseSongUseCase {

  final repository = locator.get<PlayerRepository>();

  Future<void> call() async => await repository.pauseSong();
}