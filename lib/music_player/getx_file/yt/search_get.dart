import 'package:dart_ytmusic_api/types.dart';
import 'package:get/get.dart';
import 'package:on_audio_query/on_audio_query.dart';

class SearchController extends GetxController {
  final OnAudioQuery _audioQuery = OnAudioQuery();

  var allSongs = <SongModel>[].obs;
  var filteredSongs = <SongModel>[].obs;
  var songListYt = Rx<SongFull?>(null);

  var isLoading = true.obs;
  Rx<int> selectedIndex = 0.obs;

  @override
  void onInit() {
    super.onInit();
    fetchSongs();
  }

  Future<void> fetchSongs() async {
    isLoading.value = true;
    try {
      var songs = await _audioQuery.querySongs(
        sortType: SongSortType.TITLE,
        orderType: OrderType.ASC_OR_SMALLER,
        uriType: UriType.EXTERNAL,
      );

      if (songs.isNotEmpty) {
        allSongs.assignAll(songs);
        filteredSongs.assignAll(songs);
      }
    } catch (e) {
      print("❌ Error fetching songs: $e");
    } finally {
      isLoading.value = false;
    }
  }

  void updateSelectedIndex(int index) {
    selectedIndex.value = index;
  }

  void setYTSong(SongFull song) {
    songListYt.value = song;
  }
}

final SearchController searchController = Get.put(SearchController());
