import 'package:flow/core/domain/repository/hive_repository.dart';
import 'package:hive/hive.dart';

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
  Future<void> getUserPrefs() {
    // TODO: implement getUserPrefs
    throw UnimplementedError();
  }

  @override
  Future<void> updateUserPrefs() {
    // TODO: implement updateUserPrefs
    throw UnimplementedError();
  }
}
