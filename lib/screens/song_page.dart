import 'package:flutter/material.dart';
import 'package:music_player/components/neu_box.dart';
import 'package:music_player/models/playlist_provider.dart';
import 'package:provider/provider.dart';

class SongPage extends StatelessWidget {
  const SongPage({super.key});

  String formatTime(Duration duration) {
    String twoDigitSeconds =
        duration.inSeconds.remainder(60).toString().padLeft(2, '0');
    String formattedTime = "${duration.inMinutes}:$twoDigitSeconds";

    return formattedTime;
  }

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return Consumer<PlaylistProvider>(builder: (context, value, child) {
      //get playlist
      final playlist = value.playlist;

      //get current song
      final currentSong = playlist[value.currentSongIndex ?? 0];

      return Scaffold(
          backgroundColor: theme.colorScheme.background,
          appBar: AppBar(
            title: const Text("P L A Y L I S T"),
            centerTitle: true,
            elevation: 0,
            backgroundColor: Colors.transparent,
            actions: [
              IconButton(onPressed: () {}, icon: const Icon(Icons.menu)),
            ],
          ),
          body: SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(25),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  NeuBox(
                    child: Column(
                      children: [
                        ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: Image.asset(
                              currentSong.albumArtImagePath,
                            )),
                        const SizedBox(
                          height: 20,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  currentSong.songName,
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold),
                                ),
                                Text(
                                  currentSong.artistName,
                                  style: const TextStyle(fontSize: 12),
                                )
                              ],
                            ),
                            IconButton(
                                onPressed: () {},
                                icon: const Icon(
                                  Icons.favorite,
                                  color: Colors.red,
                                ))
                          ],
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 40),

                  //song duration
                  Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(formatTime(value.currentDuration)),
                          const Icon(Icons.shuffle),
                          const Icon(Icons.repeat),
                          Text(formatTime(value.totalDuration))
                        ],
                      ),
                      SliderTheme(
                        data: SliderTheme.of(context).copyWith(
                            thumbShape: const RoundSliderThumbShape(
                                enabledThumbRadius: 0)),
                        child: Slider(
                          min: 0,
                          max: value.totalDuration.inSeconds.toDouble(),
                          value: value.currentDuration.inSeconds.toDouble() ==
                                  value.totalDuration.inSeconds.toDouble()
                              ? 0
                              : value.currentDuration.inSeconds.toDouble(),
                          activeColor: Colors.green,
                          onChanged: (v) {
                            // during when user is sliding around
                          },
                          onChangeEnd: (v) {
                            // sliding has finished, go to that position in song duration
                            value.seek(Duration(seconds: v.toInt()));
                          },
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 40),
                  Row(
                    children: [
                      Expanded(
                        child: GestureDetector(
                          onTap: value.playPreviousSong,
                          child: const NeuBox(
                            child: Icon(Icons.skip_previous),
                          ),
                        ),
                      ),
                      const SizedBox(width: 25),
                      Expanded(
                        child: GestureDetector(
                          onTap: value.pauseOrResume,
                          child: NeuBox(
                            child: Icon(value.isPlaying
                                ? Icons.pause
                                : Icons.play_arrow),
                          ),
                        ),
                      ),
                      const SizedBox(width: 25),
                      Expanded(
                        child: GestureDetector(
                          onTap: value.playNextSong,
                          child: const NeuBox(
                            child: Icon(Icons.skip_next),
                          ),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ));
    });
  }
}
