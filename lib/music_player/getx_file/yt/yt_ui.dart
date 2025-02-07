import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:youtube_explode_dart/youtube_explode_dart.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class YoutubeController extends GetxController {
  late YoutubePlayerController playerController;
  RxString videoTitle = ''.obs;
  RxDouble sliderValue = 0.0.obs;
  Rx<Duration> videoDuration = Duration.zero.obs;
  Rx<Duration> currentPosition = Duration.zero.obs;
  RxBool isPlaying = false.obs;

  YoutubeController(String id) {
    playerController = YoutubePlayerController(
      initialVideoId: id,
      flags: const YoutubePlayerFlags(
        autoPlay: false,
        mute: false,
        disableDragSeek: false,
      ),
    )..addListener(listener);
  }

  void listener() {
    if (!playerController.value.isFullScreen) {
      videoTitle.value = playerController.metadata.title;
      videoDuration.value = playerController.metadata.duration;
      currentPosition.value = playerController.value.position;
      sliderValue.value = currentPosition.value.inSeconds.toDouble();
      isPlaying.value = playerController.value.isPlaying;
    }
  }

  void togglePlayPause() {
    if (playerController.value.isPlaying) {
      playerController.pause();
    } else {
      playerController.play();
    }
  }

  void seekTo(double seconds) {
    playerController.seekTo(Duration(seconds: seconds.toInt()));
  }

  void rewind10Sec() {
    seekTo(currentPosition.value.inSeconds - 10);
  }

  void forward10Sec() {
    seekTo(currentPosition.value.inSeconds + 10);
  }

  Future<void> downloadVideo() async {
    try {
      var status = await Permission.storage.request();
      if (!status.isGranted) {
        Get.snackbar("Permission Denied",
            "Storage permission is required to download videos.");
        return;
      }

      Get.snackbar("Downloading", "Fetching video URL...");

      var yt = YoutubeExplode();
      var video = await yt.videos.get(playerController.metadata.videoId);
      var manifest = await yt.videos.streamsClient.getManifest(video.id);
      var audioStream = manifest.audioOnly.withHighestBitrate();

      var directory = await getApplicationDocumentsDirectory();
      String filePath = "${directory.path}/${video.title}.mp3";

      await Dio().download(audioStream.url.toString(), filePath);

      Get.snackbar(
          "Download Complete", "Saved to ${directory.path}/${video.title}.mp3");
    } catch (e) {
      Get.snackbar("Error", "Download failed: $e");
    }
  }

  String formatDuration(Duration duration) {
    String minutes = duration.inMinutes.toString().padLeft(2, '0');
    String seconds = (duration.inSeconds % 60).toString().padLeft(2, '0');
    return "$minutes:$seconds";
  }
}
