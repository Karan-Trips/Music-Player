import 'package:get/get.dart';

class BottomNavController extends GetxController {
  var selectedIndex = 0.obs;
  var subscribedVideos = <int, bool>{}.obs;
  var likedVideos = <int, bool>{}.obs;

  bool isSubscribed(int index) {
    return subscribedVideos[index] ?? false;
  }

  bool isLiked(int index) {
    return likedVideos[index] ?? false;
  }

  void toggleLike(int index) {
    bool currentValue = isLiked(index);
    likedVideos[index] = !currentValue;
  }

  void updateIndex(int index) {
    selectedIndex.value = index;
  }

  void updateSubscribed(int index, bool value) {
    subscribedVideos[index] = value;
  }

  void updateIndexAndSubscribed(int index, bool value) {
    selectedIndex.value = index;
    updateSubscribed(index, value);
  }
}

final BottomNavController bottomNavController = Get.put(BottomNavController());
