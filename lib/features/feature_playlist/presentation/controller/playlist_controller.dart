import 'package:flow/core/presentation/controller/player_controller.dart';
import 'package:flow/core/utils/hive_utils.dart';
import 'package:flow/di/locator.dart';
import 'package:flow/features/feature_playlist/domain/use_case/playlist_use_cases.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:on_audio_query/on_audio_query.dart';

import '../../domain/model/playlist.dart';

class PlaylistController extends GetxController {
  final useCases = locator.get<PlaylistUseCases>();
  final playerController = Get.find<PlayerController>();
  final playlistsBox = Hive.box(HiveUtils.playlistBox).listenable().obs;
  final playlists = <Playlist>[].obs;

  //  Playlist Picker Sheet
  final pickedPlaylists = <Playlist>[].obs;

  // VIEW PLAYLIST SCREEN
  final selectedPlaylistIndex = 0.obs;
  final playlistSongs = <SongModel>[].obs;

  final doesPlaylistExist = false.obs;

  void getPlaylistSongs({required Playlist playlist}) {
    var filteredSongs = playerController.songs
        .where((song) => playlist.playlistSongIds!.map((id) => int.parse(id)).contains(song.id)).toList();

    playlistSongs.clear();
    playlistSongs.addAll(filteredSongs);
  }

  void setSelectedPlaylistIndex({required int index}) =>
      selectedPlaylistIndex.value = index;

  void setPlaylistExists({required bool doesPlaylistExist}) => this.doesPlaylistExist.value = doesPlaylistExist;

  void initializePlaylists({required List<Playlist>? playlists}) =>
      this.playlists.value = playlists ?? [];

  //  Playlist picker sheet
  void pickPlaylistToAddSong({required Playlist playlist}) =>
      pickedPlaylists.add(playlist);

  void unPickPlaylistToAddSong({required Playlist playlist}) =>
      pickedPlaylists.remove(playlist);

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

  Future<Playlist> getPlaylist({required int index}) async =>
      await useCases.getPlaylist.call(index: index);
}
