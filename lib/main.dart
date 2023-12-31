import 'package:audio_service/audio_service.dart';
import 'package:flow/core/domain/models/user.dart';
import 'package:flow/core/domain/models/player_prefs.dart';
import 'package:flow/core/presentation/controller/player_controller.dart';
import 'package:flow/core/presentation/controller/user_controller.dart';
import 'package:flow/core/utils/extensions/color_extensions.dart';
import 'package:flow/core/utils/extensions/string_extensions.dart';
import 'package:flow/core/utils/hive_utils.dart';
import 'package:flow/di/controllers_di.dart';
import 'package:flow/di/locator.dart';
import 'package:flow/features/feature_main/presentation/main_screen.dart';
import 'package:flow/features/feature_playlist/domain/model/playlist.dart';
import 'package:flow/features/feature_settings/presentation/controller/theme_controller.dart';
import 'package:flow/theme/colors.dart';
import 'package:flow/theme/my_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:path_provider/path_provider.dart' as path_provider;
import 'package:hive/hive.dart';

Future<void> main() async {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();

  //  splash screen
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);

  final appDocumentDirectory =
      await path_provider.getApplicationDocumentsDirectory();

  await Hive.initFlutter(appDocumentDirectory.path);
  Hive.registerAdapter(UserAdapter());
  Hive.registerAdapter(PlaylistAdapter());
  Hive.registerAdapter(PlayerPrefsAdapter());

  await Hive.openBox(HiveUtils.userBox);
  await Hive.openBox(HiveUtils.playlistBox);
  await Hive.openBox(HiveUtils.playerPrefsBox);

  final playerPrefs = await Hive.box(HiveUtils.playerPrefsBox)
      .get('playerPrefs') as PlayerPrefs?;

  await invokeDI(index: playerPrefs?.currentSongIndex ?? 0);

  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late final UserController _userController;
  late final ThemeController _themeController;
  late final PlayerController _playerController;

  @override
  void initState() {
    super.initState();

    //  initialize all controllers
    initializeControllers();
    _userController = Get.find<UserController>();
    _themeController = Get.find<ThemeController>();
    _playerController = Get.find<PlayerController>();
  }

  @override
  void dispose() {
    _playerController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    FlutterNativeSplash.remove();

    return ValueListenableBuilder(
        valueListenable: _userController.userPrefs.value,
        builder: (context, box, widget) {
          final userPrefs = box.get('user') as User?;

          if (userPrefs == null) {
            _userController.addUserPrefs(
                user: User(
                    hasGrantedPermission: false,
                    themeType: 'System Preferences',
                    accentColorHex: predefinedAccentColors[0].toHex));
          }

          //  set the selected theme
          _themeController.setSelectedThemeIndex(
              index: _themeController.themeTypes
                  .indexOf(userPrefs?.themeType ?? 'System Preferences'));

          //  set the selected accent color
          _themeController.setSelectedAccentColorHex(
              hex:
                  userPrefs?.accentColorHex ?? predefinedAccentColors[0].toHex);

          return GetMaterialApp(
            title: "Flow",
            home: MainScreen(),
            theme: MyTheme(
                    accent: _themeController
                        .selectedAccentColorHex.value.toColor as Color,
                    context: context)
                .lightTheme,
            darkTheme: MyTheme(
                    accent: _themeController
                        .selectedAccentColorHex.value.toColor as Color,
                    context: context)
                .darkTheme,
            themeMode: userPrefs?.themeType == 'Light Theme'
                ? ThemeMode.light
                : userPrefs?.themeType == 'Dark Theme'
                    ? ThemeMode.dark
                    : ThemeMode.system,
            debugShowCheckedModeBanner: false,
          );
        });
  }
}
