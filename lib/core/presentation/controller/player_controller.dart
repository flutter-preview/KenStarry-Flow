import 'package:audio_service/audio_service.dart';
import 'package:azlistview/azlistview.dart';
import 'package:flow/core/domain/models/repeat_state.dart';
import 'package:flow/core/domain/models/speed_state.dart';
import 'package:flow/core/domain/models/user.dart';
import 'package:flow/core/presentation/controller/user_controller.dart';
import 'package:flow/core/utils/math_utils.dart';
import 'package:flow/core/utils/songs_to_media_items.dart';
import 'package:flow/features/feature_songs/domain/model/az_item.dart';
import 'package:flow/core/domain/use_cases/player_use_cases/player_use_case.dart';
import 'package:get/get.dart';
import 'package:on_audio_query/on_audio_query.dart';

import '../../../di/locator.dart';
import '../../domain/models/player_prefs.dart';
import '../../domain/models/player_states.dart';
import 'package:collection/collection.dart';


class PlayerController extends GetxController {
  final playerUseCases = locator.get<PlayerUseCases>();
  final _audioHandler = locator.get<AudioHandler>();
  final _userController = Get.find<UserController>();

  final isPermissionGranted = false.obs;

  final RxList<SongModel> songs = <SongModel>[].obs;
  List<ISuspensionBean> azSongs =
      List<ISuspensionBean>.empty(growable: true).obs;

  final totalSongs = 0.obs;
  final totalSongsDuration = ''.obs;

  List<MediaItem> mediaItemsInitial = <MediaItem>[].obs;
  List<MediaItem> mediaItemsDynamic = <MediaItem>[].obs;

  // UI
  final duration = ''.obs;
  final position = ''.obs;
  final progressDuration = Duration.zero.obs;
  final progressElapsed = Duration.zero.obs;
  final maxSlider = 0.0.obs;
  final sliderValue = 0.0.obs;

  // Index of the currently playing song
  final Rx<int?> currentPlayingSongIndex = 0.obs;
  final Rx<int?> currentPlayingSongIndexDynamic = 0.obs;
  final playerState = PlayerStates.stopped.obs;
  final repeatButtonState = RepeatState.off.obs;
  final speedState = SpeedState.one.obs;
  final isShuffleModeEnabled = false.obs;

  @override
  void onInit() {
    super.onInit();
    _listenToChangesInPlaylist();
    _listenToPlaybackState();
    _listenToChangesInSong();
    _listenToCurrentPosition();
    _listenToTotalDuration();
  }

  /// Listen To Playlist changed from audio handler
  void _listenToChangesInPlaylist() {
    _audioHandler.queue.listen((playlist) {
      if (playlist.isEmpty) return;
      // songs.value = playlist.map((item) => SongModel()).toList();
      mediaItemsDynamic = playlist;
    });
  }

  /// Listen to Playback states
  void _listenToPlaybackState() {
    _audioHandler.playbackState.listen((playbackState) {
      final isPlaying = playbackState.playing;
      final processingState = playbackState.processingState;

      if (processingState == AudioProcessingState.loading ||
          processingState == AudioProcessingState.buffering) {
        playerState.value = PlayerStates.paused;
      } else if (!isPlaying) {
        playerState.value = PlayerStates.paused;
      } else if (processingState != AudioProcessingState.completed) {
        playerState.value = PlayerStates.paused;
      } else {
        _audioHandler.seek(Duration.zero);
        _audioHandler.pause();
      }
    });
  }

  /// Listen to Currently Playing Media Item from Audio Handler
  void _listenToChangesInSong() {
    _audioHandler.mediaItem.listen((mediaItem) {
      currentPlayingSongIndex.value = mediaItemsInitial.indexOf(mediaItem!);
      currentPlayingSongIndexDynamic.value =
          mediaItemsDynamic.indexOf(mediaItem);
    });
  }

  /// Listen to song position
  void _listenToCurrentPosition() {
    AudioService.position.listen((pos) {
      position.value = pos.toString().split(".")[0];
      sliderValue.value = pos.inSeconds.toDouble();
      progressElapsed.value = pos;
    });
  }

  /// Listen to song duration
  void _listenToTotalDuration() {
    _audioHandler.mediaItem.listen((mediaItem) {
      duration.value = mediaItem?.duration.toString().split(".")[0] ??
          Duration.zero.toString().split(".")[0];
      maxSlider.value = mediaItem?.duration?.inSeconds.toDouble() ??
          Duration.zero.inSeconds.toDouble();

      progressDuration.value = mediaItem?.duration ?? Duration.zero;
    });
  }

  /// Shuffle Songs
  void shuffleSongs() {
    final enable = !isShuffleModeEnabled.value;
    //  change shuffle mode
    isShuffleModeEnabled.value = enable;

    playerUseCases.shuffleUseCase.invoke(isShuffleModeEnabled: enable);
  }

  Future<void> disableShuffle() async {
    isShuffleModeEnabled.value = false;
    await _audioHandler.setShuffleMode(AudioServiceShuffleMode.none);
  }

