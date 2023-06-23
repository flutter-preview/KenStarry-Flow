import 'package:audio_service/audio_service.dart';
import 'package:azlistview/azlistview.dart';
import 'package:flow/core/data/source/my_audio_handler.dart';
import 'package:flow/core/domain/models/user.dart';
import 'package:flow/core/presentation/controller/hive_controller.dart';
import 'package:flow/core/utils/math_utils.dart';
import 'package:flow/core/utils/string_extensions.dart';
import 'package:flow/features/feature_home/domain/model/az_item.dart';
import 'package:flow/features/feature_home/domain/use_case/home_use_cases.dart';
import 'package:get/get.dart';
import 'package:on_audio_query/on_audio_query.dart';

import '../../../di/locator.dart';
import '../../../features/feature_home/domain/model/player_states.dart';

class PlayerController extends GetxController {
  final homeUseCases = locator.get<HomeUseCases>();
  final _audioHandler = locator.get<AudioHandler>();
  final _hive_controller = Get.find<HiveController>();

  final isPermissionGranted = false.obs;
  final RxList<SongModel> songs = <SongModel>[].obs;
  List<ISuspensionBean> azSongs =
      List<ISuspensionBean>.empty(growable: true).obs;
  final totalSongs = 0.obs;
  final totalSongsDuration = ''.obs;

  late List<MediaItem> mediaItems;

  // UI
  final duration = ''.obs;
  final position = ''.obs;
  final maxSlider = 0.0.obs;
  final sliderValue = 0.0.obs;

  // Index of the currently playing song
  final Rx<int?> currentPlayingSongIndex = 0.obs;
  final playerState = PlayerStates.stopped.obs;

  @override
  void onInit() {
    super.onInit();
    _listenToChangesInPlaylist();
  }

  /// Listen To Playlist changed from audio handler
  void _listenToChangesInPlaylist() {
    _audioHandler.queue.listen((playlist) {
      if (playlist.isEmpty) return;
      // songs.value = playlist.map((item) => SongModel()).toList();
      print(playlist.toString());
    });
  }

  void setTotalSongsDuration({required List<SongModel> songs}) {
    var durations = songs.map((song) => song.duration);
    var totalDuration =
        durations.reduce((dur, element) => dur! + element!.toInt())!;

    totalSongsDuration.value =
        MathUtils.printToMinutesSeconds(Duration(milliseconds: totalDuration));
  }

  /// Listen to total duration from audio handler
  void initializeSongs({required List<SongModel> songs}) {
    this.songs.value = songs;

    azSongs = songs
        .map((s) => AZItem(
            title: s.displayNameWOExt,
            tag: s.displayNameWOExt[0].toUpperCase()))
        .toList();

    mediaItems = songs
        .map((song) => MediaItem(
            id: song.id.toString(),
            title: song.displayNameWOExt,
            artist: song.artist,
            duration: Duration(milliseconds: song.duration!),
            extras: {'url': song.uri}))
        .toList();

    //  Add media to audio handler
    _audioHandler.addQueueItems(mediaItems);
  }

  Future<void> setCurrentSong({required SongModel song}) async {
    //  remove currently playing song
    _audioHandler.removeQueueItemAt(0);

    var mediaItem = MediaItem(
        id: song.id.toString(),
        title: song.displayNameWOExt,
        artist: song.artist,
        duration: Duration(milliseconds: song.duration!),
        extras: {'url': song.uri});

    _audioHandler.addQueueItem(mediaItem);
    _audioHandler.play();
  }

  ///  Play Song
  Future<void> playSong({required String path, required int index}) async {
    currentPlayingSongIndex.value = index;
    observeSongDuration();
    observeSongPosition();
    await homeUseCases.playSongUseCase
        .invoke(mediaItems: mediaItems, index: index);
  }

  /// Pause Song
  Future<void> pauseSong() async {
    await homeUseCases.pauseSongUseCase.invoke();
  }

  /// Next Song
  Future<void> playNextSong({required int index}) async {
    currentPlayingSongIndex.value = index;
    observeSongDuration();
    observeSongPosition();
    await homeUseCases.playNextSongUseCase.invoke(index: index);
  }

  /// Prev Song
  Future<void> playPrevSong({required int index}) async {
    currentPlayingSongIndex.value = index;
    observeSongDuration();
    observeSongPosition();
    await homeUseCases.playPrevSongUseCase.invoke(index: index);
  }

  /// Seek Song
  void seekSong({required int seconds}) {
    homeUseCases.seekSongUseCase.invoke(seconds: seconds);
  }

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
  void observeSongDuration() {
    homeUseCases.observeSongDurUseCase.invoke(onDurationChanged: (dur) {
      duration.value = dur.toString().split(".")[0];
      maxSlider.value = dur.inSeconds.toDouble();
    });
  }

  /// Observe Song Position
  void observeSongPosition() {
    homeUseCases.observeSongPosUseCase.invoke(onPositionChanged: (pos) {
      position.value = pos.toString().split(".")[0];
      sliderValue.value = pos.inSeconds.toDouble();
    });
  }

  /// Check Storage Permission
  Future<void> checkPermission() async {
    //  request access to storage
    var isStorageGranted = await homeUseCases.checkPermissionUseCase.invoke();

    if (isStorageGranted) {
      //  save the value to the database
      _hive_controller.updateUserPrefs(user: User(hasGrantedPermission: true));
    } else {
      isPermissionGranted.value = false;
    }
  }
}
