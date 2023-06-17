import 'package:audio_service/audio_service.dart';
import 'package:flow/di/locator.dart';
import 'package:just_audio/just_audio.dart';
import 'package:on_audio_query/on_audio_query.dart';

import '../../../features/feature_home/domain/use_case/home_use_cases.dart';

class MyAudioHandler extends BaseAudioHandler {
  final _player = locator.get<AudioPlayer>();

  List<MediaItem> songsMediaItems = [];
  final _playlist = ConcatenatingAudioSource(children: []);

  MyAudioHandler() {
    // _notifyAudioHandlerAboutPlaybackEvents();
    _player.playbackEventStream.map(_transformEvent).pipe(playbackState);
  }

  @override
  Future<void> playMediaItem(MediaItem mediaItem) async {
    this.mediaItem.add(mediaItem);
    _player.setAudioSource(_createAudioSource(mediaItem));
    _player.play();
  }

  /// Play
  @override
  Future<void> play() async => await _player.play();

  /// Pause
  @override
  Future<void> pause() async => await _player.pause();

  /// Seek
  @override
  Future<void> seek(Duration position) async => await _player.seek(position);

  /// Next
  @override
  Future<void> skipToNext() async => await _player.seekToNext();

  /// Previous
  @override
  Future<void> skipToPrevious() async => await _player.seekToPrevious();


  @override
  Future<void> skipToQueueItem(int index) async {
    await _player.setAudioSource(_playlist[index]);
  }

  /// Queue Playback
  @override
  Future<void> addQueueItems(List<MediaItem> mediaItems) async {
    songsMediaItems = mediaItems;
    //  manage Just Audio
    final audioSource = mediaItems.map((song) => _createAudioSource(song));
    _playlist.addAll(audioSource.toList());

    //  notify audio handler
    final newQueue = queue.value..addAll(mediaItems);
    queue.add(newQueue);
  }

  //  creating an audio source
  UriAudioSource _createAudioSource(MediaItem mediaItem) {
    return AudioSource.uri(Uri.parse(mediaItem.extras!['url'] as String),
        tag: mediaItem);
  }

  PlaybackState _transformEvent(PlaybackEvent event) {
    return PlaybackState(
      controls: [
        MediaControl.rewind,
        _player.playing ? MediaControl.pause : MediaControl.play,
        MediaControl.fastForward,
      ],
      systemActions: const {
        MediaAction.seek,
        MediaAction.seekForward,
        MediaAction.seekBackward,
      },
      androidCompactActionIndices: const [0, 1, 2],
      processingState: const {
        ProcessingState.idle: AudioProcessingState.idle,
        ProcessingState.loading: AudioProcessingState.loading,
        ProcessingState.buffering: AudioProcessingState.buffering,
        ProcessingState.ready: AudioProcessingState.ready,
        ProcessingState.completed: AudioProcessingState.completed,
      }[_player.processingState]!,
      playing: _player.playing,
      updatePosition: _player.position,
      bufferedPosition: _player.bufferedPosition,
      speed: _player.speed,
      queueIndex: event.currentIndex,
    );
  }
}
