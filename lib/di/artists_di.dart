import 'package:flow/features/feature_artists/data/repository/artists_repository_impl.dart';
import 'package:flow/features/feature_artists/domain/repository/artists_repository.dart';
import 'package:flow/features/feature_artists/domain/use_cases/artists_use_cases.dart';
import 'package:flow/features/feature_artists/domain/use_cases/get_artists.dart';
import 'package:get_it/get_it.dart';

void artistsDI({required GetIt locator}) {
  /// Artists Repository
  locator
      .registerLazySingleton<ArtistsRepository>(() => ArtistsRepositoryImpl());

  /// Artists Use Cases
  locator.registerLazySingleton<ArtistsUseCases>(
      () => ArtistsUseCases(getArtists: GetArtists()));
}
