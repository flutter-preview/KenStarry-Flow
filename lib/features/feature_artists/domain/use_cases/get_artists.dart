import 'package:flow/di/locator.dart';
import 'package:flow/features/feature_artists/domain/repository/artists_repository.dart';
import 'package:on_audio_query/on_audio_query.dart';

class GetArtists {

  final repository = locator.get<ArtistsRepository>();

  Future<List<ArtistModel>> call() async => repository.getArtists();
}