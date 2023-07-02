import 'package:flow/core/domain/repository/player_repository.dart';
import 'package:flow/di/locator.dart';

import '../../models/player_prefs.dart';

class DeletePlayerPrefsUseCase {

  final repo = locator.get<PlayerRepository>();

  Future<void> invoke() async => await repo.deletePlayerPrefs();
}