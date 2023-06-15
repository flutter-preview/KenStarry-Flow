import 'package:flutter/material.dart';
import 'package:on_audio_query/on_audio_query.dart';

abstract class HomeRepository {

  /// Check Storage Permission
  Future<bool> checkPermission();

  /// Get All songs
  Future<List<SongModel>> getAllSongs();

  /// Play Song
  Future<void> playSong({required String path});

  /// Pause Song
  Future<void> pauseSong();
}