import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:yt_clone/music_player/ui/detail_view.dart';
import 'package:yt_clone/music_player/ui/youtube_ui/artist_topsong.dart';

import '../../getx_file/yt/yt_search.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  @override
  void initState() {
    super.initState();
    searchController2.searchResults.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:
          Get.isDarkMode ? const Color.fromRGBO(12, 17, 43, 1) : Colors.white,
      extendBody: true,
      appBar: AppBar(
        title: TextField(
          onChanged: (query) => searchController2.searchSongs(query),
          decoration: const InputDecoration(
            hintText: "Search Songs...",
            border: InputBorder.none,
            hintStyle: TextStyle(color: Colors.white70),
            prefixIcon: Icon(Icons.search, color: Colors.white),
          ),
          style: const TextStyle(color: Colors.white),
          cursorColor: Colors.white,
        ),
        backgroundColor: Colors.transparent,
      ),
      body: Obx(() {
        if (searchController2.isLoading.value) {
          return Center(
              child: LoadingAnimationWidget.staggeredDotsWave(
                  color: Colors.red, size: 40.sp));
        }

        if (searchController2.searchResults.isEmpty) {
          return searchController2.searchArtists.isNotEmpty
              ? _buildArtistGrid()
              : Center(
                  child: LoadingAnimationWidget.staggeredDotsWave(
                      color: Colors.red, size: 40.sp));
        }

        return _buildSongList();
      }),
    );
  }

  Widget _buildArtistGrid() {
    return GridView.builder(
      itemCount: searchController2.searchArtists.length,
      padding: EdgeInsets.all(10.r),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 20.w,
        mainAxisSpacing: 20.h,
      ),
      itemBuilder: (context, index) {
        final artist = searchController2.searchArtists[index];

        return InkWell(
          onTap: () {
            Get.to(
              () => ArtistSongsPage(
                artist: artist,
              ),
            );
          },
          child: Column(
            children: [
              CircleAvatar(
                radius: 50.r,
                backgroundImage: NetworkImage(
                  artist.thumbnails.last.url,
                ),
              ),
              SizedBox(height: 5.h),
              Text(
                artist.name,
                textAlign: TextAlign.center,
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14.sp),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildSongList() {
    return ListView.builder(
      itemCount: searchController2.searchResults.length,
      itemBuilder: (context, index) {
        var song = searchController2.searchResults[index];

        return ListTile(
          onTap: () {
            Get.to(() => DetailPlayer(index: index, isYt: true));
          },
          title: Text(
            song.name,
            style: TextStyle(
              color: Colors.white,
              fontSize: 14.sp,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          subtitle: Text(
            song.artist.name,
            style: TextStyle(
              color: Colors.white70,
              fontSize: 12.sp,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          leading: song.thumbnails.isNotEmpty && song.thumbnails[0].url != ''
              ? Image.network(song.thumbnails[0].url, width: 50.w, height: 50.h)
              : const Icon(Icons.music_note, color: Colors.white70),
        );
      },
    );
  }
}
