import 'package:flow/features/feature_artists/domain/use_cases/artists_use_cases.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:on_audio_query/on_audio_query.dart';

import '../../../../di/locator.dart';

class ArtistsController extends GetxController {

  /// Use Cases
  final artistsUseCases = locator.get<ArtistsUseCases>();

  /// All Artists
  final artists = <ArtistModel>[].obs;

  void setArtists({required List<ArtistModel> artists}) => this.artists.value = artists;

  Future<List<ArtistModel>> getArtists() async => await artistsUseCases.getArtists();
}