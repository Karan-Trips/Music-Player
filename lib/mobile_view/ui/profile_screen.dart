import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:yt_clone/mobile_view/ui/camera.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  XFile? capturedImage;
  final Map<String, IconData> _icons = {
    'Your Videos': Icons.home,
    'Downloads': Icons.play_arrow,
    'Your clips': Icons.subscriptions,
    'Your movies': Icons.video_library,
    'Time watched': Icons.web_asset,
    'Get YouTube Premium': Icons.video_library,
    'Time watched ': Icons.stacked_bar_chart_outlined,
    'Help and feedback': Icons.help_outline_outlined,
  };
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.cast,
            ),
          ),
          IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.notifications_none,
            ),
          ),
          IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.search,
            ),
          ),
          IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.settings,
            ),
          ),
        ],
      ),
      body: capturedImage != null
          ? Image.file(
              File(capturedImage!.path),
              height: 1.sh,
              width: 1.sw,
              fit: BoxFit.fill,
            )
          : SingleChildScrollView(
              child: Column(
                children: [
                  Padding(
                    padding: EdgeInsets.only(left: 8.0.w),
                    child: Row(
                      children: [
                        CircleAvatar(
                          radius: 35.0.r,
                          foregroundImage: const NetworkImage(
                              'https://wallpapers.com/images/featured/cool-profile-picture-87h46gcobjl5e4xu.jpg'),
                        ),
                        SizedBox(
                          width: 12.0.w,
                        ),
                        GestureDetector(
                          onTap: () {},
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Karan Tripathi',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 24.0.spMin,
                                ),
                              ),
                              Text(
                                '${'@karanbaap'} • ${'view channel >'}',
                                style: TextStyle(
                                  fontSize: 15.spMin,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 20.h,
                  ),
                  Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'History',
                              style: TextStyle(
                                  fontSize: 17.sp, fontWeight: FontWeight.bold),
                            ),
                            Container(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 8.r, vertical: 3.h),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(36.r),
                                  border: Border.all(color: Colors.white30)),
                              child: const Text('View all'),
                            )
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 200.h,
                        child: ListView.builder(
                            physics: const ClampingScrollPhysics(),
                            shrinkWrap: true,
                            scrollDirection: Axis.horizontal,
                            itemBuilder: (context, index) {
                              return Padding(
                                padding: EdgeInsets.symmetric(horizontal: 9.w),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      width: 200.w,
                                      height: 130.h,
                                      decoration: BoxDecoration(
                                        image: const DecorationImage(
                                          fit: BoxFit.cover,
                                          image: NetworkImage(
                                              'https://wallpapers.com/images/featured/cool-profile-picture-87h46gcobjl5e4xu.jpg'),
                                        ),
                                        borderRadius:
                                            BorderRadius.circular(15.r),
                                      ),
                                    ),
                                    const Padding(
                                      padding: EdgeInsets.all(8.0),
                                      child: Text("abdfauhsd\nasasd"),
                                    ),
                                  ],
                                ),
                              );
                            },
                            itemCount: 10),
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Playlists',
                              style: TextStyle(
                                  fontSize: 17.sp, fontWeight: FontWeight.bold),
                            ),
                            Container(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 8.r, vertical: 3.h),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(36.r),
                                  border: Border.all(color: Colors.white30)),
                              child: const Text('View all'),
                            )
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 200.h,
                        child: ListView.builder(
                            shrinkWrap: true,
                            scrollDirection: Axis.horizontal,
                            itemBuilder: (context, index) {
                              return Padding(
                                padding: EdgeInsets.symmetric(horizontal: 9.w),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      width: 200.w,
                                      height: 130.h,
                                      decoration: BoxDecoration(
                                        image: const DecorationImage(
                                          fit: BoxFit.cover,
                                          image: NetworkImage(
                                              'https://wallpapers.com/images/featured/cool-profile-picture-87h46gcobjl5e4xu.jpg'),
                                        ),
                                        borderRadius:
                                            BorderRadius.circular(15.r),
                                      ),
                                    ),
                                    const Padding(
                                      padding: EdgeInsets.all(8.0),
                                      child: Text("abdfauhsd\nasasd"),
                                    ),
                                  ],
                                ),
                              );
                            },
                            itemCount: 10),
                      ),
                      ListView.builder(
                          physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemBuilder: (context, index) {
                            var icons = _icons.keys.toList();

                            return Column(
                              children: [
                                ListTile(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (_) => CameraOverlayWidget(
                                          onImageCaptured: (XFile value) {
                                            setState(() {
                                              capturedImage = value;
                                            });
                                          },
                                        ),
                                      ),
                                    );
                                  },
                                  leading: Icon(_icons[icons[index]]),
                                  title: Text(icons[index]),
                                ),
                              ],
                            );
                          },
                          itemCount: _icons.length),
                    ],
                  )
                ],
              ),
            ),
    );
  }
}
