import 'package:flutter/material.dart';
import 'package:marquee/marquee.dart';
import 'package:on_audio_query/on_audio_query.dart';

class PlayerScreen extends StatelessWidget {
  final SongModel song;

  const PlayerScreen({super.key, required this.song});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24.0),
      child: Wrap(
        alignment: WrapAlignment.center,
        runSpacing: 24,
        crossAxisAlignment: WrapCrossAlignment.center,
        children: [
          UnconstrainedBox(
            child: SizedBox(
                width: 280,
                height: 280,
                child: QueryArtworkWidget(
                  id: song.id,
                  keepOldArtwork: true,
                  type: ArtworkType.AUDIO,
                  artworkWidth: double.infinity,
                  artworkHeight: double.infinity,
                  artworkBorder: BorderRadius.circular(300),
                  artworkFit: BoxFit.cover,
                  artworkQuality: FilterQuality.high,
                  nullArtworkWidget: Icon(
                    Icons.music_note_outlined,
                    size: 120,
                    color: Theme.of(context).iconTheme.color,
                  ),
                  quality: 100,
                )),
          ),
          //  song Name
          Column(
            children: [
              SizedBox(
                width: double.infinity,
                height: 50,
                child: Marquee(
                  text: song.displayNameWOExt,
                  style: Theme.of(context).textTheme.bodyLarge,
                  pauseAfterRound: const Duration(seconds: 1),
                  crossAxisAlignment: CrossAxisAlignment.center,
                ),
              ),
              Text(song.artist ?? "Unknown Artist")
            ],
          ),

          //  seekbar buttons
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              //  shuffle playback
              Container(
                width: 35,
                height: 35,
                decoration: BoxDecoration(
                    color: Theme.of(context).primaryColorDark,
                    borderRadius: BorderRadius.circular(100)),
                child: Icon(
                  Icons.shuffle,
                  size: 16,
                  color: Theme.of(context).iconTheme.color,
                ),
              ),

              //  seek buttons
              Flexible(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Container(
                      width: 45,
                      height: 45,
                      decoration: BoxDecoration(
                          color: Colors.transparent,
                          borderRadius: BorderRadius.circular(100)),
                      child: Icon(
                        Icons.skip_previous_rounded,
                        size: 24,
                        color: Theme.of(context).iconTheme.color,
                      ),
                    ),
                    Container(
                        width: 70,
                        height: 70,
                        decoration: BoxDecoration(
                            color: Theme.of(context).primaryColorDark,
                            borderRadius: BorderRadius.circular(100)),
                        child: Icon(
                          Icons.play_arrow_rounded,
                          size: 32,
                          color: Theme.of(context).iconTheme.color,
                        )),
                    Container(
                      width: 45,
                      height: 45,
                      decoration: BoxDecoration(
                          color: Colors.transparent,
                          borderRadius: BorderRadius.circular(100)),
                      child: Icon(
                        Icons.skip_next_rounded,
                        size: 24,
                        color: Theme.of(context).iconTheme.color,
                      ),
                    ),
                  ],
                ),
              ),

              //  music speed
              Container(
                width: 35,
                height: 35,
                decoration: BoxDecoration(
                    color: Theme.of(context).primaryColorDark,
                    borderRadius: BorderRadius.circular(100)),
                child: Icon(
                  Icons.repeat,
                  size: 16,
                  color: Theme.of(context).iconTheme.color,
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
