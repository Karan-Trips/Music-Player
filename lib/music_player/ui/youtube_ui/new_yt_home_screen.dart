import 'package:flutter/material.dart';

import 'package:dart_ytmusic_api/types.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:yt_clone/music_player/ui/youtube_ui/playlist.dart';

import '../../widgets/yt_music_service.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<HomeSection> homeSections = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchHomeSections();
  }

  Future<void> fetchHomeSections() async {
    try {
      final sections = await ytMusicService.getHomeScreen();
      setState(() {
        homeSections = sections;
        isLoading = false;
      });
    } catch (e) {
      print("Error fetching home sections: $e");
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("YT Music Home")),
      body: isLoading
          ? Center(
              child: LoadingAnimationWidget.staggeredDotsWave(
                color: Colors.red,
                size: 40.sp,
              ),
            )
          : ListView.builder(
              itemCount: homeSections.length,
              itemBuilder: (context, index) {
                HomeSection section = homeSections[index];

                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        section.title,
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 180,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: section.contents.length,
                        itemBuilder: (context, contentIndex) {
                          final content = section.contents[contentIndex];
                          String name = "Unknown";
                          String artist = "";
                          String imageUrl = "";

                          if (content is PlaylistDetailed) {
                            name = content.name;
                            artist = content.artist.name;
                            imageUrl = content.thumbnails.isNotEmpty
                                ? content.thumbnails.last.url
                                : "";
                          } else if (content is AlbumDetailed) {
                            name = content.name;
                            artist = content.artist.name;
                            imageUrl = content.thumbnails.isNotEmpty
                                ? content.thumbnails.last.url
                                : "";
                          }

                          return GestureDetector(
                            onTap: () {
                            
                              // Navigator.push(
                              //   context,
                              //   MaterialPageRoute(
                              //     builder: (context) =>
                              //         PlaylistPage(playlist: content),
                              //   ),
                              // );
                            },
                            child: Container(
                              width: 140,
                              margin: const EdgeInsets.symmetric(horizontal: 8),
                              child: Column(
                                children: [
                                  imageUrl.isNotEmpty
                                      ? Image.network(imageUrl,
                                          width: 120,
                                          height: 120,
                                          fit: BoxFit.cover)
                                      : Container(
                                          width: 120,
                                          height: 120,
                                          color: Colors.grey,
                                        ),
                                  const SizedBox(height: 5),
                                  Text(
                                    name,
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: const TextStyle(
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Text(
                                    artist,
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: const TextStyle(color: Colors.grey),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                );
              },
            ),
    );
  }
}
