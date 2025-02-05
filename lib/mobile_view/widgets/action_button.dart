import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:yt_clone/mobile_view/widgets/export.dart';

import '../getx/bottom_sheet.dart';

class YoutubeButton extends StatelessWidget {
  const YoutubeButton({super.key, required this.index});
  final int index;

  @override
  Widget build(BuildContext context) {
    VideoModel videoModel = videoinfo()[index];
    return InkWell(
      onTap: () {},
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(50.r),
              ),
              child: Obx(() {
                bool liked = bottomNavController.isLiked(index);

                return TextButton.icon(
                  onPressed: () {
                    bottomNavController.toggleLike(index);
                  },
                  icon: liked
                      ? const Icon(Icons.thumb_up_alt, color: Colors.blue)
                      : const Icon(Icons.thumb_up_alt_outlined),
                  label: Text(
                    videoModel.like,
                  ),
                );
              }),
            ),
            const SizedBox(
              width: 8.0,
            ),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(50.r),
              ),
              child: IconButton(
                onPressed: () {},
                icon: const Icon(
                  Icons.thumb_down,
                ),
              ),
            ),
            const SizedBox(
              width: 8.0,
            ),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(50.r),
              ),
              child: TextButton.icon(
                onPressed: () {},
                icon: const Icon(
                  Icons.screen_share,
                ),
                label: const Text(
                  'Share',
                ),
              ),
            ),
            SizedBox(
              width: 8.0.w,
            ),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(50.r),
              ),
              child: TextButton.icon(
                onPressed: () {},
                icon: const Icon(
                  Icons.video_library_rounded,
                ),
                label: const Text(
                  'Remix',
                ),
              ),
            ),
            SizedBox(
              width: 8.0.w,
            ),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(50.r),
              ),
              child: TextButton.icon(
                onPressed: () {},
                icon: const Icon(
                  Icons.download,
                ),
                label: const Text(
                  'Download',
                ),
              ),
            ),
            SizedBox(
              width: 8.0.w,
            ),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(50.r),
              ),
              child: TextButton.icon(
                onPressed: () {},
                icon: const Icon(
                  Icons.cut_outlined,
                ),
                label: const Text(
                  'Clip',
                ),
              ),
            ),
            SizedBox(
              width: 8.0.w,
            ),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(50.r),
              ),
              child: TextButton.icon(
                onPressed: () {},
                icon: const Icon(
                  Icons.add_to_photos_sharp,
                ),
                label: const Text(
                  'Save',
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
