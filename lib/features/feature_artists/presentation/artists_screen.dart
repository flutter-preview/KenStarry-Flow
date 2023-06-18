import 'package:flow/features/feature_artists/presentation/components/artists_list.dart';
import 'package:flow/features/feature_artists/presentation/controller/artists_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:on_audio_query/on_audio_query.dart';

import '../../../core/presentation/controller/core_controller.dart';

class ArtistsScreen extends StatefulWidget {
  const ArtistsScreen({super.key});

  @override
  State<ArtistsScreen> createState() => _ArtistsScreenState();
}

class _ArtistsScreenState extends State<ArtistsScreen> {
  late final ArtistsController _artistsController;
  late final CoreController controller;

  @override
  void initState() {
    super.initState();

    _artistsController = Get.find();
    controller = Get.find();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            systemOverlayStyle: SystemUiOverlayStyle(
                statusBarColor: Theme.of(Get.context!).scaffoldBackgroundColor,
                statusBarIconBrightness:
                    controller.brightness.value == Brightness.dark
                        ? Brightness.light
                        : Brightness.dark),
            actions: [
              IconButton(
                  onPressed: () {},
                  icon: Icon(
                    Icons.sort_rounded,
                    color: Theme.of(Get.context!).iconTheme.color,
                  )),
              IconButton(
                  onPressed: () {},
                  icon: Icon(
                    Icons.search,
                    color: Theme.of(Get.context!).iconTheme.color,
                  )),
            ],
            expandedHeight: 200,
            floating: false,
            pinned: true,
            backgroundColor: Theme.of(context).scaffoldBackgroundColor,
            flexibleSpace: FlexibleSpaceBar(
              title: Text(
                "Artists",
                style: Theme.of(context).textTheme.titleSmall,
              ),
              centerTitle: true,
              collapseMode: CollapseMode.parallax,
              background: Icon(
                Icons.music_note_outlined,
                size: 56,
                color: Theme.of(context).primaryColor,
              ),
            ),
          ),
          //  list of artists
          FutureBuilder<List<ArtistModel>>(
              future: _artistsController.getArtists(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const SliverToBoxAdapter(
                      child: CircularProgressIndicator());
                }

                if (snapshot.data == null) {
                  return const SliverToBoxAdapter(
                      child: Center(child: Text("No data found")));
                }

                if (snapshot.data!.isEmpty) {
                  return const SliverToBoxAdapter(
                      child: Center(child: Text("No artists yet")));
                }

                //  get artists
                final artists = snapshot.data!;
                _artistsController.setArtists(artists: artists);

                //  our list of artists
                return ArtistsList(artistsController: _artistsController);
              })
        ],
      ),
    );
  }
}
