import 'package:flutter/material.dart';
import 'package:on_audio_query/on_audio_query.dart';

abstract class HomeRepository {

  /// Check Storage Permission
  Future<void> checkPermission();

  /// Get All songs
  Future<List<SongModel>> getAllSongs();

  /// Play Song
  Future<void> playSong();
}