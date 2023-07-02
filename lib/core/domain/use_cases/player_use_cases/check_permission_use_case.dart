import 'package:flow/di/locator.dart';
import 'package:flow/core/domain/repository/player_repository.dart';

class CheckPermissionUseCase {
  final repository = locator.get<PlayerRepository>();

  Future<bool> call() async => await repository.checkPermission();
}