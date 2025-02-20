import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:just_audio/just_audio.dart';
import 'package:just_audio_background/just_audio_background.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:youtube_explode_dart/youtube_explode_dart.dart';
import 'package:yt_clone/music_player/getx_file/yt/yt_search.dart';
import 'package:yt_clone/music_player/ui/home_screen_main.dart';
import 'package:http/http.dart' as http;

class SongPlayerController extends GetxController {
  late AudioPlayer audioPlayer;
  final audioQuery = OnAudioQuery();
  var isPlaying = false.obs;
  var currentPosition = Duration.zero.obs;
  var totalDuration = Duration.zero.obs;
  var isLoading = false.obs;
  var inRepeat = false.obs;
  Duration? pausedPosition;

  RxInt indexPlaying = 0.obs;

  var volume = 0.5.obs;
  RxList<SongModel> songList = <SongModel>[].obs;

  @override
  void onInit() {
    super.onInit();
    audioPlayer = AudioPlayer();
    audioPlayer.durationStream.listen((duration) {
      if (duration != null) {
        print('Audio duration: $duration');
        totalDuration.value = duration;
      }
    });

    audioPlayer.positionStream.listen((position) {
      currentPosition.value = position;
      pausedPosition = position;
    });

    audioPlayer.playerStateStream.listen((playerState) {
      if (playerState.processingState == ProcessingState.completed) {
        songIndex.value = indexPlaying.value;
        playNextSong();
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
    audioPlayer.dispose();
  }

  void playNextSong() {
    if (indexPlaying.value < songList.length - 1) {
      indexPlaying.value += 1;
      songIndex.value = indexPlaying.value;
      playSong(songList[indexPlaying.value].uri);
    } else {
      print("🎵 No more songs in the queue.");
    }
  }

  void playPreviousSong() {
    if (indexPlaying.value > 0) {
      indexPlaying.value -= 1;
      songIndex.value = indexPlaying.value;
      playSong(
        songList[indexPlaying.value].uri,
      );
    } else {
      print("🎵 Already at the first song.");
    }
  }

  Future<void> seekTo(Duration position) async {
    try {
      await audioPlayer.seek(position);
      print("Seeking to: $position");
    } catch (e) {
      print("❌ Error seeking: $e");
    }
  }

  @override
  void onClose() {
    audioPlayer.dispose();
    super.onClose();
  }

  Future<void> checkPermissionAndFetchSongs() async {
    try {
      bool permissionGranted = false;

      if (Platform.isAndroid) {
        var storageStatus = await Permission.storage.status;
        if (!storageStatus.isGranted) {
          storageStatus = await Permission.storage.request();
        }

        var audioStatus = await Permission.audio.status;
        if (!audioStatus.isGranted) {
          audioStatus = await Permission.audio.request();
        }

        if (storageStatus.isGranted || audioStatus.isGranted) {
          permissionGranted = true;
        }
      } else if (Platform.isIOS) {
        var mediaStatus = await Permission.mediaLibrary.status;
        if (!mediaStatus.isGranted) {
          mediaStatus = await Permission.mediaLibrary.request();
        }

        if (mediaStatus.isGranted) {
          permissionGranted = true;
        }
      }

      if (permissionGranted) {
        isLoading.value = true;
        print("✅ Permission granted!");
        await fetchSongs();
        isLoading.value = false;
      } else {
        print("❌ Permission denied! Cannot access media library.");
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
        print("❌ No songs found in the library.");
      } else {
        print("✅ Found ${songs.length} songs.");
        songList.assignAll(songs);
      }
      isLoading.value = false;
    } catch (e) {
      isLoading.value = false;
      print("❌ Error fetching songs: $e");
    }
  }

  Future<void> playSong(String? uri, {bool isYt = false}) async {
    if (uri == null || uri.isEmpty) {
      print("❌ Invalid song URI");
      return;
    }

    try {
      if (audioPlayer.playing) {
        await audioPlayer.stop();
      }

      String audioUrl = uri;
      String title = "Unknown Song";
      String artist = "Unknown Artist";
      String album = "YT Clone";
      String? thumbnailUrl;
      bool isLocalFile = false;

      // Check if it's a downloaded file
      if (!isYt && File(uri).existsSync()) {
        isLocalFile = true;
        print("🎵 Playing from Downloads: $uri");
      }

      if (isYt) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          isPlaying.value = true;
          isLoading.value = true;
        });

        print("Fetching YouTube Audio... for ID: $uri");

        var yt = YoutubeExplode();
        var manifest = await yt.videos.streamsClient.getManifest(uri);
        var audioStream = manifest.audioOnly.withHighestBitrate();

        if (audioStream != null) {
          audioUrl = audioStream.url.toString();
        } else {
          print("❌ No valid audio stream found.");
          return;
        }

        yt.close();
        WidgetsBinding.instance.addPostFrameCallback((_) {
          isLoading.value = false;
        });

        if (indexPlaying.value < searchController2.searchArtists.length) {
          var songData = searchController2.searchArtists[indexPlaying.value];
          title = songData.name ?? "Unknown Title";
          artist = songData.name ?? "Unknown Artist";
          thumbnailUrl = songData.thumbnails.isNotEmpty
              ? songData.thumbnails.last.url
              : null;
        }
      } else if (isLocalFile) {
        // Extract metadata from file path
        String fileName = uri.split('/').last;
        List<String> nameParts = fileName.replaceAll('.mp3', '').split(' - ');

        if (nameParts.length == 2) {
          artist = nameParts[0];
          title = nameParts[1];
        } else {
          title = fileName.replaceAll('.mp3', '');
        }

        // Set thumbnail path
        String thumbnailPath = uri
            .replaceAll('/Music/', '/Music/.thumbnail/')
            .replaceAll('.mp3', '.jpg');

        if (File(thumbnailPath).existsSync()) {
          thumbnailUrl = thumbnailPath;
        }
      } else {
        if (indexPlaying.value < songList.length) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            isPlaying.value = true;
            isLoading.value = true;
          });

          var localSong = songList[indexPlaying.value];
          title =
              localSong.title.isNotEmpty ? localSong.title : "Unknown Title";
          artist = localSong.artist?.isNotEmpty == true
              ? localSong.artist!
              : "Unknown Artist";
          audioUrl = uri;
          WidgetsBinding.instance.addPostFrameCallback((_) {
            songIndex.value = indexPlaying.value;
          });
        }
      }

      print("✅ Playing: $title by $artist");
      print("🎵 Audio URL: $audioUrl");

      WidgetsBinding.instance.addPostFrameCallback((_) {
        isLoading.value = false;
      });

      await audioPlayer.setAudioSource(
        isLocalFile
            ? AudioSource.uri(Uri.file(audioUrl))
            : AudioSource.uri(
                Uri.parse(audioUrl),
                tag: MediaItem(
                  id: uri,
                  album: album,
                  title: title,
                  artist: artist,
                  artUri:
                      thumbnailUrl != null ? Uri.tryParse(thumbnailUrl) : null,
                ),
              ),
      );

      await audioPlayer.play();
      update();
    } catch (e, stacktrace) {
      print("❌ Error playing song: $e");
      print(stacktrace);
    }
  }

  Future<void> pauseSong() async {
    try {
      await audioPlayer.pause();
      isPlaying.value = false;
      print("⏸ Song paused at: ${currentPosition.value}");
      update();
    } catch (e) {
      print("❌ Error pausing song: $e");
    }
  }

  Future<void> resumeSong() async {
    try {
      if (pausedPosition != null) {
        isPlaying.value = true;
        await audioPlayer.seek(pausedPosition!);
        await audioPlayer.play();
        print("▶ Resumed song from: $pausedPosition");
        update();
      } else {
        print("❌ No paused position found");
      }
    } catch (e) {
      print("❌ Error resuming song: $e");
    }
  }

  Future<void> repeatSong() async {
    inRepeat.value = !inRepeat.value;
    await audioPlayer.setLoopMode(inRepeat.value ? LoopMode.one : LoopMode.off);
    print("🔁 Repeat mode: ${inRepeat.value ? 'ON' : 'OFF'}");
  }

  void toogleVolume(double value) {
    double scaledVolume = value / 100;
    audioPlayer.setVolume(scaledVolume);
    volume.value = scaledVolume;
  }

  Future<void> downloadTheSong(
      String videoId, String title, String artist) async {
    try {
      var yt = YoutubeExplode();
      var video = await yt.videos.get(videoId);
      var manifest = await yt.videos.streamsClient.getManifest(videoId);
      var audioStream = manifest.audioOnly.withHighestBitrate();

      String thumbnailUrl = video.thumbnails.highResUrl;

      Directory? dir;
      if (Platform.isAndroid) {
        dir = Directory("/storage/emulated/0/Download");
      } else {
        dir = await getApplicationDocumentsDirectory();
      }

      if (!dir.existsSync()) {
        print("❌ Failed to get storage directory");
        return;
      }

      String safeTitle = title.replaceAll(RegExp(r'[<>:"/\\|?*]'), '_');
      String safeArtist = artist.replaceAll(RegExp(r'[<>:"/\\|?*]'), '_');

      String audioFilePath = "${dir.path}/$safeArtist - $safeTitle.mp3";
      String thumbnailFilePath = "${dir.path}/$safeArtist - $safeTitle.jpg";
      String metadataFilePath = "${dir.path}/$safeArtist - $safeTitle.json";

      print("⬇ Downloading audio to: $audioFilePath");

      var audioFile = File(audioFilePath);
      var output = audioFile.openWrite();

      var stream = yt.videos.streamsClient.get(audioStream);
      int totalBytes = 0;
      int totalSize = audioStream.size.totalBytes;
      int lastPrintedProgress = 0;

      RxDouble progressValue = 0.0.obs;
      Get.dialog(
        Obx(() {
          print('progressValue_value===>${progressValue.value}');
          return AlertDialog(
            title: const Text("Downloading..."),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                    "Progress: ${(progressValue.value * 100).toStringAsFixed(1)}%"),
                const SizedBox(height: 10),
                LinearProgressIndicator(value: progressValue.value),
              ],
            ),
          );
        }),
        barrierDismissible: false,
      );

      await for (final chunk in stream) {
        totalBytes += chunk.length;
        output.add(chunk);

        double progress = totalBytes / totalSize;
        if ((progress * 100).toInt() - lastPrintedProgress >= 1) {
          lastPrintedProgress = (progress * 100).toInt();
          progressValue.value = progress;
        }
      }

      await output.close();

      await downloadThumbnail(thumbnailUrl, thumbnailFilePath);

      await saveMetadata(
          metadataFilePath, title, artist, thumbnailFilePath, audioFilePath);

      yt.close();
      Get.back();

      print("✅ Download complete: $audioFilePath");

      Get.snackbar(
        "Download Complete ✅",
        "Saved as $safeArtist - $safeTitle.mp3",
        backgroundColor: Colors.green,
        colorText: Colors.white,
        duration: const Duration(seconds: 5),
        snackPosition: SnackPosition.BOTTOM,
      );
    } catch (e) {
      print("❌ Error downloading song: $e");

      Get.back();

      Get.snackbar(
        "Download Failed ❌",
        "Error: $e",
        backgroundColor: Colors.red,
        colorText: Colors.white,
        duration: const Duration(seconds: 5),
      );
    }
  }

  Future<void> downloadThumbnail(String url, String filePath) async {
    try {
      var response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        File file = File(filePath);
        await file.writeAsBytes(response.bodyBytes);
        print("✅ Thumbnail saved: $filePath");
      } else {
        print("❌ Failed to download thumbnail.");
      }
    } catch (e) {
      print("❌ Error downloading thumbnail: $e");
    }
  }

  Future<void> saveMetadata(String filePath, String title, String artist,
      String thumbnailPath, String audioPath) async {
    Map<String, String> metadata = {
      "title": title,
      "artist": artist,
      "thumbnail": thumbnailPath,
      "audioFile": audioPath,
    };

    File file = File(filePath);
    await file.writeAsString(jsonEncode(metadata));
    print("✅ Metadata saved: $filePath");
  }
}

SongPlayerController songPlayerController = Get.put(SongPlayerController());
