import 'package:audio_service/audio_service.dart';
import 'package:flow/features/feature_home/domain/model/player_states.dart';
import 'package:flow/core/domain/repository/home_repository.dart';
import 'package:just_audio/just_audio.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:on_audio_query_platform_interface/src/models/song_model.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../../di/locator.dart';

class HomeRepositoryImpl implements HomeRepository {
  final audioQuery = locator.get<OnAudioQuery>();
  final audioPlayer = locator.get<AudioPlayer>();
  final audioHandler = locator.get<AudioHandler>();

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
          sortType: SongSortType.DISPLAY_NAME);

      return songs;
    } on Exception catch (error) {
      throw Exception(error);
    }
  }

  @override
  Future<void> playSong() async {
    try {
      await audioHandler.play();
    } on Exception catch (error) {
      throw Exception(error);
    }
  }

  @override
  Future<void> playSongAtIndex({required int index}) async {
    try {
      await audioHandler.skipToQueueItem(index);
    } on Exception catch (error) {
      throw Exception(error);
    }
  }

  @override
  Future<void> pauseSong() async {
    try {
      await audioHandler.pause();
    } on Exception catch (error) {
      throw Exception(error);
    }
  }

  @override
  Future<void> playNextSong() async {
    try {
      await audioHandler.skipToNext();
    } on Exception catch (error) {
      throw Exception(error);
    }
  }

  @override
  Future<void> playPrevSong() async {
    try {
      await audioHandler.skipToPrevious();
    } on Exception catch (error) {
      throw Exception(error);
    }
  }

  @override
  void seekSong({required int seconds}) {
    var duration = Duration(seconds: seconds);
    audioHandler.seek(duration);
  }

  @override
  void isSongPlaying({required void Function(PlayerStates) onStateChanged}) {
    try {
      audioHandler.playbackState.listen((state) {
        if (state.playing) {
          onStateChanged(PlayerStates.playing);
        } else {
          onStateChanged(PlayerStates.stopped);
        }
      });
    } on Exception catch (error) {
      throw Exception(error);
    }
  }

  @override
  void observeSongDuration(
      {required void Function(Duration dur) onDurationChanged}) {
    try {
      audioPlayer.durationStream.listen((d) => onDurationChanged(d!));
    } on Exception catch (error) {
      throw Exception(error);
    }
  }

  @override
  void observeSongPosition(
      {required void Function(Duration pos) onPositionChanged}) {
    try {
      audioPlayer.positionStream.listen((p) => onPositionChanged(p));
    } on Exception catch (error) {
      throw Exception(error);
    }
  }
}
