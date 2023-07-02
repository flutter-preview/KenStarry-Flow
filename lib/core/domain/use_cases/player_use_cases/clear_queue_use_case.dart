import 'package:flow/core/domain/repository/player_repository.dart';
import 'package:flow/di/locator.dart';

class ClearQueueUseCase {
  final repository = locator.get<PlayerRepository>();

  Future<void> call() async => await repository.clearQueue();
}
