import 'package:dart_ytmusic_api/types.dart';
import 'package:get/get.dart';
import '../../widgets/yt_music_service.dart';

class SearchController extends GetxController {
  var isLoading = false.obs;
  RxList searchResults = <SongDetailed>[].obs;
  RxList searchArtists = <ArtistFull>[].obs;

  Future<void> searchSongs(String query) async {
    if (query.isEmpty) {
      searchResults.clear();
      return;
    }
    try {
      isLoading.value = true;
      final results = await ytMusicService.searchSongs(query);
      searchResults.assignAll(results);
    } catch (e) {
      print("❌ Error fetching search results: $e");
    }
  }

  Future<void> fetchDefaultArtists(List<String> artistIds) async {
    try {
      final fetchedArtists = await Future.wait(
        artistIds.map((id) async {
          try {
            return await ytMusicService.showArtist(id);
          } catch (e) {
            print("⚠️ Error fetching artist $id: $e");
            return null;
          }
        }),
      );

      final validArtists = fetchedArtists.whereType<ArtistFull>().toList();
      searchArtists.assignAll(validArtists);
    } catch (e) {
      print("❌ Error fetching multiple artists: $e");
    }
  }

  Future<ArtistFull?> fetchArtist(String artistId) async {
    try {
      final artist = await ytMusicService.showArtist(artistId);
      return artist;
    } catch (e) {
      print("❌ Error fetching artist details: $e");
      return null;
    }
  }

  // Future<List<HomeSection>> getHomeScreen() async {
  //   try {
  //     final artist = await ytMusicService.getHomeScreen();
  //     return artist;
  //   } catch (e) {
  //     print("❌ Error fetching artist details: $e");
  //     return [];
  //   }
  // }
}

final SearchController searchController2 = Get.put(SearchController());
