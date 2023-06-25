import 'package:flutter/material.dart';

class AccentColorCard extends StatelessWidget {

  final Color color;

  const AccentColorCard({super.key, required this.color});

  @override
  Widget build(BuildContext context) {
    return UnconstrainedBox(
      child: Stack(
        fit: StackFit.loose,
        children: [
          Container(
            width: 60,
            height: 60,
            decoration: BoxDecoration(
                color: color,
                borderRadius: BorderRadius.circular(100)
            ),
          ),
          //  tick
          Container(
            width: 20,
            height: 20,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(100),
              color: Theme.of(context).scaffoldBackgroundColor
            ),
            child: Icon(Icons.done_rounded, color: color, size: 16,),
          )
        ],
      ),
    );
  }
}
