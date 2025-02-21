// import 'package:flutter/material.dart';
// import 'package:dart_ytmusic_api/types.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:loading_animation_widget/loading_animation_widget.dart';
// import '../../widgets/yt_music_service.dart';

// class PlaylistPage extends StatefulWidget {
//   final PlaylistDetailed playlist;

//   const PlaylistPage({super.key, required this.playlist});

//   @override
//   State<PlaylistPage> createState() => _PlaylistPageState();
// }

// class _PlaylistPageState extends State<PlaylistPage> {
//   PlaylistFull? songs;
//   bool isLoading = true;

//   @override
//   void initState() {
//     super.initState();
//     fetchPlaylistSongs();
//   }

//   Future<void> fetchPlaylistSongs() async {
//     try {
//       songs = await ytMusicService.playlistDetails(widget.playlist.playlistId);
//       setState(() {
//         isLoading = false;
//       });
//     } catch (e) {
//       print("Error fetching playlist details: $e");
//       setState(() {
//         isLoading = false;
//       });
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text(widget.playlist.name)),
//       body: isLoading
//           ? Center(
//               child: LoadingAnimationWidget.staggeredDotsWave(
//                 color: Colors.red,
//                 size: 40.sp,
//               ),
//             )
//           : ListView.builder(
//               itemCount: songs.length,
//               itemBuilder: (context, index) {
//                 final song = songs[index];
//                 return ListTile(
//                   leading: song.thumbnails.isNotEmpty
//                       ? Image.network(song.thumbnails.last.url,
//                           width: 50, height: 50)
//                       : const Icon(Icons.music_note),
//                   title: Text(song.name),
//                   subtitle: Text(song.artist.name),
//                 );
//               },
//             ),
//     );
//   }
// }
