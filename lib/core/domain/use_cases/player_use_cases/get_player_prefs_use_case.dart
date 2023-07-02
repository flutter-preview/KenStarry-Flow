import 'package:flow/core/domain/repository/player_repository.dart';
import 'package:flow/di/locator.dart';

import '../../models/player_prefs.dart';

class GetPlayerPrefsUseCase {
  final repo = locator.get<PlayerRepository>();

  Future<PlayerPrefs> call() async => await repo.getPlayerPrefs();
}
