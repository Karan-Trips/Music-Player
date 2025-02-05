import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:yt_clone/mobile_view/ui/video_play.dart';

import '../widgets/export.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          const CustomAppBar(),
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, index) {
                VideoModel video = videoinfo()[index];
                return GestureDetector(
                  onTap: () {
                    Get.to(
                      () => VideoPlayerScreen(index: index),
                    );
                  },
                  child: VideoCard(
                    channelName: video.channelName,
                    time: video.time,
                    title: video.videoTitle,
                    videoURL: video.videoThumbnail,
                    views: video.views,
                    channelProfileURL: video.profileURl,
                  ),
                );
              },
              childCount: videoinfo().length,
            ),
          ),
        ],
      ),
    );
  }
}
