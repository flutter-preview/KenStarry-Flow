import 'package:flow/features/feature_home/presentation/controller/player_controller.dart';
import 'package:flow/features/feature_home/presentation/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

void main() {
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
    Get.put(PlayerController());
  }
  
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: "Flow",
      home: const HomeScreen(),
      theme: ThemeData(
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.transparent,
          elevation: 0
        )
      ),
      debugShowCheckedModeBanner: false,
    );
  }
}

