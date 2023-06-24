import 'package:flutter/material.dart';

class AppearanceSection extends StatelessWidget {
  const AppearanceSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text("Appearance", style: Theme.of(context).textTheme.titleSmall,),

        //  themes card
      ],
    );
  }
}
