import 'package:flow/core/utils/hive_utils.dart';
import 'package:flow/di/locator.dart';
import 'package:flow/features/feature_playlist/domain/use_case/playlist_use_cases.dart';
import 'package:get_it/get_it.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';

import '../../domain/model/playlist.dart';

class PlaylistController extends GetxController {
  final useCases = locator.get<PlaylistUseCases>();
  final playlistsBox = Hive.box(HiveUtils.playlistBox).listenable().obs;
  final playlists = <Playlist>[].obs;

  final playlistNameInput = ''.obs;

  // Add Playlist
  Future<void> addPlaylist({required Playlist playlist}) async =>
      await useCases.addPlaylist(playlist: playlist);

  // Delete Playlist
  Future<void> deletePlaylist({required int index}) async =>
      await useCases.deletePlaylist(index: index);

  // Update Playlist
  Future<void> updatePlaylist(
          {required int index, required Playlist playlist}) async =>
      await useCases.updatePlaylist(index: index, playlist: playlist);
}
