import 'package:audio_service/audio_service.dart';
import 'package:get/get.dart';
import 'package:just_audio/just_audio.dart';
import 'package:on_audio_query/on_audio_query.dart';

class AudioPlayerHandler extends BaseAudioHandler with SeekHandler {
  final audioQuery = OnAudioQuery();
  final audioPlayer = AudioPlayer();
  Duration? pausedPosition;
  RxList<SongModel> songList = <SongModel>[].obs;
  var isPlaying = false.obs;
  var currentPosition = Duration.zero.obs;
  var totalDuration = Duration.zero.obs;
  var isLoading = false.obs;

  AudioPlayerHandler() {
    audioPlayer.durationStream.listen((duration) {
      if (duration != null) {
        totalDuration.value = duration;
      }
    });

    audioPlayer.positionStream.listen((position) {
      currentPosition.value = position;
      pausedPosition = position;
    });

    // Initialize and set a default song item.
    final _item = MediaItem(
      id: 'https://s3.amazonaws.com/scifri-episodes/scifri20181123-episode.mp3',
      album: "Science Friday",
      title: "A Salute To Head-Scratching Science",
      artist: "Science Friday and WNYC Studios",
      duration: const Duration(milliseconds: 5739820),
      artUri: Uri.parse(
          'https://media.wnyc.org/i/1400/1400/l/80/1/ScienceFriday_WNYCStudios_1400.jpg'),
    );
    mediaItem.add(_item);
    audioPlayer.setAudioSource(AudioSource.uri(Uri.parse(_item.id)));
  }

  @override
  Future<void> play() async {
    try {
      await audioPlayer.play();
      isPlaying.value = true;
      print('Audio is playing');
    } catch (e) {
      print("Error playing song: $e");
    }
  }

  @override
  Future<void> pause() async {
    try {
      await audioPlayer.pause();
      isPlaying.value = false;
      print("Song paused at: ${currentPosition.value}");
    } catch (e) {
      print("Error pausing song: $e");
    }
  }

  @override
  Future<void> seek(Duration position) async {
    try {
      await audioPlayer.seek(position);
      print("Seeking to: $position");
    } catch (e) {
      print("Error seeking: $e");
    }
  }

  @override
  Future<void> stop() async {
    try {
      await audioPlayer.stop();
      isPlaying.value = false;
      print("Song stopped");
    } catch (e) {
      print("Error stopping song: $e");
    }
  }

  // Fetch songs from the library
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
        print("Found ${songs.length} songs.");
        songList.assignAll(songs);
      }
      isLoading.value = false;
    } catch (e) {
      isLoading.value = false;
      print("Error fetching songs: $e");
    }
  }

  // Play a song based on its URI
  Future<void> playSong(String? uri) async {
    if (uri == null) {
      print("Invalid song URI");
      return;
    }

    try {
      // Stop the previous song if playing
      if (audioPlayer.playing) {
        await audioPlayer.stop();
      }

      await audioPlayer.setAudioSource(AudioSource.uri(Uri.parse(uri)));
      await audioPlayer.play();
      isPlaying.value = true;
      print('Playing song: $uri');
    } catch (e) {
      print("Error playing song: $e");
    }
  }

  // Resume playback from the paused position
  Future<void> resumeSong() async {
    try {
      if (pausedPosition != null) {
        await audioPlayer.seek(pausedPosition!);
        await audioPlayer.play();
        isPlaying.value = true;
        print("Resumed song from: $pausedPosition");
      } else {
        print("No paused position found");
      }
    } catch (e) {
      print("Error resuming song: $e");
    }
  }

  // Skip to the next song
  Future<void> skipToNext() async {
    try {
      // Fetch next song URI from the list and play it
      if (songList.isNotEmpty) {
        final nextSong =
            songList[0]; // For example, get the first song in the list.
        await playSong(nextSong.uri);
      }
    } catch (e) {
      print("Error skipping to next song: $e");
    }
  }

  // Go to previous song
  Future<void> skipToPrevious() async {
    try {
      if (songList.isNotEmpty) {
        final prevSong =
            songList[songList.length - 1]; // For example, get the last song.
        await playSong(prevSong.uri);
      }
    } catch (e) {
      print("Error skipping to previous song: $e");
    }
  }
}
