import 'package:audio_service/audio_service.dart';
import 'package:flow/core/domain/models/player_prefs.dart';
import 'package:flow/core/domain/models/player_states.dart';
import 'package:flow/core/domain/repository/player_repository.dart';
import 'package:flow/core/utils/hive_utils.dart';
import 'package:just_audio/just_audio.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:on_audio_query_platform_interface/src/models/song_model.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../../di/locator.dart';
import '../../domain/models/repeat_state.dart';
import 'package:hive/hive.dart';

class PlayerRepositoryImpl implements PlayerRepository {
  final audioQuery = locator.get<OnAudioQuery>();
  final audioPlayer = locator.get<AudioPlayer>();
  final _audioHandler = locator.get<AudioHandler>();
  final _playerPrefsBox = Hive.box(HiveUtils.playerPrefsBox);

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
      await _audioHandler.play();
    } on Exception catch (error) {
      throw Exception(error);
    }
  }

  @override
  Future<void> playSongAtIndex({required int index}) async {
    try {
      await _audioHandler.skipToQueueItem(index);
    } on Exception catch (error) {
      throw Exception(error);
    }
  }

  @override
  Future<void> pauseSong() async {
    try {
      await _audioHandler.pause();
    } on Exception catch (error) {
      throw Exception(error);
    }
  }

  @override
  Future<void> playNextSong({required RepeatState currentRepeatState}) async {
    try {
      //  turn off repeat
      _audioHandler.setRepeatMode(AudioServiceRepeatMode.none);

      await _audioHandler.skipToNext();

      //  turn on repeat
      switch (currentRepeatState) {
        case RepeatState.off:
          _audioHandler.setRepeatMode(AudioServiceRepeatMode.none);
          break;
        case RepeatState.repeatSong:
          _audioHandler.setRepeatMode(AudioServiceRepeatMode.one);
          break;
        case RepeatState.repeatPlaylist:
          _audioHandler.setRepeatMode(AudioServiceRepeatMode.all);
          break;
      }
    } on Exception catch (error) {
      throw Exception(error);
    }
  }

  @override
  Future<void> playPrevSong({required RepeatState currentRepeatState}) async {
    try {
      //  turn off repeat
      _audioHandler.setRepeatMode(AudioServiceRepeatMode.none);

      await _audioHandler.skipToPrevious();

      //  turn on repeat
      switch (currentRepeatState) {
        case RepeatState.off:
          _audioHandler.setRepeatMode(AudioServiceRepeatMode.none);
          break;
        case RepeatState.repeatSong:
          _audioHandler.setRepeatMode(AudioServiceRepeatMode.one);
          break;
        case RepeatState.repeatPlaylist:
          _audioHandler.setRepeatMode(AudioServiceRepeatMode.all);
          break;
      }
    } on Exception catch (error) {
      throw Exception(error);
    }
  }

  @override
  void seekSong({required int seconds}) {
    var duration = Duration(seconds: seconds);
    _audioHandler.seek(duration);
  }

  @override
  void shuffle({required bool isShuffleModeEnabled}) {
    isShuffleModeEnabled
        ? _audioHandler.setShuffleMode(AudioServiceShuffleMode.all)
        : _audioHandler.setShuffleMode(AudioServiceShuffleMode.none);
  }

  @override
  void repeat({required RepeatState repeatState}) {
    switch (repeatState) {
      case RepeatState.off:
        _audioHandler.setRepeatMode(AudioServiceRepeatMode.none);
        break;
      case RepeatState.repeatSong:
        _audioHandler.setRepeatMode(AudioServiceRepeatMode.one);
        break;
      case RepeatState.repeatPlaylist:
        _audioHandler.setRepeatMode(AudioServiceRepeatMode.all);
        break;
    }
  }

  @override
  void setSpeed({required double speed}) {
    _audioHandler.setSpeed(speed);
  }

  @override
  Future<void> clearQueue() async =>
      await _audioHandler.customAction('clearQueue');

  @override
  void disposeAudio() => _audioHandler.customAction('dispose');

  @override
  void stopAudio() => _audioHandler.stop();

  @override
  void isSongPlaying({required void Function(PlayerStates) onStateChanged}) {
    try {
      _audioHandler.playbackState.listen((state) {
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

  @override
  Future<void> addPlayerPrefs({required PlayerPrefs playerPrefs}) async {
    await _playerPrefsBox.put('playerPrefs', playerPrefs);
  }

  @override
  Future<void> deletePlayerPrefs() async {
    await _playerPrefsBox.delete('playerPrefs');
  }

  @override
  Future<PlayerPrefs> getPlayerPrefs() async {
    return await _playerPrefsBox.get('playerPrefs');
  }

  @override
  Future<void> updatePlayerPrefs({required PlayerPrefs? playerPrefs}) async {
    var oldPrefs = await _playerPrefsBox.get('playerPrefs') as PlayerPrefs?;
    var newPrefs = PlayerPrefs(
        currentSongIndex:
            playerPrefs?.currentSongIndex ?? oldPrefs?.currentSongIndex);

    await _playerPrefsBox.put('playerPrefs', newPrefs);
  }
}
