import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

import 'package:on_audio_query/on_audio_query.dart';
import 'package:yt_clone/music_player/ui/detail_view.dart';

import '../getx_file/fetch_songs.dart';

class HomeScreenPlayer extends StatelessWidget {
  const HomeScreenPlayer({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: EdgeInsets.only(bottom: 80.h),
      shrinkWrap: true,
      itemCount: songPlayerController.songList.length,
      itemBuilder: (context, index) {
        var data = songPlayerController.songList[index];
        return ListTile(
          onTap: () {
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
            data.artist == '<unknown>' ? 'Unknown Artist' : data.artist!,
            style: TextStyle(
              color: Get.isDarkMode ? Colors.white70 : Colors.black87,
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
        );
      },
    );
  }
}
