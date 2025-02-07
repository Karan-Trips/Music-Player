import 'package:get/get.dart';
import 'package:yt_clone/music_player/hive/app_db.dart';

class NavController extends GetxController {
  var likedSongs = <int>[].obs;

  @override
  void onInit() {
    super.onInit();
    likedSongs.assignAll(appDB.likedSongs);
  }

  void toggelLike(int songId) {
    if (likedSongs.contains(songId)) {
      likedSongs.remove(songId);
      appDB.unlikeSong(songId);
    } else {
      likedSongs.add(songId);
      appDB.likeSong(songId);
    }
  }

  bool isLiked(int songId) => likedSongs.contains(songId);
}

final navController = Get.put(NavController());
