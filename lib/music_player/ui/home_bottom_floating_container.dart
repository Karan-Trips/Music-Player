import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:music_visualizer/music_visualizer.dart';
import 'package:on_audio_query/on_audio_query.dart';

import 'package:yt_clone/music_player/getx_file/fetch_songs.dart';
import 'package:yt_clone/music_player/widgets/utilis.dart';

class HomeBottomPlayer extends StatefulWidget {
  const HomeBottomPlayer({super.key});

  @override
  State<HomeBottomPlayer> createState() => _HomeBottomPlayerState();
}

class _HomeBottomPlayerState extends State<HomeBottomPlayer> {
  final SongPlayerController controller = Get.find<SongPlayerController>();
  final List<Color> colors = [
    Colors.red[900]!,
    Colors.green[900]!,
    Colors.blue[900]!,
    Colors.brown[900]!
  ];

  final List<int> duration = [900, 1000, 600, 800, 500];
  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Padding(
        padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 8.0.h),
        child: ClipRect(
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 4, sigmaY: 4),
            child: Container(
              height: 65.h,
              decoration: BoxDecoration(
                color: Get.isDarkMode
                    ? const Color.fromARGB(115, 179, 178, 194)
                    : Colors.white,
                borderRadius: BorderRadius.circular(30),
              ),
              padding: EdgeInsets.symmetric(horizontal: 10.w),
              child: Row(
                children: [
                  Obx(() {
                    return QueryArtworkWidget(
                      artworkFit: BoxFit.contain,
                      artworkHeight: 40.h,
                      artworkWidth: 50.w,
                      artworkQuality: FilterQuality.high,
                      artworkBorder: BorderRadius.circular(10.r),
                      id: songPlayerController
                          .songList[controller.indexPlaying.value].id,
                      type: ArtworkType.AUDIO,
                      nullArtworkWidget: Container(
                        height: 40.h,
                        width: 50.w,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10.r),
                        ),
                        child: MusicVisualizer(
                          curve: Curves.easeInCubic,
                          barCount: 5,
                          colors: colors,
                          duration: duration,
                        ),
                      ),
                    );
                  }),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          controller.songList.isNotEmpty
                              ? controller
                                  .songList[controller.indexPlaying.value]
                                  .displayName
                              : 'No song playing',
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            color: Colors.black,
                            fontSize: 13,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Obx(() => Text(
                              formatDuration(controller.currentPosition.value),
                              style: const TextStyle(
                                color: Colors.grey,
                                fontSize: 11,
                                fontWeight: FontWeight.bold,
                              ),
                            )),
                        SizedBox(height: 6.h),
                        Obx(() => SizedBox(
                              width: 120.h,
                              child: LinearProgressIndicator(
                                color: Colors.redAccent,
                                valueColor:
                                    const AlwaysStoppedAnimation(Colors.red),
                                borderRadius: BorderRadius.circular(10.r),
                                backgroundColor: Colors.grey.withOpacity(0.7),
                                value: (controller
                                            .totalDuration.value.inSeconds >
                                        0)
                                    ? controller
                                            .currentPosition.value.inSeconds /
                                        controller.totalDuration.value.inSeconds
                                    : 0,
                              ),
                            ))
                      ],
                    ),
                  ),
                  const SizedBox(width: 20),
                  Row(
                    children: [
                      IconButton(
                        onPressed: () {
                          controller.playPreviousSong();
                        },
                        icon: const Icon(Icons.skip_previous),
                      ),
                      const SizedBox(width: 10),
                      Obx(() => IconButton(
                            onPressed: () {
                              if (controller.isPlaying.value) {
                                controller.pauseSong();
                              } else {
                                controller.resumeSong();
                              }
                            },
                            icon: Icon(
                              controller.isPlaying.value
                                  ? Icons.pause
                                  : Icons.play_arrow,
                              size: 25,
                              color: controller.isPlaying.value
                                  ? Colors.red
                                  : Colors.black,
                            ),
                          )),
                      const SizedBox(width: 10),
                      IconButton(
                        onPressed: () {
                          controller.playNextSong();
                        },
                        icon: const Icon(Icons.skip_next),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    });
  }
}
