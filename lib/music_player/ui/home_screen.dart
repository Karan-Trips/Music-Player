import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:yt_clone/music_player/ui/detail_view.dart';

import '../getx_file/fetch_songs.dart';

class HomeScreenPlayer extends StatelessWidget {
  const HomeScreenPlayer({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          ListView.builder(
            padding: EdgeInsets.only(bottom: 80.h),
            shrinkWrap: true,
            itemCount: songPlayerController.songList.length,
            itemBuilder: (context, index) {
              var data = songPlayerController.songList[index];
              return Obx(() {
                bool isPlaying = songPlayerController.isPlaying.value &&
                    songPlayerController.indexPlaying.value == index;

                return Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10.w),
                  child: Container(
                    margin: EdgeInsets.only(bottom: 8.h),
                    decoration: BoxDecoration(
                      color: index % 2 == 0
                          ? Get.isDarkMode
                              ? const Color.fromRGBO(30, 33, 58, 1)
                              : const Color.fromARGB(255, 243, 213, 213)
                          : Get.isDarkMode
                              ? const Color.fromARGB(255, 12, 17, 43)
                              : const Color.fromARGB(255, 211, 214, 242),
                      borderRadius: BorderRadius.circular(10.r),
                    ),
                    child: ListTile(
                      onTap: () {
                        songPlayerController.indexPlaying.value = index;
                        print("index=====_---$index");
                        Get.to(() => DetailPlayer(index: index));
                      },
                      title: Text(
                        data.title,
                        style: TextStyle(
                          color: Get.isDarkMode ? Colors.white : Colors.black,
                          overflow: TextOverflow.ellipsis,
                          fontSize: 13.sp,
                          fontStyle: FontStyle.italic,
                        ),
                      ),
                      subtitle: Text(
                        data.artist == '<unknown>'
                            ? 'Unknown Artist'
                            : data.artist!,
                        style: TextStyle(
                          color:
                              Get.isDarkMode ? Colors.white70 : Colors.black87,
                          overflow: TextOverflow.ellipsis,
                          fontSize: 12.sp,
                          fontStyle: FontStyle.italic,
                        ),
                      ),
                      leading: QueryArtworkWidget(
                        id: data.id,
                        artworkWidth: 45.w,
                        artworkBorder: BorderRadius.circular(10.r),
                        artworkFit: BoxFit.cover,
                        artworkQuality: FilterQuality.high,
                        keepOldArtwork: true,
                        type: ArtworkType.AUDIO,
                        nullArtworkWidget: Container(
                          width: 45.w,
                          padding: EdgeInsets.only(left: 10.w),
                          child: FaIcon(
                            FontAwesomeIcons.music,
                            color: Get.isDarkMode ? Colors.white : Colors.black,
                          ),
                        ),
                      ),
                      trailing: IconButton(
                        icon: Icon(
                          isPlaying ? Icons.pause : Icons.play_arrow,
                          color: isPlaying ? Colors.red : Colors.white,
                        ),
                        onPressed: () {
                          if (isPlaying) {
                            songPlayerController.pauseSong();
                          } else {
                            songPlayerController.indexPlaying.value = index;

                            songPlayerController.playSong(data.uri);
                          }
                        },
                      ),
                    ),
                  ),
                );
              });
            },
          ),
        ],
      ),
    );
  }
}
