import 'package:flow/core/utils/extensions/color_extensions.dart';
import 'package:flutter/material.dart';

class ThemeMockup extends StatefulWidget {
  const ThemeMockup({super.key});

  @override
  State<ThemeMockup> createState() => _ThemeMockupState();
}

class _ThemeMockupState extends State<ThemeMockup> {
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: AlignmentDirectional.center,
      child: Container(
        width: MediaQuery.of(context).size.width * 0.55,
        height: 300,
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(24),
          color: Theme.of(context).scaffoldBackgroundColor,
          border: Border.all(color: Colors.black.lightenColor(90), width: 3)
        ),
        child: Stack(
          fit: StackFit.loose,
          children: [
            //  phone camera
            Container(
              width: 20,
              height: 20,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(100),
                color: Colors.black.lightenColor(50),
              ),
              child: Center(
                child: Container(
                  width: 10,
                  height: 10,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(100),
                    color: Colors.black,
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
