// ignore_for_file: unused_element

import 'package:dart_ytmusic_api/yt_music.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:theme_provider/theme_provider.dart';

import 'package:yt_clone/music_player/ui/home_screen_main.dart';
import 'package:yt_clone/music_player/widgets/yt_music_service.dart';

import 'music_player/hive/app_db.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await AppDB.init();
  Get.put(AppDB());
  await ytMusicService.initialize();
  // TODO:Under Develpment
  // await AudioService.init(
  //   builder: () => AudioPlayerHandler(),
  //   config: AudioServiceConfig(
  //     androidNotificationChannelId: 'com.example.yt_clone',
  //     androidNotificationChannelName: 'Audio Service',
  //     androidNotificationOngoing: true,
  //   ),
  // );
  // _audioHandler = await AudioService.init(
  //   builder: () => AudioPlayerHandler(),
  //   config: const AudioServiceConfig(
  //     androidNotificationChannelId: '',
  //     androidNotificationChannelName: 'Audio playback',
  //     androidNotificationOngoing: true,
  //   ),
  // );
  // TODO:Under Develpment
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]).then((value) {
    runApp(
      const MyApp(),
    );
  });
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ThemeProvider(
      themes: [
        AppTheme.light(),
        AppTheme.dark(),
      ],
      child: Builder(builder: (context) {
        final Brightness brightness = MediaQuery.of(context).platformBrightness;
        final isDarkMode = brightness == Brightness.dark;

        return ScreenUtilInit(
          builder: (context, child) {
            return GetMaterialApp(
              debugShowCheckedModeBanner: false,
              theme: isDarkMode ? AppTheme.dark().data : AppTheme.light().data,
              home: const MusicHomeScreen(),
            );
          },
        );
      }),
    );
  }
}
