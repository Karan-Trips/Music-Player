import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:flutter/material.dart';

class ThemeCOntroller extends GetxController {
  final _box = GetStorage();
  RxBool isDarkMode = false.obs;

  @override
  void onInit() {
    super.onInit();
    isDarkMode.value = _box.read('isDarkMode') ?? false;
  }

  void toggleTheme() {
    isDarkMode.value = !isDarkMode.value;
    _box.write('isDarkMode', isDarkMode.value);
    Get.changeThemeMode(isDarkMode.value ? ThemeMode.dark : ThemeMode.light);
  }
}
