import 'package:flutter/material.dart';

class AccentSection extends StatefulWidget {
  const AccentSection({super.key});

  @override
  State<AccentSection> createState() => _AccentSectionState();
}

class _AccentSectionState extends State<AccentSection> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(
              "Accent",
              style: Theme.of(context).textTheme.titleSmall,
            ),

            //  open color picker
            FilledButton(
                onPressed: () {},
                child: Row(
                  children: [
                    Icon(
                      Icons.color_lens_rounded,
                      color: Colors.white,
                      size: 24,
                    ),
                    Text(
                      "Color Picker",
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                  ],
                ))
          ],
        )
        //  predefined colors
      ],
    );
  }
}
