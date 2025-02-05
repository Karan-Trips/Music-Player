// ignore_for_file: avoid_print

import 'package:get/get.dart';
import 'package:just_audio/just_audio.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:permission_handler/permission_handler.dart';

class SongPlayerController extends GetxController {
  final audioQuery = OnAudioQuery();
  final audioPlayer = AudioPlayer();
  var isPlaying = false.obs;
  var currentPosition = Duration.zero.obs;
  var totalDuration = Duration.zero.obs;
  var isLoading = false.obs;
  Duration? pausedPosition;
  RxList<SongModel> songList = <SongModel>[].obs;

  @override
  void onInit() {
    super.onInit();

    audioPlayer.durationStream.listen((duration) {
      if (duration != null) {
        totalDuration.value = duration;
        print("Total Duration Updated: ${totalDuration.value}");
      }
    });

    audioPlayer.positionStream.listen((position) {
      currentPosition.value = position;
      pausedPosition = position;
      print("Current Position Updated: ${currentPosition.value}");
    });
  }

  Future<void> seekTo(Duration position) async {
    try {
      await audioPlayer.seek(position);
      print("Seeking to: $position");
    } catch (e) {
      print("Error seeking: $e");
    }
  }

  @override
  void onClose() {
    audioPlayer.dispose();
    super.onClose();
  }

  Future<void> checkPermissionAndFetchSongs() async {
    try {
      var status = await Permission.storage.status;
      if (!status.isGranted) {
        status = await Permission.storage.request();
      }

      var audioStatus = await Permission.audio.status;
      if (!audioStatus.isGranted) {
        audioStatus = await Permission.audio.request();
      }

      var mediaStatus = await Permission.mediaLibrary.status;
      if (!mediaStatus.isGranted) {
        mediaStatus = await Permission.mediaLibrary.request();
      }

      if (status.isGranted || audioStatus.isGranted || mediaStatus.isGranted) {
        isLoading.value = true;
        print("Permission granted!");
        await fetchSongs();
        isLoading.value = false;
      } else {
        print("Permission denied! Cannot access media library.");
        Get.snackbar(
            'Error', 'Permission denied! Cannot access media library.');
      }
    } catch (e) {
      print("⚠️ Error checking permissions: $e");
    }
  }

  Future<void> fetchSongs() async {
    try {
      isLoading.value = true;
      List<SongModel> songs = await audioQuery.querySongs(
        ignoreCase: true,
        orderType: OrderType.ASC_OR_SMALLER,
        uriType: UriType.EXTERNAL,
      );
      if (songs.isEmpty) {
        print("No songs found in the library.");
      } else {
        print(" Found ${songs.length} songs.");
        songList.assignAll(songs);
      }
      isLoading.value = false;
    } catch (e) {
      isLoading.value = false;
      print(" Error fetching songs: $e");
    }
  }

  Future<void> playSong(String? uri) async {
    if (uri == null) {
      print(" Invalid song URI");
      return;
    }

    try {
      await audioPlayer.setAudioSource(AudioSource.uri(Uri.parse(uri)));
      isPlaying.value = true;
      print('playing---->2 $isPlaying');
      await audioPlayer.play();
      update();
    } catch (e) {
      print("Error playing song: $e");
    }
  }

  Future<void> pauseSong() async {
    try {
      await audioPlayer.pause();
      isPlaying.value = false;
      print("Song paused at: ${currentPosition.value}");
      update();
    } catch (e) {
      print("Error pausing song: $e");
    }
  }

  Future<void> resumeSong() async {
    try {
      if (pausedPosition != null) {
        await audioPlayer.seek(pausedPosition!);
        await audioPlayer.play();
        isPlaying.value = true;
        print("Resumed song from: $pausedPosition");
        update();
      } else {
        print("No paused position found");
      }
    } catch (e) {
      print("Error resuming song: $e");
    }
  }
}

SongPlayerController songPlayerController = Get.put(SongPlayerController());
