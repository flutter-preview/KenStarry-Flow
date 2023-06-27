import 'package:flow/di/locator.dart';
import 'package:flow/core/domain/repository/player_repository.dart';

class PlaySongAtIndexUseCase {

  final repository = locator.get<PlayerRepository>();

  Future<void> invoke({required int index}) async => repository.playSongAtIndex(index: index);
}