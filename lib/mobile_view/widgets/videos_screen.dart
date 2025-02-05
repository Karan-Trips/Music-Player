import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import 'package:yt_clone/mobile_view/getx/bottom_sheet.dart';
import 'package:yt_clone/mobile_view/ui/comments_card.dart';
import 'package:yt_clone/mobile_view/widgets/action_button.dart';
import 'package:yt_clone/mobile_view/widgets/export.dart';

class VideoScreenWidgets extends StatefulWidget {
  final int index;
  const VideoScreenWidgets({super.key, required this.index});

  @override
  State<VideoScreenWidgets> createState() => _VideoScreenWidgetsState();
}

class _VideoScreenWidgetsState extends State<VideoScreenWidgets> {
  late VideoModel videoModel;
  @override
  void initState() {
    super.initState();
    videoModel = videoinfo()[widget.index];
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(10.0.r),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            maxLines: 2,
            videoModel.videoTitle,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            '${videoModel.views}  ${videoModel.time}',
          ),
          SizedBox(height: 12.h),
          Row(
            children: [
              CircleAvatar(
                foregroundImage: NetworkImage(
                  videoModel.profileURl,
                ),
              ),
              SizedBox(
                width: 13.0.w,
              ),
              Text(
                videoModel.channelName,
                style: const TextStyle(fontWeight: FontWeight.w600),
              ),
              SizedBox(
                width: 13.0.h,
              ),
              Text(
                videoModel.subscribers,
                style: TextStyle(fontSize: 12.spMin),
              ),
              SizedBox(
                width: 90.0.w,
              ),
              const Spacer(),
              Obx(() {
                bool isSubscribed =
                    bottomNavController.isSubscribed(widget.index);

                if (isSubscribed) {
                  return GestureDetector(
                    onTap: () {
                      bottomNavController.updateSubscribed(widget.index, false);
                    },
                    child: const Icon(Icons.notifications_active),
                  );
                } else {
                  return ElevatedButton(
                    onPressed: () {
                      bottomNavController.updateIndexAndSubscribed(
                          widget.index, true);
                    },
                    child: const Text('Subscribe'),
                  );
                }
              }),
            ],
          ),
          SizedBox(
            height: 8.0.h,
          ),
          YoutubeButton(
            index: widget.index,
          ),
          SizedBox(
            height: 15.0.h,
          ),
          const CommentCard(),
          SizedBox(
            height: 15.0.h,
          ),
          VideoCard(
            title: videoModel.videoTitle,
            videoURL: videoModel.videoThumbnail,
            channelName: videoModel.channelName,
            views: videoModel.views,
            time: videoModel.time,
            channelProfileURL: videoModel.profileURl,
          )
        ],
      ),
    );
  }
}
