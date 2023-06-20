import 'package:flow/core/domain/use_cases/hive_repo/add_user_prefs.dart';
import 'package:flow/core/domain/use_cases/hive_repo/delete_user_prefs.dart';
import 'package:flow/core/domain/use_cases/hive_repo/get_user_prefs.dart';
import 'package:flow/core/domain/use_cases/hive_repo/update_user_prefs.dart';

class HiveUseCases {
  final AddUserPrefs addUserPrefs;
  final GetUserPrefs getUserPrefs;
  final DeleteUserPrefs deleteUserPrefs;
  final UpdateUserPrefs updateUserPrefs;

  HiveUseCases(
      {required this.addUserPrefs,
      required this.getUserPrefs,
      required this.deleteUserPrefs,
      required this.updateUserPrefs});
}