  /// Repeat Mode
  void repeat() {
    nextRepeatState();
    playerUseCases.repeatUseCase.invoke(repeatState: repeatButtonState.value);
  }

  //  move to the next state
  void nextRepeatState() {
    final next =
        (repeatButtonState.value.index + 1) % RepeatState.values.length;
    repeatButtonState.value = RepeatState.values[next];
  }

  /// Set Speed
  void setSpeed() {
    nextSpeedState();

    var speed = 1.0;

    switch (speedState.value) {
      case SpeedState.one:
        speed = 1.0;
        break;
      case SpeedState.two:
        speed = 2.0;
        break;
      case SpeedState.three:
        speed = 3.0;
        break;
      case SpeedState.five:
        speed = 5.0;
        break;
    }

    playerUseCases.setSpeedUseCase.invoke(speed: speed);
  }

  void nextSpeedState() {
    final next = (speedState.value.index + 1) % SpeedState.values.length;
    speedState.value = SpeedState.values[next];
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

    mediaItemsInitial = songsToMediaItems(songs: songs);
    mediaItemsDynamic = songsToMediaItems(songs: songs);

    //  Add media to audio handler
    addPlaylistSongsToQueue(mediaItems: mediaItemsDynamic, songIndex: 0);
  }

  /// Add Playlist Songs to Queue
  void addPlaylistSongsToQueue(
      {required List<MediaItem> mediaItems, required int songIndex}) {
    final equal = const ListEquality().equals;

    //  check if the current queue already contains these songs
    if (!equal(_audioHandler.queue.value, mediaItems)) {
      replaceItemsInQueue(mediaItems: mediaItems, index: songIndex);
    } else {
      //  set UI current media item index
      currentPlayingSongIndexDynamic.value = songIndex;
      //  set audio handlers current media item index
      _audioHandler.customAction('setMediaItemIndex', {'index': songIndex});
    }
  }

  /// Add Songs To Queue
  void replaceItemsInQueue(
      {required List<MediaItem> mediaItems, required int index}) async {
    await clearQueue().whenComplete(
        () => _audioHandler.addQueueItems(mediaItems).whenComplete(() {
              currentPlayingSongIndexDynamic.value = index;
              //  set audio handlers current media item index
              _audioHandler.customAction('setMediaItemIndex', {'index': index});
            }));
  }

  /// Clear Queue
  Future<void> clearQueue() async => await playerUseCases.clearQueueUseCase();

  ///  Play Song
  Future<void> playSong({int? index}) async =>
      await playerUseCases.playSongUseCase();

  /// Play Song At Index
  Future<void> playSongAtIndex({required int index}) async =>
      await playerUseCases.playSongAtIndexUseCase.invoke(index: index);

  Future<void> jumpToSongAtIndex({required int index}) async {
    _audioHandler.customAction('jumpToQueueItem', {'index': index});
  }

  /// Pause Song
  Future<void> pauseSong() async => await playerUseCases.pauseSongUseCase();

  /// Next Song
  Future<void> playNextSong({int? index}) async =>
      await playerUseCases.playNextSongUseCase
          .invoke(currentRepeatState: repeatButtonState.value);

  /// Prev Song
  Future<void> playPrevSong({int? index}) async =>
      await playerUseCases.playPrevSongUseCase
          .invoke(currentRepeatState: repeatButtonState.value);

  /// Seek Song
  void seekSong({required int seconds}) =>
      playerUseCases.seekSongUseCase.invoke(seconds: seconds);

  /// Get Songs
  Future<List<SongModel>> getSongs() async {
    var songs = await playerUseCases.getSongsUseCase();
    this.songs.value = songs;
    totalSongs.value = songs.length;
    return songs;
  }

  /// Check if song is playing
  void isSongPlaying() => playerUseCases.isSongPlayingUseCase
      .invoke(onStateChanged: (state) => playerState.value = state);

  /// Disposing our Audio Player
  void disposeAudio() => playerUseCases.disposeAudioUseCase();

  /// Stopping our Audio Player
  void stopAudio() => playerUseCases.stopAudioUseCase();

  Future<void> addPlayerPrefs({required PlayerPrefs playerPrefs}) async {
    await playerUseCases.addPlayerPrefsUseCase.invoke(playerPrefs: playerPrefs);
  }

  Future<void> deletePlayerPrefs() async =>
      await playerUseCases.deletePlayerPrefsUseCase();

  Future<PlayerPrefs> getPlayerPrefs() async =>
      await playerUseCases.getPlayerPrefsUseCase();

  Future<void> updatePlayerPrefs({required PlayerPrefs playerPrefs}) async {
    await playerUseCases.updatePlayerPrefsUseCase
        .invoke(playerPrefs: playerPrefs);
  }

  /// Check Storage Permission
  Future<void> checkPermission() async {
    //  request access to storage
    var isStorageGranted = await playerUseCases.checkPermissionUseCase();

    if (isStorageGranted) {
      //  save the value to the database
      _userController.updateUserPrefs(user: User(hasGrantedPermission: true));
    } else {
      isPermissionGranted.value = false;
    }
  }
}
