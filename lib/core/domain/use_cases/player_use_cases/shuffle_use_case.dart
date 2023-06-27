import 'package:flow/di/locator.dart';

import '../../repository/player_repository.dart';

class ShuffleUseCase {
  final repo = locator.get<PlayerRepository>();

  void invoke({required bool isShuffleModeEnabled}) =>
      repo.shuffle(isShuffleModeEnabled: isShuffleModeEnabled);
}
