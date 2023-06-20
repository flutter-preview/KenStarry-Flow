import 'package:flow/core/domain/repository/hive_repository.dart';
import 'package:flutter/foundation.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';

import '../../domain/models/user.dart';
import '../../utils/hive_utils.dart';

class HiveRepositoryImpl implements HiveRepository {
  final Box userBox = Hive.box(HiveUtils.userBox);

  @override
  Future<void> addUserPrefs({required User user}) async =>
      await userBox.put('user', user);

  @override
  Future<void> deleteUserPrefs() async => await userBox.delete('user');

  @override
  void getUserPrefs({required Function(ValueListenable<Box> box) observeBox}) =>
      observeBox(userBox.listenable());

  @override
  Future<void> updateUserPrefs({required User user}) async =>
      await userBox.put('user', user);
}
