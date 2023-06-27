import 'package:flow/di/locator.dart';
import 'package:flow/core/domain/repository/player_repository.dart';

class CheckPermissionUseCase {
  final repo = locator.get<PlayerRepository>();

  Future<bool> invoke() async {
    return await repo.checkPermission();
  }
}