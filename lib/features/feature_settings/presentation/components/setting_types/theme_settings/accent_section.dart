import 'package:flow/theme/colors.dart';
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
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Accent",
              style: Theme.of(context).textTheme.titleSmall,
            ),

            //  open color picker
            FilledButton(
                onPressed: () {},
                style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(accent),
                    foregroundColor: MaterialStateProperty.all(Colors.white)),
                child: Row(
                  children: [
                    const Icon(
                      Icons.color_lens_rounded,
                      color: Colors.white,
                      size: 24,
                    ),
                    const SizedBox(
                      width: 8,
                    ),
                    Text(
                      "Color Picker",
                      style: TextStyle(
                          fontSize:
                              Theme.of(context).textTheme.bodyMedium?.fontSize,
                          fontWeight: Theme.of(context)
                              .textTheme
                              .bodyMedium
                              ?.fontWeight,
                          color: Colors.white),
                    ),
                  ],
                ))
          ],
        ),
        //  predefined colors
        ListView.separated(
          itemCount: predefinedAccentColors.length,
          scrollDirection: Axis.horizontal,
          physics: const BouncingScrollPhysics(),
          itemBuilder: (context, index) {},
          separatorBuilder: (context, index) => const SizedBox(
            width: 8,
          ),
        )
      ],
    );
  }
}
