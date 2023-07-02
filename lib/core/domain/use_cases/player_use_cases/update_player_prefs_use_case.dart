import 'package:flow/core/domain/repository/player_repository.dart';
import 'package:flow/di/locator.dart';

import '../../models/player_prefs.dart';

class UpdatePlayerPrefsUseCase {

  final repo = locator.get<PlayerRepository>();

  Future<void> invoke({required PlayerPrefs playerPrefs}) async => await repo.updatePlayerPrefs(playerPrefs: playerPrefs);
}