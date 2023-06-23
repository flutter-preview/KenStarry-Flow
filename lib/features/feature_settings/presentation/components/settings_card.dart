import 'package:flutter/material.dart';

class SettingsCard extends StatelessWidget {

  final String title;
  final IconData iconData;
  final Color color;

  const SettingsCard({super.key, required this.title, required this.iconData, required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.red,
        borderRadius: BorderRadius.circular(16)
      ),
      child: Row(
        children: [
          //  icon

          //  title
        ],
      ),
    );
  }
}
