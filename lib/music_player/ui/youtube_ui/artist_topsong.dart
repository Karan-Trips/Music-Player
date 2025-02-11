import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:dart_ytmusic_api/types.dart';
import 'package:get/get.dart';
import 'package:yt_clone/music_player/getx_file/fetch_songs.dart';
import 'package:yt_clone/music_player/ui/detail_view.dart';

class ArtistSongsPage extends StatelessWidget {
  final ArtistFull artist;

  const ArtistSongsPage({super.key, required this.artist});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:
          Get.isDarkMode ? const Color.fromRGBO(12, 17, 43, 1) : Colors.white,
      appBar: AppBar(
        centerTitle: true,
        title: Text(artist.name),
        backgroundColor: Colors.transparent,
      ),
      body: ListView.builder(
        itemCount: artist.topSongs.length,
        itemBuilder: (context, index) {
          final song = artist.topSongs[index];

          return ListTile(
            leading: song.thumbnails.isNotEmpty
                ? Image.network(
                    song.thumbnails.last.url,
                    width: 50.w,
                    height: 50.h,
                  )
                : const Icon(Icons.music_note, color: Colors.white70),
            title: Text(
              song.name,
              style: TextStyle(color: Colors.white, fontSize: 14.sp),
            ),
            subtitle: Text(
              song.artist.name,
              style: TextStyle(color: Colors.white70, fontSize: 12.sp),
            ),
            onTap: () {
              print("Selected song:$index");
              if (artist.topSongs.isNotEmpty) {
                songPlayerController.indexPlaying.value = index;
                Get.to(() => DetailPlayer(
                      index: index,
                      isFromArtist: true,
                      isYt: true,
                      song: song,
                    ));
              } else {
                print("⚠️ No songs available to play.");
              }
            },
          );
        },
      ),
    );
  }
}
