import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ArtistsScreen extends StatefulWidget {
  const ArtistsScreen({super.key});

  @override
  State<ArtistsScreen> createState() => _ArtistsScreenState();
}

class _ArtistsScreenState extends State<ArtistsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Text("Artists", style: Theme.of(context).textTheme.titleMedium),

            //  list of artists
          ],
        ),
      ),
    );
  }
}
