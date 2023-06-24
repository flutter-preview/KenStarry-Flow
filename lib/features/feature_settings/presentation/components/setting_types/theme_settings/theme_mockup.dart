import 'package:flow/core/utils/extensions/color_extensions.dart';
import 'package:flow/theme/colors.dart';
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
        height: 320,
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(24),
            color: Theme.of(context).scaffoldBackgroundColor,
            border: Border.all(color: Colors.black.lightenColor(90), width: 3)),
        child: Stack(
          fit: StackFit.loose,
          children: [
            //  phone content
            Column(
              children: [
                const SizedBox(height: 16),
                //  app bar section
                Container(
                  width: 80,
                  height: 16,
                  decoration: BoxDecoration(
                    color: Colors.black.lightenColor(90),
                    borderRadius: BorderRadius.circular(30)
                  ),
                ),
                const SizedBox(height: 16),
                //  library and play icons section
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      width: 80,
                      height: 25,
                      decoration: BoxDecoration(
                          color: accent.lightenColor(92),
                          borderRadius: BorderRadius.circular(16)),
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Container(
                          width: 25,
                          height: 25,
                          decoration: BoxDecoration(
                              color: accent.lightenColor(92),
                              borderRadius: BorderRadius.circular(100)),
                        ),
                        const SizedBox(
                          width: 8,
                        ),
                        Container(
                          width: 35,
                          height: 35,
                          decoration: BoxDecoration(
                              color: accent.lightenColor(92),
                              borderRadius: BorderRadius.circular(100)),
                          child: Icon(
                            Icons.play_arrow_rounded,
                            color: Theme.of(context).primaryColor,
                          ),
                        )
                      ],
                    )
                  ],
                ),

                const SizedBox(height: 16),

                //  song items list
                Expanded(
                  child: ListView.separated(
                    itemCount: 5,
                    itemBuilder: (context, index) => Container(
                      width: double.infinity,
                      height: 35,
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(8)
                      ),
                      child: Row(
                        children: [
                          Container(
                            width: 30,
                            height: 30,
                            decoration: BoxDecoration(
                                color: accent.lightenColor(92),
                                borderRadius: BorderRadius.circular(8)
                            ),
                          ),
                          const SizedBox(width: 8,),
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.all(2.0),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    width: double.infinity,
                                    height: 12,
                                    decoration: BoxDecoration(
                                        color: Colors.black.lightenColor(90),
                                        borderRadius: BorderRadius.circular(8)
                                    ),
                                  ),
                                  Container(
                                    width: 70,
                                    height: 8,
                                    decoration: BoxDecoration(
                                        color: Colors.black.lightenColor(90),
                                        borderRadius: BorderRadius.circular(8)
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                    separatorBuilder: (context, index) => const SizedBox(
                      height: 8,
                    ),
                  ),
                )
              ],
            ),

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
            ),

            //  phone navigation bar
            Align(
              alignment: AlignmentDirectional.bottomCenter,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  //  bottom nav
                  Container(
                    width: double.infinity,
                    height: 80,
                    margin: const EdgeInsets.symmetric(horizontal: 8),
                    decoration: BoxDecoration(
                        color: accent.lightenColor(92),
                        borderRadius: BorderRadius.circular(16)),
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  Container(
                    width: 50,
                    height: 5,
                    decoration: BoxDecoration(
                        color: Colors.black.lightenColor(80),
                        borderRadius: BorderRadius.circular(30)),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
