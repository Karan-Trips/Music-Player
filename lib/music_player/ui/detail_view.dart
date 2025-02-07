import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:marquee/marquee.dart';
import 'package:music_visualizer/music_visualizer.dart';
import 'package:on_audio_query/on_audio_query.dart';

import 'package:yt_clone/music_player/getx_file/fetch_songs.dart';
import 'package:yt_clone/music_player/widgets/export.dart';
import 'package:volume_controller/volume_controller.dart';

import '../getx_file/ui_getx_change.dart';

class DetailPlayer extends StatefulWidget {
  const DetailPlayer(
      {super.key, required this.index, this.isFromBottomPlayer = false});
  final int index;
  final bool isFromBottomPlayer;

  @override
  State<DetailPlayer> createState() => _DetailPlayerState();
}

class _DetailPlayerState extends State<DetailPlayer> {
  OverlayEntry? _overlayEntry;

  final LayerLink _layerLink = LayerLink();
  RxDouble volume = 50.0.obs;

  @override
  void initState() {
    super.initState();

    VolumeController.instance.getVolume().then((vol) {
      volume.value = vol * 100;
    });

    if (!widget.isFromBottomPlayer) {
      Future.delayed(const Duration(milliseconds: 100), () {
        songPlayerController.indexPlaying.value = widget.index;
        songPlayerController
            .playSong(songPlayerController.songList[widget.index].uri);
      });
    }
  }

