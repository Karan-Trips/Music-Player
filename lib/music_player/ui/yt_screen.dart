import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

import 'package:yt_clone/music_player/getx_file/yt/yt_ui.dart';

class YoutubeScreenOnline extends StatelessWidget {
  final String id;
  const YoutubeScreenOnline({super.key, required this.id});

  @override
  Widget build(BuildContext context) {
    final YoutubeController controller = Get.put(YoutubeController(id));

    return YoutubePlayerBuilder(
      player: YoutubePlayer(
        controller: controller.playerController,
        showVideoProgressIndicator: false,
        progressIndicatorColor: Colors.blueAccent,
        topActions: <Widget>[
          const SizedBox(width: 8.0),
          Expanded(
            child: Obx(() => Text(
                  controller.videoTitle.value,
                  style: const TextStyle(
                      color: Colors.white,
                      fontSize: 18.0,
                      fontWeight: FontWeight.w500),
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                )),
          ),
          IconButton(
            icon: const Icon(Icons.download, color: Colors.white, size: 25.0),
            onPressed: () => controller.downloadVideo(),
          ),
        ],
      ),
      builder: (context, player) {
        return Scaffold(
          appBar: AppBar(
            elevation: 0,
            title: const Text("YouTube Player",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            centerTitle: true,
            backgroundColor: Colors.black87,
          ),
          backgroundColor: Colors.black,
          body: Column(
            children: [
              ClipRRect(borderRadius: BorderRadius.circular(20), child: player),
              const SizedBox(height: 10),
              _buildControls(controller),
            ],
          ),
        );
      },
    );
  }

  Widget _buildControls(YoutubeController controller) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.1),
          borderRadius: BorderRadius.circular(15),
          boxShadow: [
            BoxShadow(
                color: Colors.black.withOpacity(0.2),
                blurRadius: 10,
                spreadRadius: 1)
          ],
        ),
        padding: const EdgeInsets.all(12),
        child: Column(
          children: [
            Obx(
              () => SliderTheme(
                data: SliderTheme.of(Get.context!).copyWith(
                  thumbColor: Colors.redAccent,
                  activeTrackColor: Colors.red,
                  inactiveTrackColor: Colors.white30,
                  overlayColor: Colors.red.withOpacity(0.2),
                  trackHeight: 3,
                  thumbShape:
                      const RoundSliderThumbShape(enabledThumbRadius: 8),
                ),
                child: Slider(
                  value: controller.sliderValue.value,
                  min: 0,
                  max: controller.videoDuration.value.inSeconds.toDouble(),
                  onChanged: (value) => controller.sliderValue.value = value,
                  onChangeEnd: (value) => controller.seekTo(value),
                ),
              ),
            ),
            Obx(
              () => Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                      controller
                          .formatDuration(controller.currentPosition.value),
                      style:
                          const TextStyle(color: Colors.white70, fontSize: 14)),
                  Text(
                      controller.formatDuration(controller.videoDuration.value),
                      style:
                          const TextStyle(color: Colors.white70, fontSize: 14)),
                ],
              ),
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  icon: const Icon(Icons.replay_10,
                      color: Colors.white, size: 30),
                  onPressed: controller.rewind10Sec,
                ),
                const SizedBox(width: 10),
                Obx(
                  () => CircleAvatar(
                    radius: 25,
                    backgroundColor: Colors.redAccent,
                    child: IconButton(
                      icon: Icon(
                          controller.isPlaying.value
                              ? Icons.pause
                              : Icons.play_arrow,
                          color: Colors.white,
                          size: 30),
                      onPressed: controller.togglePlayPause,
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                IconButton(
                  icon: const Icon(Icons.forward_10,
                      color: Colors.white, size: 30),
                  onPressed: controller.forward10Sec,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
