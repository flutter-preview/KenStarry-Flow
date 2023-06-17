import 'package:flow/di/controllers_di.dart';
import 'package:flow/di/locator.dart';
import 'package:flow/features/feature_main/presentation/main_screen.dart';
import 'package:flow/theme/my_theme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

Future<void> main() async {

  WidgetsFlutterBinding.ensureInitialized();
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
      home: const MainScreen(),
      theme: MyTheme.lightTheme,
      darkTheme: MyTheme.darkTheme,
      themeMode: ThemeMode.system,
      debugShowCheckedModeBanner: false,
    );
  }
}

