import 'package:flow/features/feature_artists/presentation/components/artists_list.dart';
import 'package:flow/features/feature_artists/presentation/controller/artists_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:on_audio_query/on_audio_query.dart';

class ArtistsScreen extends StatefulWidget {
  const ArtistsScreen({super.key});

  @override
  State<ArtistsScreen> createState() => _ArtistsScreenState();
}

class _ArtistsScreenState extends State<ArtistsScreen> {
  late final ArtistsController _artistsController;

  @override
  void initState() {
    super.initState();

    _artistsController = Get.find();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Text("Artists", style: Theme.of(context).textTheme.titleMedium),

            const SizedBox(height: 24,),

            //  list of artists
            FutureBuilder<List<ArtistModel>>(
                future: _artistsController.getArtists(),
                builder: (context, snapshot) {

                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const CircularProgressIndicator();
                  }

                  if (snapshot.data == null) {
                    return const Center(child: Text("No data found"));
                  }

                  if (snapshot.data!.isEmpty) {
                    return const Center(child: Text("No artists yet"));
                  }

                  //  get artists
                  final artists = snapshot.data!;
                  _artistsController.setArtists(artists: artists);

                  //  our list of artists
                  return Expanded(child: ArtistsList(artistsController: _artistsController));

                })
          ],
        ),
      ),
    );
  }
}
