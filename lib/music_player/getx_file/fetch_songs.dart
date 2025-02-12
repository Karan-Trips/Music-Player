import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:just_audio/just_audio.dart';
import 'package:just_audio_background/just_audio_background.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:youtube_explode_dart/youtube_explode_dart.dart';
import 'package:yt_clone/music_player/getx_file/yt/yt_search.dart';
import 'package:yt_clone/music_player/ui/home_screen_main.dart';

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

  /// **🔄 Play next song automatically**
  void playNextSong() {
    if (indexPlaying.value < songList.length - 1) {
      indexPlaying.value += 1;
      songIndex.value = indexPlaying.value;
      playSong(songList[indexPlaying.value].uri);
    } else {
      print("🎵 No more songs in the queue.");
    }
  }

  /// **⏮ Play previous song**
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

  /// **⏩ Seek to a specific position**
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

  /// **🎵 Fetch all songs**
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

  /// **▶ Play a song**
  Future<void> playSong(String? uri, {bool isYt = false}) async {
    if (uri == null) {
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
      String thumbnailUrl = "";
      if (isYt) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          isPlaying.value = true;
          isLoading.value = true;
          print('isplayign value===>${isPlaying.value}');
        });

        print("Fetching YouTube Audio... of id ===>> $uri");

        var yt = YoutubeExplode();
        var manifest = await yt.videos.streamsClient.getManifest(uri);
        var audioStream = manifest.audioOnly.withHighestBitrate();
        audioUrl = audioStream.url.toString();
        yt.close();
        WidgetsBinding.instance.addPostFrameCallback((_) {
          isLoading.value = false;
        });

        if (indexPlaying.value < searchController2.searchArtists.length) {
          title = searchController2.searchArtists[indexPlaying.value].name;
          artist = searchController2.searchArtists[indexPlaying.value].name;
          thumbnailUrl = searchController2
              .searchArtists[indexPlaying.value].thumbnails.last.url;
        }
      } else {
        if (indexPlaying.value < songList.length) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            isPlaying.value = true;
            isLoading.value = true;
          });
          title = songList[indexPlaying.value].title;
          artist = songList[indexPlaying.value].artist!;
          audioUrl = uri;
          songIndex.value = indexPlaying.value;
        }
      }

      print("✅ Extracted Audio URL: $audioUrl");
      WidgetsBinding.instance.addPostFrameCallback((_) {
        isLoading.value = false;
      });
      await audioPlayer.setAudioSource(
        AudioSource.uri(
          Uri.parse(audioUrl),
          tag: MediaItem(
            id: uri,
            album: album,
            title: title,
            artist: artist,
            artUri: thumbnailUrl.isNotEmpty ? Uri.tryParse(thumbnailUrl) : null,
          ),
        ),
      );

      await audioPlayer.play();
      update();
    } catch (e) {
      print("❌ Error playing song: $e");
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
}

SongPlayerController songPlayerController = Get.put(SongPlayerController());
