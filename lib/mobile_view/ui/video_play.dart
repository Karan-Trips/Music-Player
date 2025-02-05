// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import '../widgets/export.dart';

class VideoPlayerScreen extends StatefulWidget {
  VideoPlayerScreen({super.key, required this.index});
  int index;

  @override
  State<VideoPlayerScreen> createState() => _VideoPlayerScreenState();
}

class _VideoPlayerScreenState extends State<VideoPlayerScreen> {
  late VideoModel videomodel;

  @override
  void initState() {
    super.initState();
    videomodel = videoinfo()[widget.index];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: CustomScrollView(
          shrinkWrap: true,
          slivers: [
            SliverToBoxAdapter(
              child: Column(
                children: [
                  Image.network(
                    videomodel.videoThumbnail,
                    fit: BoxFit.cover,
                  ),
                  const LinearProgressIndicator(
                    value: 0.5,
                    valueColor: AlwaysStoppedAnimation(Colors.red),
                  ),
                  VideoScreenWidgets(
                    index: widget.index,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
