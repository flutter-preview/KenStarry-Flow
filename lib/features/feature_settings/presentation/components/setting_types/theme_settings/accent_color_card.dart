import 'package:flow/core/utils/extensions/color_extensions.dart';
import 'package:flutter/material.dart';

class AccentColorCard extends StatelessWidget {

  final Color color;

  const AccentColorCard({super.key, required this.color});

  @override
  Widget build(BuildContext context) {
    return UnconstrainedBox(
      child: SizedBox(
        width: 50,
        height: 50,
        child: Stack(
          fit: StackFit.loose,
          children: [
            Container(
              width: double.infinity,
              height: double.infinity,
              margin: const EdgeInsets.all(4),
              decoration: BoxDecoration(
                  color: color,
                  borderRadius: BorderRadius.circular(100)
              ),
            ),
            //  tick
            Align(
              alignment: AlignmentDirectional.topEnd,
              child: Container(
                width: 20,
                height: 20,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(100),
                  color: color.lightenColor(92),
                  border: Border.all(color: Theme.of(context).scaffoldBackgroundColor, width: 2)
                ),
                child: Icon(Icons.done_rounded, color: color, size: 16,),
              ),
            )
          ],
        ),
      ),
    );
  }
}
