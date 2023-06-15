import 'package:flow/features/feature_home/domain/repository/home_repository.dart';

import '../../../../di/locator.dart';

class PlaySongUseCase {
  final repo = locator.get<HomeRepository>();

  Future<void> invoke({required String path}) async =>
      await repo.playSong(path: path);
}
