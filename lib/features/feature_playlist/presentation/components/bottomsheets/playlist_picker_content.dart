import 'package:flutter/material.dart';

class PlaylistPickerContent extends StatelessWidget {
  const PlaylistPickerContent({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 350,
      margin: const EdgeInsets.all(16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: Theme.of(context).scaffoldBackgroundColor,
      ),
      child: Column(
        children: [],
      ),
    );
  }
}
