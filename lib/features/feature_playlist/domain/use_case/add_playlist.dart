import 'package:flow/di/locator.dart';
import 'package:flow/features/feature_playlist/domain/repository/playlist_repository.dart';
import 'package:get_it/get_it.dart';

class AddPlaylist {
  final repository = locator.get<PlaylistRepository>();
}