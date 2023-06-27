import 'package:flow/di/locator.dart';
import 'package:flow/core/domain/repository/home_repository.dart';

class CheckPermissionUseCase {
  final repo = locator.get<HomeRepository>();

  Future<bool> invoke() async {
    return await repo.checkPermission();
  }
}