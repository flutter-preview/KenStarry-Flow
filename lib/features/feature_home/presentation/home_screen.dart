import 'package:flow/features/feature_home/presentation/components/artists_sub_section.dart';
import 'package:flow/features/feature_home/presentation/components/greetings_section.dart';
import 'package:flow/features/feature_home/presentation/components/home_appbar.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: SafeArea(
        child: CustomScrollView(
          physics: const BouncingScrollPhysics(),
          slivers: [
            homeAppBar(),
            //  Artists Section
            ArtistsSubSection()
            //  Genres Section
            //  Playlists section
          ],
        ),
      ),
    );
  }
}
