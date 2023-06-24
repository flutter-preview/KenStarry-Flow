import 'package:flutter/material.dart';

class AppearanceCarousel extends StatelessWidget {

  final Widget mockup;

  const AppearanceCarousel({super.key, required this.mockup});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        mockup,
      ],
    );
  }
}
