import 'package:flow/core/utils/extensions/color_extensions.dart';
import 'package:flow/theme/colors.dart';
import 'package:flutter/material.dart';

class DarkThemeMockup extends StatefulWidget {
  const DarkThemeMockup({super.key});

  @override
  State<DarkThemeMockup> createState() => _DarkThemeMockupState();
}

class _DarkThemeMockupState extends State<DarkThemeMockup> {
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: AlignmentDirectional.center,
      child: Container(
        width: MediaQuery.of(context).size.width * 0.55,
        height: 350,
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(24),
            color: bgColorDarkMode,
            border: Border.all(color: Colors.black.lightenColor(90), width: 2)),
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
                      color: Colors.black.lightenColor(50),
                      borderRadius: BorderRadius.circular(30)),
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
                          color: bgDarkColor,
                          borderRadius: BorderRadius.circular(16)),
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          width: 25,
                          height: 25,
                          decoration: BoxDecoration(
                              color: bgDarkColor,
                              borderRadius: BorderRadius.circular(100)),
                        ),
                        const SizedBox(
                          width: 8,
                        ),
                        Container(
                          width: 35,
                          height: 35,
                          decoration: BoxDecoration(
                              color: bgDarkColor,
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
                ListView.separated(
                  itemCount: 5,
                  shrinkWrap: true,
                  padding: EdgeInsets.zero,
                  itemBuilder: (context, index) => Container(
                    width: double.infinity,
                    height: 35,
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    decoration: BoxDecoration(
                        color: bgColorDarkMode,
                        borderRadius: BorderRadius.circular(8)),
                    child: Row(
                      children: [
                        Container(
                          width: 30,
                          height: 30,
                          decoration: BoxDecoration(
                              color: bgDarkColor,
                              borderRadius: BorderRadius.circular(8)),
                          child: Icon(Icons.music_note_rounded, color: Theme.of(context).primaryColor, size: 16),
                        ),
                        const SizedBox(
                          width: 8,
                        ),
                        //  content
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.all(2.0),
                            child: Column(
                              mainAxisAlignment:
                                  MainAxisAlignment.spaceEvenly,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  width: double.infinity,
                                  height: 12,
                                  decoration: BoxDecoration(
                                      color: Colors.black.lightenColor(50),
                                      borderRadius: BorderRadius.circular(8)),
                                ),
                                Container(
                                  width: 70,
                                  height: 8,
                                  decoration: BoxDecoration(
                                      color: Colors.black.lightenColor(50),
                                      borderRadius: BorderRadius.circular(8)),
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
                        color: bgDarkColor,
                        borderRadius: BorderRadius.circular(16)),
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  Container(
                    width: 50,
                    height: 5,
                    decoration: BoxDecoration(
                        color: Colors.black.lightenColor(50),
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
