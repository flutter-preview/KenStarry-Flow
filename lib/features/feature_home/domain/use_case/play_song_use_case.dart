import 'package:audio_service/audio_service.dart';
import 'package:flow/features/feature_home/domain/repository/home_repository.dart';

import '../../../../di/locator.dart';

class PlaySongUseCase {
  final repo = locator.get<HomeRepository>();

  Future<void> invoke({required List<MediaItem> mediaItems, required int index}) async =>
      await repo.playSong(mediaItems: mediaItems, index: index);
}
