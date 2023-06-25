import 'package:flow/core/domain/repository/user_repository.dart';
import 'package:flutter/foundation.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';

import '../../domain/models/user.dart';
import '../../utils/hive_utils.dart';

class UserRepositoryImpl implements UserRepository {
  final Box userBox = Hive.box(HiveUtils.userBox);

  @override
  Future<void> addUserPrefs({required User user}) async =>
      await userBox.put('user', user);

  @override
  Future<void> deleteUserPrefs() async => await userBox.delete('user');

  @override
  Future<User> getUserPrefs() async => await userBox.get('user') as User;

  @override
  Future<void> updateUserPrefs({required User user}) async {
    var oldUser = await userBox.get('user') as User;
    var newUser = User(
        hasGrantedPermission:
            user.hasGrantedPermission ?? oldUser.hasGrantedPermission,
        themeType: user.themeType ?? oldUser.themeType,
        accentColorHex: user.accentColorHex ?? oldUser.accentColorHex);

    await userBox.put('user', newUser);
  }
}
