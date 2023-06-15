import 'package:flow/features/feature_home/domain/repository/home_repository.dart';
import 'package:just_audio/just_audio.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:on_audio_query_platform_interface/src/models/song_model.dart';

import '../../../../di/locator.dart';

class HomeRepositoryImpl implements HomeRepository {

  final audioQuery = locator.get<OnAudioQuery>();
  final audioPlayer = locator.get<AudioPlayer>();

  @override
  Future<void> checkPermission() async {
    //  request access to storage
  }

  @override
  Future<List<SongModel>> getAllSongs() {
    // TODO: implement getAllSongs
    throw UnimplementedError();
  }

  @override
  Future<void> playSong() {
    // TODO: implement playSong
    throw UnimplementedError();
  }

}