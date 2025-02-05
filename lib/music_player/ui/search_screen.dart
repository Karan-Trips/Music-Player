import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../getx_file/search_get.dart';
import 'detail_view.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      appBar: AppBar(
        title: TextField(
          onChanged: (query) => searchController.filterSongs(query),
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
        if (searchController.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }
        if (searchController.filteredSongs.isEmpty) {
          return const Center(
              child: Text("No Songs Found",
                  style: TextStyle(color: Colors.white70)));
        }
        return ListView.builder(
          itemCount: searchController.filteredSongs.length,
          itemBuilder: (context, index) {
            var song = searchController.filteredSongs[index];
            return ListTile(
              onTap: () {
                Get.to(() => DetailPlayer(index: index));
              },
              title: Text(
                song.title,
                style: const TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                    overflow: TextOverflow.ellipsis),
              ),
              subtitle: Text(
                song.artist == '<unknown>' ? 'Unknown Artist' : song.artist!,
                style: const TextStyle(
                    color: Colors.white70,
                    fontSize: 12,
                    overflow: TextOverflow.ellipsis),
              ),
              leading: QueryArtworkWidget(
                id: song.id,
                type: ArtworkType.AUDIO,
                nullArtworkWidget:
                    const Icon(FontAwesomeIcons.music, color: Colors.white70),
              ),
            );
          },
        );
      }),
    );
  }
}
