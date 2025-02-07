import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:yt_clone/music_player/getx_file/fetch_songs.dart';
import 'package:yt_clone/music_player/ui/detail_view.dart';

import '../getx_file/ui_getx_change.dart';

class FavoriteSongsPage extends StatelessWidget {
  const FavoriteSongsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.search,
            ),
          ),
        ],
      ),
      body: Obx(() {
        return navController.likedSongs.isNotEmpty
            ? ListView.builder(
                itemCount: navController.likedSongs.length,
                itemBuilder: (context, index) {
                  var data = songPlayerController.songList[index];
                  int songId = navController.likedSongs[index];
                  return ListTile(
                      onTap: () {
                        songPlayerController.indexPlaying.value = index;

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
                        icon: const Icon(Icons.favorite, color: Colors.pink),
                        onPressed: () {
                          navController.toggelLike(songId);
                        },
                      ));
                },
              )
            : const Center(
                child: Text(
                  "No favorite songs yet!",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                ),
              );
      }),
    );
  }
}
