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
      margin: const EdgeInsets.symmetric(horizontal: 8),
      child: Image.asset('assets/images/lady5.jpg', fit: BoxFit.cover,),
    );
  }
}
