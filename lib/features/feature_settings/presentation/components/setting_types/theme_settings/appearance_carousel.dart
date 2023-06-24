import 'package:flutter/material.dart';

class AppearanceCarousel extends StatelessWidget {
  final Widget mockup;
  final int index;

  const AppearanceCarousel(
      {super.key, required this.mockup, required this.index});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        mockup,
        const SizedBox(height: 16,),
        Text(
          index == 0
              ? 'Light Theme'
              : index == 1
                  ? 'Dark Theme'
                  : 'System Preferences',
          style: Theme.of(context).textTheme.bodyMedium,
        )
      ],
    );
  }
}
