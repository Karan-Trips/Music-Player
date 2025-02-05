// ignore_for_file: unused_element

import 'package:audio_service/audio_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:theme_provider/theme_provider.dart';
import 'package:yt_clone/music_player/ui/home_screen_main.dart';

// import 'music_player/notification/background_player.dart';

late AudioHandler _audioHandler;
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // _audioHandler = await AudioService.init(
  //   builder: () => AudioPlayerHandler(),
  //   config: const AudioServiceConfig(
  //     androidNotificationChannelId: 'com.ryanheise.myapp.channel.audio',
  //     androidNotificationChannelName: 'Audio playback',
  //     androidNotificationOngoing: true,
  //   ),
  // );
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
