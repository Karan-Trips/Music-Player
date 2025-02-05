import 'package:crystal_navigation_bar/crystal_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:yt_clone/music_player/getx_file/fetch_songs.dart';
import 'package:yt_clone/music_player/ui/home_screen.dart';
import 'package:yt_clone/music_player/ui/search_screen.dart';

import '../getx_file/ui_getx_change.dart';

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
      extendBody: true,
      backgroundColor: Get.isDarkMode ? Colors.black : Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text(
          "K- Player",
          style: GoogleFonts.poppins(
            color: Get.isDarkMode ? Colors.white : Colors.black,
            fontSize: 20.sp,
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Obx(() {
          if (songPlayerController.isLoading.value) {
            return const Center(child: CircularProgressIndicator());
          }
          return const HomeScreenPlayer();
        }),
      ),
      floatingActionButton: CrystalNavigationBar(
        enableFloatingNavBar: true,
        currentIndex: navController.selectedIndex.value,
        borderRadius: 50.r,
        enablePaddingAnimation: true,
        selectedItemColor: Colors.red,
        backgroundColor: Colors.black.withOpacity(0.1),
        onTap: (index) {
          if (index == 1) {
            Get.to(() => const SearchScreen());
          } else {
            navController.changeIndex(index);
          }
        },
        items: [
          /// Home
          CrystalNavigationBarItem(
            icon: IconlyBold.home,
            unselectedIcon: IconlyLight.home,
          ),

          /// Search
          CrystalNavigationBarItem(
            icon: IconlyBold.search,
            unselectedIcon: IconlyLight.search,
          ),

          /// Profile
          CrystalNavigationBarItem(
            icon: IconlyBold.user2,
            unselectedIcon: IconlyLight.user3,
          ),
        ],
      ),
    );
  }
}
