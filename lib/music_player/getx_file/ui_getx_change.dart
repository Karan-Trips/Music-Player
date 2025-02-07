import 'package:get/get.dart';

class NavigationController extends GetxController {
  var selectedIndex = 0.obs;
  RxBool isLiked = false.obs;

  void changeIndex(int index) {
    selectedIndex.value = index;
  }

  void toggelLike(int index) {
    isLiked.value = !isLiked.value;
  }
}

final NavigationController navController = Get.put(NavigationController());
