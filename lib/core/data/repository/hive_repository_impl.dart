import 'package:flow/core/domain/repository/hive_repository.dart';
import 'package:hive/hive.dart';

import '../../utils/hive_utils.dart';

class HiveRepositoryImpl implements HiveRepository {

  final Box userBox = Hive.box(HiveUtils.userBox);

  @override
  Future<void> addUserPrefs() {
    // TODO: implement addUserPrefs
    throw UnimplementedError();
  }

  @override
  Future<void> deleteUserPrefs() {
    // TODO: implement deleteUserPrefs
    throw UnimplementedError();
  }

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