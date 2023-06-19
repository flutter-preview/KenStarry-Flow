import 'package:flow/core/domain/models/user.dart';
import 'package:flow/core/utils/hive_utils.dart';
import 'package:flow/di/controllers_di.dart';
import 'package:flow/di/locator.dart';
import 'package:flow/features/feature_main/presentation/main_screen.dart';
import 'package:flow/theme/my_theme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:path_provider/path_provider.dart' as path_provider;
import 'package:hive/hive.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final appDocumentDirectory =
      await path_provider.getApplicationDocumentsDirectory();

  await Hive.initFlutter(appDocumentDirectory.path);
  Hive.registerAdapter(UserAdapter());

  await invokeDI();

  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();

    //  initialize all controllers
    initializeControllers();
  }

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: "Flow",
      home: FutureBuilder(
        future: Future.wait([Hive.openBox(HiveUtils.userBox)]),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done &&
              snapshot.hasError) {
            return const Text("Error occured");
          } else if (snapshot.connectionState == ConnectionState.done &&
              !snapshot.hasError) {
            return const MainScreen();
          } else {
            return Scaffold(
                body: Center(
                    child: CircularProgressIndicator(
                        color: Theme.of(context).primaryColor)));
          }
        },
      ),
      theme: MyTheme.lightTheme,
      darkTheme: MyTheme.darkTheme,
      themeMode: ThemeMode.system,
      debugShowCheckedModeBanner: false,
    );
  }
}
