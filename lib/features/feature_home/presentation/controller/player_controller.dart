import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:just_audio/just_audio.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:permission_handler/permission_handler.dart';

class PlayerController extends GetxController {
  final audioQuery = OnAudioQuery();
  final audioPlayer = AudioPlayer();

  final isPermissionGranted = false.obs;
  final totalSongs = 0.obs;

  Future<void> playSong({required String path}) async {
    try {
      audioPlayer.setAudioSource(AudioSource.uri(Uri.parse(path)));
      audioPlayer.play();

    } on Exception catch (exception) {
      throw Exception(exception);
    }
  }

  Future<List<SongModel>> getSongs() async {
    var songs = await audioQuery.querySongs(
        ignoreCase: true,
        orderType: OrderType.ASC_OR_SMALLER,
        sortType: null,
        uriType: UriType.EXTERNAL);

    totalSongs.value = songs.length;
    return songs;
  }

  Future<void> checkPermission() async {
    //  request access to storage
    var storagePermission = await Permission.storage.request();

    if (storagePermission.isGranted) {
      isPermissionGranted.value = true;
    } else {
      checkPermission();
      isPermissionGranted.value = false;
    }
  }
}
