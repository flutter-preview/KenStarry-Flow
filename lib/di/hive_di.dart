import 'package:flow/core/data/repository/hive_repository_impl.dart';
import 'package:flow/core/domain/repository/hive_repository.dart';
import 'package:get_it/get_it.dart';

void hiveDI({required GetIt locator}) {

  /// Provide Repository
  locator.registerLazySingleton<HiveRepository>(() => HiveRepositoryImpl());
}