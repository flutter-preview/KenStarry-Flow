import 'package:flow/di/locator.dart';
import 'package:flow/features/feature_artists/domain/repository/artists_repository.dart';
import 'package:on_audio_query/on_audio_query.dart';

class ArtistsRepositoryImpl implements ArtistsRepository {

  final audioQuery = locator.get<OnAudioQuery>();

  /// Get Artists
  @override
  Future<List<ArtistModel>> getArtists() async {
    try {

      var artists = await audioQuery.queryArtists(
        sortType: ArtistSortType.ARTIST,
        orderType: OrderType.ASC_OR_SMALLER,
        uriType: UriType.EXTERNAL,
        ignoreCase: true
      );

      return artists;

    } on Exception catch (e) {
      throw Exception(e);
    }
  }
}