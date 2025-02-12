import 'package:dart_ytmusic_api/types.dart';
import 'package:get/get.dart';

import '../../widgets/yt_music_service.dart';

class SearchController extends GetxController {
  var isLoading = false.obs;
  var searchResults = <SongDetailed>[].obs;
  var searchArtists = <ArtistFull>[].obs;

  Future<List<SongDetailed>> searchSongs(String query) async {
    if (query.isEmpty) {
      searchResults.clear();
      return [];
    }
    try {
      isLoading.value = true;
      final results = await ytMusicService.searchSongs(query);

      searchResults.assignAll(results);
      isLoading.value = false;
      return results;
    } catch (e) {
      print("Error fetching search results: $e");
      return [];
    } finally {
      isLoading.value = false;
    }
  }

  Future<ArtistFull?> fetchArtist(String query) async {
    try {
      isLoading.value = true;

      final result = await ytMusicService.showArtist(query);
      isLoading.value = false;

      if (result != null && result.thumbnails.isNotEmpty) {
        return result;
      } else {
        print("⚠️ No data found for artist: $query");
        isLoading.value = false;
        return null;
      }
    } catch (e) {
      print("❌ Error fetching artist details: $e");
      return null;
    } finally {
      if (isLoading.value) {
        isLoading.value = false;
      }
    }
  }
}

final SearchController searchController2 = Get.put(SearchController());
