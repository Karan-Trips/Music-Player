import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class AppDB {
  static const _appDbBox = '_appDbBox';

  final GetStorage _storage = GetStorage(_appDbBox);

  static Future<void> init() async {
    await GetStorage.init(_appDbBox);
  }

  T getValue<T>(String key, {T? defaultValue}) {
    return _storage.read<T>(key) ?? defaultValue as T;
  }

  void setValue<T>(String key, T value) {
    _storage.write(key, value);
  }

  bool get firstTime => getValue<bool>("firstTime", defaultValue: false);

  set firstTime(bool update) => setValue("firstTime", update);

  List<int> get likedSongs {
    return getValue<List<dynamic>>("likedSongs", defaultValue: []).cast<int>();
  }

  void likeSong(int songId) {
    final songs = likedSongs;
    if (!songs.contains(songId)) {
      songs.add(songId);
      setValue("likedSongs", songs);
    }
  }

  void unlikeSong(int songId) {
    final songs = likedSongs;
    if (songs.contains(songId)) {
      songs.remove(songId);
      setValue("likedSongs", songs);
    }
  }

  bool isLiked(int songId) => likedSongs.contains(songId);
}

final appDB = Get.put(AppDB());
