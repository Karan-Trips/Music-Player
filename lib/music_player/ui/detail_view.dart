import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:yt_clone/music_player/getx_file/fetch_songs.dart';
import 'package:yt_clone/music_player/widgets/export.dart';

class DetailPlayer extends StatefulWidget {
  const DetailPlayer({super.key, required this.index});
  final int index;

  @override
  State<DetailPlayer> createState() => _DetailPlayerState();
}

class _DetailPlayerState extends State<DetailPlayer> {
  late ValueNotifier<int> indexPlaying;
  @override
  void initState() {
    songPlayerController
        .playSong(songPlayerController.songList[widget.index].uri);
    indexPlaying = ValueNotifier(widget.index);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
      ),
      body: SafeArea(
        child: ValueListenableBuilder(
            valueListenable: indexPlaying,
            builder: (context, val, child) {
              return Obx(() {
                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: 20.w, vertical: 10.h),
                      child: QueryArtworkWidget(
                        artworkFit: BoxFit.contain,
                        artworkHeight: 240.h,
                        artworkWidth: 1.sw,
                        artworkQuality: FilterQuality.high,
                        artworkBorder: BorderRadius.circular(10.r),
                        id: songPlayerController.songList[val].id,
                        type: ArtworkType.AUDIO,
                        nullArtworkWidget: const FaIcon(
                          FontAwesomeIcons.music,
                          color: Colors.white,
                          size: 40,
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    Text(
                      songPlayerController.songList[val].title,
                      style: GoogleFonts.poppins(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                    ),
                    Text(
                      songPlayerController.songList[val].artist ?? '',
                      style: GoogleFonts.poppins(
                          fontSize: 16, color: Colors.white54),
                    ),
                    const SizedBox(height: 20),
                    Obx(() {
                      Duration position =
                          songPlayerController.currentPosition.value;
                      Duration totalDuration =
                          songPlayerController.totalDuration.value;

                      debugPrint(
                          "Position: $position \t\t Total Duration: $totalDuration");

                      return Column(
                        children: [
                          Slider(
                            allowedInteraction: SliderInteraction.slideThumb,
                            value: totalDuration.inSeconds > 0
                                ? position.inSeconds.toDouble() /
                                    totalDuration.inSeconds.toDouble()
                                : 0.0,
                            onChanged: (value) {
                              if (totalDuration.inSeconds > 0) {
                                final newPosition = Duration(
                                    seconds: (value * totalDuration.inSeconds)
                                        .toInt());
                                songPlayerController.seekTo(newPosition);
                              }
                            },
                            activeColor: Colors.red,
                            inactiveColor: Colors.white24,
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 30),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  formatDuration(position),
                                  style: const TextStyle(color: Colors.white54),
                                ),
                                Text(
                                  formatDuration(totalDuration),
                                  style: const TextStyle(color: Colors.white54),
                                ),
                              ],
                            ),
                          ),
                        ],
                      );
                    }),
                    const SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        IconButton(
                          icon: const Icon(Icons.skip_previous,
                              color: Colors.white, size: 40),
                          onPressed: () {
                            if (indexPlaying.value > 0) {
                              indexPlaying.value -= 1;
                              songPlayerController.playSong(songPlayerController
                                  .songList[indexPlaying.value].uri);
                            }
                          },
                        ),
                        const SizedBox(width: 20),
                        Obx(() {
                          var playing = songPlayerController.isPlaying.value;

                          return Container(
                            decoration: const BoxDecoration(
                                color: Colors.red, shape: BoxShape.circle),
                            child: IconButton(
                              icon: Icon(
                                playing ? Icons.pause : Icons.play_arrow,
                                color: Colors.white,
                                size: 40,
                              ),
                              onPressed: () {
                                if (playing) {
                                  songPlayerController.pauseSong();
                                } else {
                                  songPlayerController.resumeSong();
                                }
                              },
                            ),
                          );
                        }),
                        const SizedBox(width: 20),
                        IconButton(
                          icon: const Icon(Icons.skip_next,
                              color: Colors.white, size: 40),
                          onPressed: () {
                            if (indexPlaying.value <
                                songPlayerController.songList.length - 1) {
                              indexPlaying.value += 1;
                              songPlayerController.playSong(songPlayerController
                                  .songList[indexPlaying.value].uri);
                            }
                          },
                        ),
                      ],
                    )
                  ],
                );
              });
            }),
      ),
    );
  }
}
