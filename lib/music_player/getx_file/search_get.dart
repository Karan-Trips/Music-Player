import 'package:get/get.dart';
import 'package:on_audio_query/on_audio_query.dart';

class SearchController extends GetxController {
  final OnAudioQuery _audioQuery = OnAudioQuery();
  var allSongs = <SongModel>[].obs;
  var filteredSongs = <SongModel>[].obs;
  var isLoading = true.obs;

  @override
  void onInit() {
    super.onInit();
    fetchSongs();
  }

  Future<void> fetchSongs() async {
    try {
      var songs = await _audioQuery.querySongs(
        sortType: SongSortType.TITLE,
        orderType: OrderType.ASC_OR_SMALLER,
        uriType: UriType.EXTERNAL,
      );

      allSongs.assignAll(songs);
      filteredSongs.assignAll(songs);
    } finally {
      isLoading(false);
    }
  }

  void filterSongs(String query) {
    if (query.isEmpty) {
      filteredSongs.assignAll(allSongs);
    } else {
      filteredSongs.assignAll(
        allSongs.where((song) =>
            song.title.toLowerCase().contains(query.toLowerCase()) ||
            (song.artist?.toLowerCase() ?? '').contains(query.toLowerCase())),
      );
    }
  }
}

final SearchController searchController = Get.put(SearchController());
