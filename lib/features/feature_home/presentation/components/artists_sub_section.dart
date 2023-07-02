import 'package:flow/features/feature_artists/presentation/controller/artists_controller.dart';
import 'package:flow/features/feature_home/presentation/components/artists_sub_card.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../feature_artists/presentation/artists_screen.dart';
import '../../../feature_artists/presentation/screens/artist_view_screen.dart';

class ArtistsSubSection extends StatefulWidget {
  const ArtistsSubSection({super.key});

  @override
  State<ArtistsSubSection> createState() => _ArtistsSubSectionState();
}

class _ArtistsSubSectionState extends State<ArtistsSubSection> {
  late final ArtistsController _artistsController;

  @override
  void initState() {
    super.initState();

    _artistsController = Get.find();
  }

  @override
  Widget build(BuildContext context) {
    return SliverPadding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      sliver: SliverToBoxAdapter(
        child: Column(
          children: [
            //  title
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Top Artists",
                  style: Theme.of(context).textTheme.titleSmall,
                ),
                GestureDetector(
                  onTap: () {
                    Get.to(() => const ArtistsScreen());
                  },
                  child: Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      // color: Theme.of(context).primaryColorDark,
                    ),
                    child: Icon(
                      Icons.chevron_right_rounded,
                      color: Theme.of(context).iconTheme.color,
                    ),
                  ),
                )
              ],
            ),
            //  query artists
            FutureBuilder(
                future: _artistsController.getArtists(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return CircularProgressIndicator();
                  }

                  if (snapshot.data == null) {
                    return Center(child: Text("No data found"));
                  }

                  if (snapshot.data!.isEmpty) {
                    return Center(child: Text("No artists yet"));
                  }

                  //  get artists
                  final artists = snapshot.data!;
                  _artistsController.setArtists(artists: artists);

                  return Container(
                    width: double.infinity,
                    height: 200,
                    child: ListView.separated(
                        physics: const BouncingScrollPhysics(),
                        itemCount: _artistsController.artists.length,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index) {
                          // _artistsController.artists.sort((a, b) =>
                          //     b.numberOfTracks!.compareTo(a.numberOfTracks!));
                          final artist = _artistsController.artists[index];

                          return ArtistsSubCard(
                            artist: artist,
                            onPlayTapped: () {
                              //  play artist specific songs
                            },
                            onArtworkTapped: () =>
                                Get.to(() => ArtistViewScreen(artist: artist)),
                          );
                        },
                        separatorBuilder: (context, index) =>
                            const SizedBox(width: 16)),
                  );
                })
          ],
        ),
      ),
    );
  }
}
