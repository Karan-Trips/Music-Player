import 'package:dart_ytmusic_api/types.dart';
import 'package:dart_ytmusic_api/yt_music.dart';

class YTMusicService {
  static final YTMusicService _instance = YTMusicService._internal();
  factory YTMusicService() => _instance;

  final YTMusic _ytmusic = YTMusic();
  bool _isInitialized = false;

  YTMusicService._internal();

  Future<void> initialize() async {
    if (_isInitialized) return;
    try {
      await _ytmusic.initialize();
      _isInitialized = true;
      print("✅ YTMusic API Initialized Successfully!");
    } catch (e) {
      print("❌ Failed to initialize YTMusic API: $e");
    }
  }

  Future<List<SongDetailed>> searchSongs(String query) async {
    try {
      return await _ytmusic.searchSongs(query);
    } catch (e) {
      print("❌ YTMusic API Error [searchSongs]: $e");
      return [];
    }
  }

  Future<ArtistFull?> showArtist(String artistId) async {
    try {
      final artist = await _ytmusic.getArtist(artistId);
      if (artist.thumbnails.isEmpty) {
        print("⚠️ No thumbnails found for artist ID: $artistId");
      }
      return artist;
    } catch (e) {
      print("❌ YTMusic API Error [showArtist] for $artistId: $e");
      return null;
    }
  }

  Future<List<AlbumDetailed>> showArtistTopSingles(String artistId) async {
    try {
      return await _ytmusic.getArtistSingles(artistId);
    } catch (e) {
      print("❌ YTMusic API Error [showArtistTopSingles] for $artistId: $e");
      return [];
    }
  }

  Future<List<HomeSection>> getHomeScreen() async {
    try {
      return await _ytmusic.getHomeSections();
    } catch (e) {
      print("❌ YTMusic API Error [homeswcreen]  $e");
      return [];
    }
  }

  Future<List<SongDetailed>> getPlaylistSongs(String playlistId) async {
    try {
      return await _ytmusic.getArtistSongs(playlistId);
    } catch (e) {
      print("❌ YTMusic API Error [getPlaylistSongs] for $playlistId: $e");
      return [];
    }
  }

  Future<AlbumFull?> getAlbum(String albumId) async {
    try {
      return await _ytmusic.getAlbum(albumId);
    } catch (e) {
      print("❌ YTMusic API Error [getAlbum] for $albumId: $e");
      return null;
    }
  }

  Future<SongFull?> getSongDetails(String videoId) async {
    try {
      return await _ytmusic.getSong(videoId);
    } catch (e) {
      print("❌ YTMusic API Error [getSongDetails] for $videoId: $e");
      return null;
    }
  }

  Future<PlaylistFull?> playlistDetails(String videoId) async {
    try {
      return await _ytmusic.getPlaylist(videoId);
    } catch (e) {
      print("❌ YTMusic API Error for $videoId: $e");
      return null;
    }
  }
}

final YTMusicService ytMusicService = YTMusicService();
