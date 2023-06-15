import 'package:flow/features/feature_home/domain/use_case/home_use_cases.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:just_audio/just_audio.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../../../di/locator.dart';

class PlayerController extends GetxController {
  final homeUseCases = locator.get<HomeUseCases>();

  final isPermissionGranted = false.obs;
  final songs = List<SongModel>.empty(growable: true).obs;
  final totalSongs = 0.obs;

  /// UI
  final songCardScale = 1.0.obs;

  /// Index of the currently playing song
  final Rx<int?> currentPlayingSongIndex = 0.obs;
  final isPlaying = false.obs;

  void scaleDown({double scale = 0.5}) => songCardScale.value = scale;

  Future<void> playSong({required String path, required int index}) async {

    await homeUseCases.playSongUseCase.invoke(path: path);
    isPlaying.value = true;
    currentPlayingSongIndex.value = index;
    scaleDown(scale: 0.9);
  }

  Future<List<SongModel>> getSongs() async {
    var songs = await homeUseCases.getSongsUseCase.invoke();

    this.songs.value = songs;
    totalSongs.value = songs.length;
    return songs;
  }

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
