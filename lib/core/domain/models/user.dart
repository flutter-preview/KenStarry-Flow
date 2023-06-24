import 'package:hive/hive.dart';

import '../../../features/feature_settings/domain/model/theme_type.dart';

part 'user.g.dart';

@HiveType(typeId: 1)
class User extends HiveObject {
  @HiveField(0, defaultValue: false)
  final bool? hasGrantedPermission;

  @HiveField(1)
  final String? themeType;

  User({this.hasGrantedPermission, this.themeType});
}
