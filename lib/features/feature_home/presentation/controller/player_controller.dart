import 'package:flow/features/feature_home/domain/use_case/home_use_cases.dart';
import 'package:get/get.dart';
import 'package:on_audio_query/on_audio_query.dart';

import '../../../../di/locator.dart';
import '../../domain/model/player_states.dart';

class PlayerController extends GetxController {
  final homeUseCases = locator.get<HomeUseCases>();

  final isPermissionGranted = false.obs;
  final songs = List<SongModel>.empty(growable: true).obs;
  final totalSongs = 0.obs;

  // UI
  final songCardScale = 1.0.obs;
  final duration = ''.obs;
  final position = ''.obs;

  // Index of the currently playing song
  final Rx<int?> currentPlayingSongIndex = 0.obs;
  final playerState = PlayerStates.stopped.obs;

  void scaleDown({double scale = 0.5}) => songCardScale.value = scale;

  ///  Play Song
  Future<void> playSong({required String path, required int index}) async {
    await homeUseCases.playSongUseCase.invoke(path: path);
    currentPlayingSongIndex.value = index;
    scaleDown(scale: 0.9);

    observeSongDuration();
    observeSongPosition();
  }

  /// Pause Song
  Future<void> pauseSong() async =>
      await homeUseCases.pauseSongUseCase.invoke();

  /// Get Songs
  Future<List<SongModel>> getSongs() async {
    var songs = await homeUseCases.getSongsUseCase.invoke();

    this.songs.value = songs;
    totalSongs.value = songs.length;
    return songs;
  }

  /// Check if song is playing
  void isSongPlaying() => homeUseCases.isSongPlayingUseCase
      .invoke(onStateChanged: (state) => playerState.value = state);

  /// Observe Song Duration
  void observeSongDuration() => homeUseCases.observeSongDurUseCase
      .invoke(onDurationChanged: (dur) => duration.value = dur.toString().split(".")[0]);

  /// Observe Song Position
  void observeSongPosition() => homeUseCases.observeSongPosUseCase
      .invoke(onPositionChanged: (pos) => position.value = pos.toString().split(".")[0]);

  /// Check Storage Permission
  Future<void> checkPermission() async {
    //  request access to storage
    var isStorageGranted = await homeUseCases.checkPermissionUseCase.invoke();

    if (isStorageGranted) {
      isPermissionGranted.value = true;
    } else {
      checkPermission();
      isPermissionGranted.value = false;
    }
  }
}
