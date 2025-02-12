import 'package:dart_ytmusic_api/types.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:marquee/marquee.dart';
import 'package:music_visualizer/music_visualizer.dart';
import 'package:on_audio_query/on_audio_query.dart';

import 'package:yt_clone/music_player/getx_file/fetch_songs.dart';
import 'package:yt_clone/music_player/getx_file/yt/yt_search.dart';

import 'package:yt_clone/music_player/widgets/export.dart';

import '../getx_file/ui_getx_change.dart';

class DetailPlayer extends StatefulWidget {
  const DetailPlayer({
    super.key,
    required this.index,
    this.isFromBottomPlayer = false,
    this.isYt = false,
    this.isFromArtist = false,
    this.isFromHome = false,
    this.song,
  });
  final int index;
  final bool isFromBottomPlayer;
  final bool isYt;
  final bool isFromArtist;
  final bool isFromHome;
  final SongDetailed? song;

  @override
  State<DetailPlayer> createState() => _DetailPlayerState();
}

class _DetailPlayerState extends State<DetailPlayer> {
  @override
  void initState() {
    super.initState();

    if (widget.isYt) {
      print(
          "id---->${searchController2.searchArtists[widget.index].topSongs[widget.index].videoId}");
      songPlayerController.playSong(
        isYt: true,
        widget.isFromArtist
            ? widget.song?.videoId
            : searchController2.searchResults[widget.index].videoId,
      );
    } else if (widget.isFromHome) {
      songPlayerController.indexPlaying.value = widget.index;

      songPlayerController.playSong(
        songPlayerController.songList[widget.index].uri,
      );
    } else {
      if (!widget.isFromBottomPlayer) {
        songPlayerController.indexPlaying.value = widget.index;

        songPlayerController.playSong(
          songPlayerController.songList[widget.index].uri,
        );
      }
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
            var data;
            String nameArtist;
            String songName;
            String thumbnailUrl;

            if (widget.isFromArtist) {
              data = widget.song!;
              nameArtist = data.artist.name;
              songName = data.name;
              thumbnailUrl = data.thumbnails.last.url;
            } else if (widget.isFromHome) {
              data = songPlayerController.songList[widget.index];
              nameArtist = data.displayName;
              songName = data.title;
              thumbnailUrl = "";
            } else {
              data = searchController2.searchResults[widget.index];
              nameArtist = data.artist.name;
              songName = data.name;
              thumbnailUrl = data.thumbnails.last.url;
            }

            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
                    child: widget.isYt
                        ? Container(
                            height: 240.h,
                            width: 1.sw,
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                filterQuality: FilterQuality.high,
                                image: NetworkImage(
                                  thumbnailUrl,
                                ),
                                fit: BoxFit.contain,
                              ),
                              gradient: LinearGradient(
                                colors: [
                                  Get.isDarkMode
                                      ? const Color.fromARGB(255, 108, 118, 212)
                                      : const Color.fromARGB(
                                          121, 124, 121, 121),
                                  Get.isDarkMode
                                      ? const Color.fromARGB(255, 171, 171, 175)
                                      : const Color.fromARGB(238, 172, 142, 142)
                                ],
                              ),
                              borderRadius: BorderRadius.circular(15.r),
                            ),
                          )
                        : QueryArtworkWidget(
                            artworkFit: BoxFit.contain,
                            keepOldArtwork: true,
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
                                gradient: LinearGradient(
                                  colors: [
                                    Get.isDarkMode
                                        ? const Color.fromARGB(
                                            255, 108, 118, 212)
                                        : const Color.fromARGB(
                                            121, 124, 121, 121),
                                    Get.isDarkMode
                                        ? const Color.fromARGB(
                                            255, 171, 171, 175)
                                        : const Color.fromARGB(
                                            238, 172, 142, 142)
                                  ],
                                ),
                                borderRadius: BorderRadius.circular(15.r),
                              ),
                              child: MusicVisualizer(
                                curve: Curves.easeInCubic,
                                barCount: 50,
                                colors: colors,
                                duration: duration,
                              ),
                            ),
                          ),
                  ),
                ),
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
                    text: widget.isYt
                        ? songName
                        : songPlayerController.songList[currentIndex].title,
                    style: GoogleFonts.poppins(
                      fontSize: 20.sp,
                      fontWeight: FontWeight.bold,
                      color: Get.isDarkMode ? Colors.white : Colors.black,
                    ),
                  ),
                ),
                Text(
                  widget.isYt
                      ? nameArtist
                      : songPlayerController.songList[currentIndex].artist ??
                          '',
                  style: GoogleFonts.poppins(
                    fontSize: 16.sp,
                    color: Get.isDarkMode ? Colors.white54 : Colors.black,
                  ),
                ),
                Obx(() {
                  return IconButton(
                    icon: Icon(
                      navController.likedSongs.contains(currentIndex)
                          ? Icons.favorite
                          : Icons.favorite_border,
                      size: 25.sp,
                    ),
                    onPressed: () {
                      navController.toggelLike(currentIndex);
                    },
                    color: navController.likedSongs.contains(currentIndex)
                        ? Colors.pink
                        : Colors.red,
                  );
                }),
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
                        child: songPlayerController.isLoading.value
                            ? const Padding(
                                padding: EdgeInsets.all(12.0),
                                child: CircularProgressIndicator(
                                  color: Colors.white,
                                ),
                              )
                            : IconButton(
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
