import 'package:flow/core/data/repository/user_repository_impl.dart';
import 'package:flow/core/domain/repository/user_repository.dart';
import 'package:flow/core/domain/use_cases/hive_repo/add_user_prefs.dart';
import 'package:flow/core/domain/use_cases/hive_repo/delete_user_prefs.dart';
import 'package:flow/core/domain/use_cases/hive_repo/get_user_prefs.dart';
import 'package:flow/core/domain/use_cases/hive_repo/hive_use_cases.dart';
import 'package:flow/core/domain/use_cases/hive_repo/update_user_prefs.dart';
import 'package:get_it/get_it.dart';

void userDI({required GetIt locator}) {
  /// Provide Repository
  locator.registerLazySingleton<UserRepository>(() => UserRepositoryImpl());

  /// Provide Use Cases
  locator.registerLazySingleton<UserUseCases>(() => UserUseCases(
      addUserPrefs: AddUserPrefs(),
      getUserPrefs: GetUserPrefs(),
      deleteUserPrefs: DeleteUserPrefs(),
      updateUserPrefs: UpdateUserPrefs()));
}
