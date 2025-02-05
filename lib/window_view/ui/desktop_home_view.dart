// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get_connect/http/src/utils/utils.dart';
import 'package:sidebarx/sidebarx.dart';

import '../../mobile_view/widgets/export.dart';

class DesktopHome extends StatefulWidget {
  const DesktopHome({super.key});

  @override
  State<DesktopHome> createState() => _DesktopHomeState();
}

class _DesktopHomeState extends State<DesktopHome> {
  final _controller = SidebarXController(selectedIndex: 0, extended: true);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        elevation: 0.0,
        title: Row(
          children: [
            IconButton(
              icon: const FaIcon(
                FontAwesomeIcons.youtube,
                color: Colors.red,
              ),
              onPressed: () {},
            ),
            const Text('Youtube'),
          ],
        ),
      ),
      body: Row(
        children: [
          SideNav(
            controller: _controller,
          ),
          const Expanded(
            child: Column(
              children: [
                TopAppBar(),
                Expanded(child: VideoGrid()),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class SideNav extends StatelessWidget {
  final SidebarXController controller;

  const SideNav({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return SidebarX(
      controller: controller,
      theme: SidebarXTheme(
        margin: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
        ),
        hoverColor: Colors.grey[200],
        itemTextPadding: const EdgeInsets.only(left: 16),
        selectedItemTextPadding: const EdgeInsets.only(left: 16),
        itemDecoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
        ),
        selectedItemDecoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: Colors.grey[300],
        ),
        iconTheme: IconThemeData(
          color: Colors.grey[800],
          size: 20,
        ),
        selectedIconTheme: const IconThemeData(
          color: Colors.black,
          size: 20,
        ),
      ),
      extendedTheme: const SidebarXTheme(
        width: 250,
      ),
      footerDivider: const Divider(height: 1, color: Colors.grey),
      items: const [
        SidebarXItem(
          icon: Icons.home,
          label: "Home",
        ),
        SidebarXItem(
          icon: Icons.explore,
          label: "Explore",
        ),
        SidebarXItem(
          icon: Icons.subscriptions,
          label: "Subscriptions",
        ),
        SidebarXItem(
          icon: Icons.video_library,
          label: "Library",
        ),
        SidebarXItem(
          icon: Icons.history,
          label: "History",
        ),
        SidebarXItem(
          icon: Icons.play_arrow,
          label: "Your videos",
        ),
        SidebarXItem(
          icon: Icons.watch_later,
          label: "Watch later",
        ),
        SidebarXItem(
          icon: Icons.thumb_up,
          label: "Liked videos",
        ),
        SidebarXItem(
          icon: Icons.settings,
          label: "Settings",
        ),
        SidebarXItem(
          icon: Icons.help,
          label: "Help",
        ),
      ],
    );
  }
}

class TopAppBar extends StatelessWidget {
  const TopAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      actions: [
        IconButton(icon: const Icon(Icons.search), onPressed: () {}),
        IconButton(icon: const Icon(Icons.notifications), onPressed: () {}),
        IconButton(icon: const Icon(Icons.account_circle), onPressed: () {}),
      ],
    );
  }
}

class VideoGrid extends StatelessWidget {
  const VideoGrid({super.key});

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    int crossAxisCount = 4;
    if (screenWidth < 800) {
      crossAxisCount = 2;
    } else if (screenWidth < 900) {
      crossAxisCount = 3;
    } else if (screenWidth < 1200) {
      crossAxisCount = 4;
    } else {
      crossAxisCount = 5;
    }

    return GridView.builder(
      padding: const EdgeInsets.all(16),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: crossAxisCount,
        childAspectRatio: 16 / 9,
        crossAxisSpacing: 16,
        mainAxisSpacing: 16,
      ),
      itemCount: videoinfo().length,
      itemBuilder: (context, index) {
        return VideoCard(
          video: videoinfo()[index],
          screenWidth: screenWidth,
        );
      },
    );
  }
}

class VideoCard extends StatelessWidget {
  final VideoModel video;
  final double screenWidth;
  const VideoCard({super.key, required this.video, required this.screenWidth});

  @override
  Widget build(BuildContext context) {
    return Card(
      clipBehavior: Clip.antiAlias,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Image.network(
            'https://www.example.com/your-image.jpg',
            width: double.infinity,
            height: screenWidth < 800 ? 120 : 150,
            fit: BoxFit.cover,
            loadingBuilder: (BuildContext context, Widget child,
                ImageChunkEvent? loadingProgress) {
              if (loadingProgress == null) {
                return child;
              } else {
                return Center(
                  child: CircularProgressIndicator(
                    value: loadingProgress.expectedTotalBytes != null
                        ? loadingProgress.cumulativeBytesLoaded /
                            (loadingProgress.expectedTotalBytes ?? 1)
                        : null,
                  ),
                );
              }
            },
            errorBuilder:
                (BuildContext context, Object error, StackTrace? stackTrace) {
              print("Image failed to load: ${error.toString()}");

              return const Center(child: Icon(Icons.error));
            },
          ),
          Padding(
            padding: EdgeInsets.all(8.0.r),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  video.videoTitle,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 4.h),
                Text(
                    "${video.channelName} • ${video.views} views • ${video.time}"),
              ],
            ),
          )
        ],
      ),
    );
  }
}
