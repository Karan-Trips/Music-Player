// ignore_for_file: unused_element

import 'package:audio_session/audio_session.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:just_audio_background/just_audio_background.dart';
import 'package:theme_provider/theme_provider.dart';
import 'package:yt_clone/music_player/getx_file/fetch_songs.dart';

import 'package:yt_clone/music_player/ui/home_screen_main.dart';
import 'package:yt_clone/music_player/widgets/yt_music_service.dart';

import 'music_player/hive/app_db.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await AppDB.init();
  Get.put(AppDB());
  Get.lazyPut(() => SongPlayerController(), fenix: true);
  await ytMusicService.initialize();
  // TODO:Under Develpment
  await JustAudioBackground.init(
    androidNotificationChannelId: 'com.ryanheise.bg_demo.channel.audio',
    androidNotificationChannelName: 'Audio playback',
    androidNotificationOngoing: true,
  );
  final session = await AudioSession.instance;
  await session.configure(const AudioSessionConfiguration.music());
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
