import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:yt_clone/music_player/getx_file/fetch_songs.dart';
import 'package:yt_clone/music_player/ui/detail_view.dart';
import 'package:yt_clone/music_player/ui/favoutire_music/favortire_scren.dart';
import 'package:yt_clone/music_player/ui/home_bottom_floating_container.dart';
import 'package:yt_clone/music_player/ui/home_screen.dart';
import 'package:yt_clone/music_player/ui/youtube_ui/search_screen.dart';

ValueNotifier<int> songIndex = ValueNotifier(-1);

class MusicHomeScreen extends StatefulWidget {
  const MusicHomeScreen({super.key});

  @override
  State<MusicHomeScreen> createState() => _MusicHomeScreenState();
}

class _MusicHomeScreenState extends State<MusicHomeScreen> {
  @override
  void initState() {
    super.initState();
    songPlayerController.checkPermissionAndFetchSongs();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:
          Get.isDarkMode ? const Color.fromRGBO(12, 17, 43, 1) : Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          onPressed: () {
            Get.to(() => const FavoriteSongsPage());
          },
          icon: const Icon(
            Icons.favorite,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {
              Get.to(() => const SearchScreen());
            },
            icon: Icon(
              Icons.search,
              color: Get.isDarkMode ? Colors.white : Colors.black,
            ),
          )
        ],
        title: Text(
          "K - Player",
          style: GoogleFonts.poppins(
            color: Get.isDarkMode ? Colors.white : Colors.black,
            fontSize: 20.sp,
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: true,
      ),
      body: Obx(() {
        if (songPlayerController.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        } else {
          return ValueListenableBuilder<int>(
              valueListenable: songIndex,
              builder: (context, selectedIndex, child) {
                return Stack(
                  fit: StackFit.expand,
                  clipBehavior: Clip.hardEdge,
                  children: [
                    const HomeScreenPlayer(),
                    selectedIndex == -1
                        ? const SizedBox()
                        : Positioned(
                            bottom: 0,
                            left: 0,
                            right: 0,
                            child: InkWell(
                                onTap: () {
                                  WidgetsBinding.instance
                                      .addPostFrameCallback((_) {
                                    Get.to(() => DetailPlayer(
                                          index: songIndex.value,
                                          isFromBottomPlayer: true,
                                        ));
                                  });
                                },
                                child: const HomeBottomPlayer()),
                          ),
                  ],
                );
              });
        }
      }),
    );
  }
}
