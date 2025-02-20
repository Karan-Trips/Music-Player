import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:audioplayers/audioplayers.dart';

class DownloadsPage extends StatefulWidget {
  const DownloadsPage({super.key});

  @override
  State<DownloadsPage> createState() => _DownloadsPageState();
}

class _DownloadsPageState extends State<DownloadsPage> {
  final String musicDir = "/storage/emulated/0/Music/";
  final String thumbnailDir = "/storage/emulated/0/Music/.thumbnail/";
  List<FileSystemEntity> downloadedFiles = [];
  final AudioPlayer _audioPlayer = AudioPlayer();

  @override
  void initState() {
    super.initState();
    // _requestPermissions();
    _loadDownloadedFiles();
  }

  // Future<void> _requestPermissions() async {
  //   if (await Permission.storage.request().isGranted) {
  //     _loadDownloadedFiles();
  //   } else {
  //     Get.snackbar(
  //         "Permission Denied", "Storage access is needed to show downloads");
  //   }
  // }

  void _loadDownloadedFiles() {
    final dir = Directory(musicDir);
    if (dir.existsSync()) {
      setState(() {
        downloadedFiles =
            dir.listSync().where((file) => file.path.endsWith(".mp3")).toList();
      });
    }
  }

  void _playSong(String filePath) async {
    try {
      await _audioPlayer.stop();
      await _audioPlayer.play(DeviceFileSource(filePath));
    } catch (e) {
      // Get.snackbar("Error", "Failed to play song: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Downloads")),
      body: downloadedFiles.isEmpty
          ? const Center(child: Text("No downloads found"))
          : ListView.builder(
              itemCount: downloadedFiles.length,
              itemBuilder: (context, index) {
                String filePath = downloadedFiles[index].path;
                String fileName =
                    filePath.split("/").last.replaceAll(".mp3", "");
                String thumbnailPath = "$thumbnailDir$fileName.jpg";

                return ListTile(
                  leading: File(thumbnailPath).existsSync()
                      ? Image.file(File(thumbnailPath),
                          width: 50, height: 50, fit: BoxFit.cover)
                      : const Icon(Icons.music_note),
                  title: Text(fileName,
                      maxLines: 1, overflow: TextOverflow.ellipsis),
                  subtitle: const Text("Tap to play"),
                  onTap: () => _playSong(filePath),
                );
              },
            ),
    );
  }
}
