import 'package:flow/di/locator.dart';
import 'package:flow/core/domain/repository/home_repository.dart';

class PauseSongUseCase {

  final repo = locator.get<HomeRepository>();

  Future<void> invoke() async => await repo.pauseSong();
}