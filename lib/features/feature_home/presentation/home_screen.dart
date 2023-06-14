import 'package:flow/core/utils/extensions.dart';
import 'package:flow/theme/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion(
      value: const SystemUiOverlayStyle(
          systemNavigationBarColor: bgColor,
          systemNavigationBarIconBrightness: Brightness.light),
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Flow").addGradient,
          centerTitle: true,
          systemOverlayStyle: const SystemUiOverlayStyle(
              statusBarColor: bgColor,
              statusBarIconBrightness: Brightness.light),
        ),
        backgroundColor: bgColor,
        body: SafeArea(
            child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Text("Hello"),
        )),
      ),
    );
  }
}
