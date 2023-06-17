import 'package:flow/di/locator.dart';
import 'package:flow/features/feature_home/domain/repository/home_repository.dart';

class PlayNextSongUseCase {
  final repo = locator.get<HomeRepository>();

  Future<void> invoke({required int index}) async => await repo.playNextSong(index: index);
}