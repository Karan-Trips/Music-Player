import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CommentCard extends StatelessWidget {
  const CommentCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15.r),
      ),
      child: Padding(
        padding: EdgeInsets.all(10.r),
        child: Column(
          children: [
            Row(
              children: [
                const Text(
                  'Comments',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(
                  width: 5.0.w,
                ),
                const Text('1.7k'),
                SizedBox(
                  height: 4.0.h,
                ),
              ],
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 5.h, horizontal: 5.w),
              child: Row(
                children: [
                  const CircleAvatar(
                    foregroundImage: NetworkImage(
                        'https://wallpapers.com/images/featured/cool-profile-picture-87h46gcobjl5e4xu.jpg'),
                  ),
                  SizedBox(
                    width: 10.w,
                  ),
                  const Expanded(
                    child: Text(
                      'Ek no video hai bhaiiii..',
                    ),
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
