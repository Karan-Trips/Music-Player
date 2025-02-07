import 'package:dart_ytmusic_api/types.dart';
import 'package:get/get.dart';

import '../../widgets/yt_music_service.dart';

class SearchController extends GetxController {
  var isLoading = false.obs;
  var searchResults = <SongDetailed>[].obs;

  Future<List<SongDetailed>> searchSongs(String query) async {
    if (query.isEmpty) {
      searchResults.clear();
      return [];
    }
    try {
      isLoading.value = true;
      final results = await ytMusicService.searchSongs(query);
      searchResults.assignAll(results);
      return results;
    } catch (e) {
      print("Error fetching search results: $e");
      return [];
    } finally {
      isLoading.value = false;
    }
  }
  
}

final SearchController searchController2 = Get.put(SearchController());
