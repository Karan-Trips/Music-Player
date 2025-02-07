import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:music_visualizer/music_visualizer.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:yt_clone/music_player/getx_file/fetch_songs.dart';
import 'package:yt_clone/music_player/ui/home_screen_main.dart';
import 'package:yt_clone/music_player/widgets/export.dart';

import '../widgets/scrooling_text.dart';

class DetailPlayer extends StatefulWidget {
  const DetailPlayer(
      {super.key, required this.index, this.isFromBottomPlayer = false});
  final int index;
  final bool isFromBottomPlayer;

  @override
  State<DetailPlayer> createState() => _DetailPlayerState();
}

class _DetailPlayerState extends State<DetailPlayer> {
  @override
  void initState() {
    super.initState();

    if (!widget.isFromBottomPlayer) {
      songPlayerController.indexPlaying.value = widget.index;

      songPlayerController
          .playSong(songPlayerController.songList[widget.index].uri);
    }
  }

  final List<Color> colors = [
    Colors.red[900]!,
    Colors.green[900]!,
    Colors.blue[900]!,
    Colors.brown[900]!
  ];

  final List<int> duration = [900, 1000, 600, 800, 500];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          elevation: 0.0,
        ),
        body: SafeArea(
          child: ValueListenableBuilder<int>(
              valueListenable: songIndex,
              builder: (context, valu, child) {
                return Obx(() {
                  int currentIndex = widget.index;
                  songPlayerController.indexPlaying.value = widget.index;

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
                            id: songPlayerController
                                .songList[valu != -1 ? valu : currentIndex].id,
                            type: ArtworkType.AUDIO,
                            nullArtworkWidget: Container(
                              height: 240.h,
                              width: 1.sw,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10.r),
                              ),
                              child: MusicVisualizer(
                                curve: Curves.easeInCubic,
                                barCount: 30,
                                colors: colors,
                                duration: duration,
                              ),
                            ),
                          )),
                      const SizedBox(height: 20),
                      SizedBox(
                        height: 30.h,
                        child: ScrollingText(
                          text:
                              songPlayerController.songList[currentIndex].title,
                          textStyle: GoogleFonts.poppins(
                            fontSize: 20.sp,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      Text(
                        songPlayerController.songList[currentIndex].artist ??
                            '',
                        style: GoogleFonts.poppins(
                            fontSize: 16, color: Colors.white54),
                      ),
                      const SizedBox(height: 20),
                      Obx(() {
                        Duration position =
                            songPlayerController.currentPosition.value;
                        Duration totalDuration =
                            songPlayerController.totalDuration.value;

                        return Column(
                          children: [
                            Slider(
                              divisions: null,
                              min: 0.0,
                              max: totalDuration.inSeconds > 0
                                  ? totalDuration.inSeconds.toDouble()
                                  : 1.0,
                              value: position.inSeconds.toDouble().clamp(
                                  0.0, totalDuration.inSeconds.toDouble()),
                              onChanged: (value) {
                                final newPosition =
                                    Duration(seconds: value.toInt());
                                songPlayerController.seekTo(newPosition);
                              },
                              activeColor: Colors.red,
                              inactiveColor: Colors.white24,
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 30),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(formatDuration(position),
                                      style: const TextStyle(
                                          color: Colors.white54)),
                                  Text(formatDuration(totalDuration),
                                      style: const TextStyle(
                                          color: Colors.white54)),
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
                              songPlayerController.playPreviousSong();
                            },
                          ),
                          const SizedBox(width: 20),
                          Obx(() {
                            return Container(
                              decoration: const BoxDecoration(
                                color: Colors.red,
                                shape: BoxShape.circle,
                              ),
                              child: IconButton(
                                icon: Icon(
                                  songPlayerController.isPlaying.value
                                      ? Icons.pause
                                      : Icons.play_arrow,
                                  color: Colors.white,
                                  size: 40,
                                ),
                                onPressed: () {
                                  if (songPlayerController.isPlaying.value) {
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
                              songPlayerController.playNextSong();
                            },
                          ),
                        ],
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(
                            vertical: 8.h, horizontal: 35.w),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Obx(() {
                              return InkWell(
                                onTap: () => songPlayerController.repeatSong(),
                                child: Icon(songPlayerController.inRepeat.value
                                    ? CupertinoIcons.repeat_1
                                    : CupertinoIcons.repeat),
                              );
                            }),
                          ],
                        ),
                      ),
                    ],
                  );
                });
              }),
        ));
  }
}
