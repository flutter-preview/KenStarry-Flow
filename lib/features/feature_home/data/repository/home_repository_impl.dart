import 'package:flow/features/feature_home/domain/repository/home_repository.dart';
import 'package:just_audio/just_audio.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:on_audio_query_platform_interface/src/models/song_model.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../../../di/locator.dart';

class HomeRepositoryImpl implements HomeRepository {
  final audioQuery = locator.get<OnAudioQuery>();
  final audioPlayer = locator.get<AudioPlayer>();

  @override
  Future<bool> checkPermission() async {
    //  request access to storage
    var storagePermission = await Permission.storage.request();
    return storagePermission.isGranted;
  }

  @override
  Future<List<SongModel>> getAllSongs() async {
    try {
      var songs = await audioQuery.querySongs(
          ignoreCase: true,
          orderType: OrderType.ASC_OR_SMALLER,
          uriType: UriType.EXTERNAL,
          sortType: SongSortType.DISPLAY_NAME
      );

      return songs;
    } on Exception catch (error) {
      throw Exception(error);
    }
  }

  @override
  Future<void> playSong({required String path}) async {
    try {
      //  play song
      await audioPlayer.setAudioSource(AudioSource.uri(Uri.parse(path)));
      audioPlayer.play();

    } on Exception catch (error) {
      throw Exception(error);
    }
  }
}

