  void _showVolumeOverlay(BuildContext context) {
    if (_overlayEntry != null) return;

    _overlayEntry = OverlayEntry(
      builder: (context) => Positioned(
        right: 95.w,
        bottom: 250.h,
        child: Material(
          color: Colors.transparent,
          child: CompositedTransformFollower(
            link: _layerLink,
            offset: const Offset(0, -100),
            child: Obx(() => Container(
                  width: 50.w,
                  height: 200.h,
                  decoration: BoxDecoration(
                    color: Colors.black.withOpacity(0.8),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: Column(
                    children: [
                      const Icon(Icons.volume_up,
                          color: Colors.white, size: 20),
                      Expanded(
                        child: RotatedBox(
                          quarterTurns: -1,
                          child: Slider(
                            value: songPlayerController.volume.value,
                            min: 0,
                            max: 100,
                            activeColor: Colors.blue,
                            inactiveColor: Colors.grey.shade300,
                            onChanged: (value) {
                              songPlayerController.volume.value = value;

                              VolumeController.instance.setVolume(value / 100);
                            },
                          ),
                        ),
                      ),
                      const Icon(Icons.volume_down,
                          color: Colors.white, size: 20),
                    ],
                  ),
                )),
          ),
        ),
      ),
    );

    Overlay.of(context).insert(_overlayEntry!);
  }

  void _removeOverlay() {
    _overlayEntry?.remove();
    _overlayEntry = null;
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
        backgroundColor: Get.isDarkMode
            ? const Color.fromRGBO(30, 33, 58, 1)
            : const Color.fromARGB(255, 255, 255, 255),
        appBar: AppBar(
            backgroundColor: Get.isDarkMode
                ? const Color.fromRGBO(30, 33, 58, 1)
                : const Color.fromARGB(255, 255, 255, 255),
            toolbarHeight: 50.h,
            centerTitle: true,
            titleTextStyle:
                TextStyle(color: Get.isDarkMode ? Colors.white : Colors.black),
            elevation: 0.0,
            title: Text("Now Playing",
                style: TextStyle(
                  fontSize: 18.sp,
                )),
            leading: IconButton(
                onPressed: () {
                  Get.back();
                },
                icon: Icon(
                  Icons.arrow_back_ios,
                  color: Get.isDarkMode ? Colors.white : Colors.black,
                  size: 20.sp,
                ))),
        body: SafeArea(
          child: Obx(() {
            int currentIndex = songPlayerController.indexPlaying.value;

            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
                    child: QueryArtworkWidget(
                      artworkFit: BoxFit.contain,
                      artworkHeight: 240.h,
                      artworkWidth: 1.sw,
                      artworkQuality: FilterQuality.high,
                      artworkBorder: BorderRadius.circular(15.r),
                      id: songPlayerController.songList[currentIndex].id,
                      type: ArtworkType.AUDIO,
                      nullArtworkWidget: Container(
                        height: 240.h,
                        width: 1.sw,
                        decoration: BoxDecoration(
                          gradient: LinearGradient(colors: [
                            Get.isDarkMode
                                ? const Color.fromARGB(255, 108, 118, 212)
                                : const Color.fromARGB(121, 124, 121, 121),
                            Get.isDarkMode
                                ? const Color.fromARGB(255, 171, 171, 175)
                                : const Color.fromARGB(238, 172, 142, 142)
                          ]),
                          borderRadius: BorderRadius.circular(15.r),
                        ),
                        child: MusicVisualizer(
                          curve: Curves.easeInCubic,
                          barCount: 50,
                          colors: colors,
                          duration: duration,
                        ),
                      ),
                    )),
                const SizedBox(height: 20),
                SizedBox(
                  height: 30.h,
                  child: Marquee(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    fadingEdgeStartFraction: 0.2,
                    fadingEdgeEndFraction: 0.2,
                    accelerationCurve: Curves.fastLinearToSlowEaseIn,
                    blankSpace: 200,
                    decelerationCurve: Curves.easeOut,
                    text: songPlayerController.songList[currentIndex].title,
                    style: GoogleFonts.poppins(
                      fontSize: 20.sp,
                      fontWeight: FontWeight.bold,
                      color: Get.isDarkMode ? Colors.white : Colors.black,
                    ),
                  ),
                ),
                Text(
                  songPlayerController.songList[currentIndex].artist ?? '',
                  style: GoogleFonts.poppins(
                    fontSize: 16.sp,
                    color: Get.isDarkMode ? Colors.white54 : Colors.black,
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    IconButton(
                      icon: Icon(
                        navController.isLiked.value
                            ? Icons.favorite
                            : Icons.favorite_border,
                        size: 25.sp,
                      ),
                      onPressed: () {
                        navController.toggelLike(currentIndex);
                      },
                      color: navController.isLiked.value
                          ? Colors.pink
                          : Colors.red,
                    ),
                    // 80.horizontalSpace,
                    Padding(
                      padding: EdgeInsets.only(right: 15.w),
                      child: IconButton(
                        icon: Icon(Icons.volume_down,
                            color: Get.isDarkMode ? Colors.white : Colors.black,
                            size: 30.sp),
                        onPressed: () {
                          if (_overlayEntry == null) {
                            _showVolumeOverlay(context);
                          } else {
                            _removeOverlay();
                          }
                        },
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 5.h),
                Obx(() {
                  Duration position =
                      songPlayerController.currentPosition.value;
                  Duration totalDuration =
                      songPlayerController.totalDuration.value;

                  return Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Slider(
                        min: 0.0,
                        max: totalDuration.inSeconds > 0
                            ? totalDuration.inSeconds.toDouble()
                            : 1.0,
                        value: position.inSeconds
                            .toDouble()
                            .clamp(0.0, totalDuration.inSeconds.toDouble()),
                        onChanged: (value) {
                          final newPosition = Duration(seconds: value.toInt());
                          songPlayerController.seekTo(newPosition);
                        },
                        activeColor: Colors.pink,
                        inactiveColor: Colors.white,
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 30.w),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(formatDuration(position),
                                style: TextStyle(
                                  color: Get.isDarkMode
                                      ? Colors.white54
                                      : Colors.black,
                                )),
                            Text(formatDuration(totalDuration),
                                style: TextStyle(
                                  color: Get.isDarkMode
                                      ? Colors.white54
                                      : Colors.black,
                                )),
                          ],
                        ),
                      ),
                    ],
                  );
                }),
                SizedBox(height: 15.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    IconButton(
                      icon: Icon(Icons.skip_previous,
                          color: Get.isDarkMode ? Colors.white : Colors.black,
                          size: 40.sp),
                      onPressed: () {
                        songPlayerController.playPreviousSong();
                      },
                    ),
                    SizedBox(width: 20.w),
                    Obx(() {
                      return Container(
                        decoration: const BoxDecoration(
                          color: Colors.pink,
                          shape: BoxShape.circle,
                        ),
                        child: IconButton(
                          icon: Icon(
                            songPlayerController.isPlaying.value
                                ? Icons.pause
                                : Icons.play_arrow,
                            color: Colors.white,
                            size: 40.sp,
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
                    SizedBox(width: 20.w),
                    IconButton(
                      icon: Icon(Icons.skip_next,
                          color: Get.isDarkMode ? Colors.white : Colors.black,
                          size: 40.sp),
                      onPressed: () {
                        songPlayerController.playNextSong();
                      },
                    ),
                  ],
                ),
                Padding(
                  padding:
                      EdgeInsets.symmetric(vertical: 8.h, horizontal: 35.w),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Obx(() {
                        return InkWell(
                          onTap: () => songPlayerController.repeatSong(),
                          child: Icon(
                            songPlayerController.inRepeat.value
                                ? Icons.repeat_one
                                : Icons.loop_outlined,
                            size: 28.sp,
                          ),
                        );
                      }),
                    ],
                  ),
                ),
              ],
            );
          }),
        ));
  }
}
