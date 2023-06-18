import 'package:on_audio_query/on_audio_query.dart';

abstract class ArtistsRepository {

  /// All Artists
  Future<List<ArtistModel>> getArtists();
}