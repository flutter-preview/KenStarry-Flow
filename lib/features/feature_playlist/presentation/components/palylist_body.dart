import 'package:flow/core/presentation/components/my_lottie.dart';
import 'package:flutter/material.dart';

class PlaylistBody extends StatelessWidget {
  const PlaylistBody({super.key});

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Center(
        child: Column(
          children: [
            SizedBox(
                child: MyLottie(
              lottie: 'assets/lottie/playlist_grey_2.json',
              width: 300,
              height: 300,
            )),
            Text("No Playlists yet.")
          ],
        ),
      ),
    );
  }
}
