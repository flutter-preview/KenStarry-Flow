import 'package:flow/di/locator.dart';
import 'package:flow/core/domain/repository/player_repository.dart';

class ObserveSongDurUseCase {
  final repo = locator.get<PlayerRepository>();

  void invoke({required void Function(Duration dur) onDurationChanged}) =>
      repo.observeSongDuration(onDurationChanged: onDurationChanged);
}
