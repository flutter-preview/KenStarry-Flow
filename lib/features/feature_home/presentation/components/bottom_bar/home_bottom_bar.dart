import 'package:flow/features/feature_home/presentation/components/bottom_bar/bottom_bar_item.dart';
import 'package:flutter/material.dart';

class HomeBottomBar extends StatelessWidget {
  const HomeBottomBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          color: Theme.of(context).scaffoldBackgroundColor,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.1),
              spreadRadius: 10,
              blurRadius: 30,
            )
          ]),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Wrap(
          alignment: WrapAlignment.start,
          runSpacing: 16,
          children: [
            //  Bottom nav icons
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                //  home icon
                bottomBarItem(title: "Home", icon: Icons.home),
                bottomBarItem(title: "Playlist", icon: Icons.playlist_play_rounded),
                bottomBarItem(title: "Genres", icon: Icons.music_note_outlined),
                bottomBarItem(title: "Settings", icon: Icons.settings),
              ],
            )
          ],
        ),
      ),
    );
  }
}
