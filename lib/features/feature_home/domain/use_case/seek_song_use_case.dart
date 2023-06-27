import 'package:flow/di/locator.dart';
import 'package:flow/core/domain/repository/player_repository.dart';

class SeekSongUseCase {

  final repo = locator.get<PlayerRepository>();

  void invoke({required int seconds}) => repo.seekSong(seconds: seconds);
}