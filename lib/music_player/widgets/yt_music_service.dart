// ignore_for_file: avoid_print

import 'package:dart_ytmusic_api/types.dart';
import 'package:dart_ytmusic_api/yt_music.dart';

class YTMusicService {
  final YTMusic _ytmusic = YTMusic();

  Future<void> initialize() async {
    try {
      await _ytmusic.initialize();
      print("YTMusic API Initialized Successfully!");
    } catch (e) {
      print(" Failed to initialize YTMusic API: $e");
    }
  }

  Future<List<SongDetailed>> searchSongs(String query) async {
    try {
      final results = await _ytmusic.searchSongs(query);
      return results;
    } catch (e) {
      print(" YTMusic API Error [searchSongs]: $e");
      return [];
    }
  }

  Future<ArtistFull?> showArtist(String artistId) async {
    try {
      final result = await _ytmusic.getArtist(artistId);
      if (result.thumbnails.isEmpty) {
        print("⚠️ No thumbnails found for artist ID: $artistId");
        return null;
      }
      return result;
    } catch (e) {
      print(" YTMusic API Error [showArtist] for $artistId: $e");
      return null;
    }
  }

  Future<List<AlbumDetailed>> showArtistTopSingles(String artistId) async {
    try {
      final result = await _ytmusic.getArtistSingles(artistId);
      return result;
    } catch (e) {
      print(" YTMusic API Error [showArtistTopSingles] for $artistId: $e");
      return [];
    }
  }

  // Future<PlaylistFull?> showArtistPlaylist(String playlistId) async {
  //   try {
  //     final result = await _ytmusic.getArtistSongs(playlistId);
  //     return result;
  //   } catch (e) {
  //     print(" YTMusic API Error [showArtistPlaylist] for $playlistId: $e");
  //     return null;
  //   }
  // }
}

final YTMusicService ytMusicService = YTMusicService();
