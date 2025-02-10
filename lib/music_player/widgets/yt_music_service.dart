// ignore_for_file: avoid_print

import 'package:dart_ytmusic_api/types.dart';
import 'package:dart_ytmusic_api/yt_music.dart';

class YTMusicService {
  final YTMusic _ytmusic = YTMusic();

  Future<void> initialize() async {
    await _ytmusic.initialize();
  }

  Future<List<SongDetailed>> searchSongs(String query) async {
    try {
      final results = await _ytmusic.searchSongs(query);
      

      return results;
    } catch (e) {
      print("YTMusic API Error: $e");
      return [];
    }
  }

  Future<ArtistFull?> showArtist(String query) async {
    try {
      final result = await _ytmusic.getArtist(query);

      if (result.thumbnails.isEmpty) {
        print("⚠️ No thumbnails found for $query");
        return null;
      }

      return result;
    } catch (e) {
      print("❌ YTMusic API Error for artist $query: $e");
      return null;
    }
  }
}

final YTMusicService ytMusicService = YTMusicService();
