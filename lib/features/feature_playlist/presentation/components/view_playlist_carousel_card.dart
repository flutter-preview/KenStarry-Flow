import 'package:flow/features/feature_playlist/domain/model/playlist.dart';
import 'package:flutter/material.dart';

class ViewPlaylistCarouselCard extends StatelessWidget {
  final Playlist playlist;

  const ViewPlaylistCarouselCard({super.key, required this.playlist});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      margin: const EdgeInsets.symmetric(horizontal: 4),
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(24)),
      child: Stack(
        fit: StackFit.expand,
        children: [
          //  image
          ClipRRect(
              borderRadius: BorderRadius.circular(24),
              child: Image.asset(
                'assets/images/lady5.jpg',
                fit: BoxFit.cover,
              )),

          //  details
          Align(
            alignment: AlignmentDirectional.bottomCenter,
            child: Container(
              width: double.infinity,
              height: 100,
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(
                  bottomRight: Radius.circular(24),
                  bottomLeft: Radius.circular(24)
                ),
                color: Colors.black,
              ),
            ),
          )
        ],
      ),
    );
  }
}
