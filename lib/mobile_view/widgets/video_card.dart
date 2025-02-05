import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class VideoCard extends StatelessWidget {
  final String title;
  final String videoURL;
  final String channelName;
  final String views;
  final String time;
  final String channelProfileURL;

  const VideoCard(
      {super.key,
      required this.title,
      required this.videoURL,
      required this.channelName,
      required this.views,
      required this.time,
      required this.channelProfileURL});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Stack(
          children: [
            Image.network(
              height: 190.h,
              videoURL,
            ),
            Positioned(
              bottom: 10,
              right: 10,
              child: Container(
                color: Colors.black,
                child: Text(
                  '3.05',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 12.0.spMin,
                  ),
                ),
              ),
            ),
          ],
        ),
        Padding(
          padding: EdgeInsets.all(8.0.r),
          child: Row(
            children: [
              CircleAvatar(
                foregroundImage: NetworkImage(channelProfileURL),
              ),
              SizedBox(
                width: 12.w,
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      title,
                      style: const TextStyle(
                        fontWeight: FontWeight.w600,
                      ),
                      maxLines: 2,
                    ),
                    Text(
                      '$channelName • $views • $time',
                      style: TextStyle(
                        fontSize: 12.0.spMin,
                      ),
                      maxLines: 2,
                    ),
                  ],
                ),
              ),
              const Spacer(),
              const Icon(
                Icons.more_vert,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
