import 'package:flow/di/locator.dart';

import '../../models/repeat_state.dart';
import '../../repository/player_repository.dart';

class RepeatUseCase {
  final repo = locator.get<PlayerRepository>();

  void invoke({required RepeatState repeatState}) =>
      repo.repeat(repeatState: repeatState);
}
