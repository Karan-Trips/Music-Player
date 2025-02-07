import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:yt_clone/music_player/ui/detail_view.dart';
import 'package:yt_clone/music_player/ui/yt_screen.dart';

import '../getx_file/yt/yt_search.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      appBar: AppBar(
        title: TextField(
          onChanged: (query) {
            searchController2.searchSongs(query);
          },
          decoration: const InputDecoration(
            hintText: "Search Songs...",
            border: InputBorder.none,
            hintStyle: TextStyle(color: Colors.white70),
            prefixIcon: Icon(Icons.search, color: Colors.white),
          ),
          style: const TextStyle(color: Colors.white),
          cursorColor: Colors.white,
        ),
        backgroundColor: Colors.black,
      ),
      body: Obx(() {
        if (searchController2.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }
        if (searchController2.searchResults.isEmpty) {
          return const Center(
              child: Text("No Songs Found",
                  style: TextStyle(color: Colors.white70)));
        }
        return ListView.builder(
          itemCount: searchController2.searchResults.length,
          itemBuilder: (context, index) {
            var song = searchController2.searchResults[index];

            return ListTile(
              onTap: () {
                var id = searchController2.searchResults[index].videoId;
                Get.to(() => YoutubeScreenOnline(id: id));
              },
              title: Text(
                song.name,
                style: const TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                    overflow: TextOverflow.ellipsis),
              ),
              subtitle: Text(
                song.artist.name,
                style: const TextStyle(
                    color: Colors.white70,
                    fontSize: 12,
                    overflow: TextOverflow.ellipsis),
              ),
              leading: song.thumbnails[0].url != ''
                  ? Image.network(song.thumbnails[0].url, width: 50, height: 50)
                  : const Icon(Icons.music_note, color: Colors.white70),
            );
          },
        );
      }),
    );
  }
}
