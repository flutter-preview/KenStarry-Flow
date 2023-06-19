import 'package:hive/hive.dart';

part 'user.g.dart';

@HiveType(typeId: 1)
class User extends HiveObject {
  @HiveField(0, defaultValue: false)
  final bool hasGrantedPermission;

  User({required this.hasGrantedPermission});
}
