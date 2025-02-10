import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:dart_ytmusic_api/types.dart';

class ArtistSongsPage extends StatelessWidget {
  final ArtistFull artist;

  const ArtistSongsPage({super.key, required this.artist});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(artist.name),
        backgroundColor: Colors.black,
      ),
      body: artist.topSongs.isEmpty
          ? const Center(
              child: Text(
                "No Songs Available",
                style: TextStyle(color: Colors.white),
              ),
            )
          : ListView.builder(
              itemCount: artist.topSongs.length,
              itemBuilder: (context, index) {
                final song = artist.topSongs[index];

                return ListTile(
                  leading: song.thumbnails.isNotEmpty
                      ? Image.network(song.thumbnails.last.url,
                          width: 50.w, height: 50.h)
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
                    print("Play ${song.name}");
                  },
                );
              },
            ),
    );
  }
}
