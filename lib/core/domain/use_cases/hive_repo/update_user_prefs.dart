import 'package:flow/core/domain/repository/user_repository.dart';
import 'package:flow/di/locator.dart';

import '../../models/user.dart';

class UpdateUserPrefs {
  final repo = locator.get<UserRepository>();

  Future<void> call({required User user}) => repo.updateUserPrefs(user: user);
}
