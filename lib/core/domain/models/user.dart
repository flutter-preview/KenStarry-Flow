import 'package:hive/hive.dart';

/// flutter packages pub run build_runner build
part 'user.g.dart';

@HiveType(typeId: 1)
class User extends HiveObject {
  @HiveField(0, defaultValue: false)
  final bool? hasGrantedPermission;

  @HiveField(1)
  final String? themeType;

  @HiveField(2)
  final String? accentColorHex;

  User({this.hasGrantedPermission, this.themeType, this.accentColorHex});
}
