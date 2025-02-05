import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:yt_clone/mobile_view/getx/bottom_sheet.dart';
import 'package:yt_clone/mobile_view/ui/homepage.dart';
import 'package:yt_clone/mobile_view/ui/profile_screen.dart';

class YoutubeBottomNavigaton extends StatelessWidget {
  YoutubeBottomNavigaton({super.key});

  final List<Widget> pages = [
    const HomePage(),
    const Center(child: Text('This is a Shorts Area')),
    const Center(child: Text('This is a Creation Area')),
    const Center(child: Text('This is a Subscription Area')),
    const ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(() => IndexedStack(
            index: bottomNavController.selectedIndex.value,
            children: pages,
          )),
      bottomNavigationBar: Obx(() => BottomNavigationBar(
            selectedFontSize: 12.spMin,
            unselectedFontSize: 12.spMin,
            currentIndex: bottomNavController.selectedIndex.value,
            type: BottomNavigationBarType.fixed,
            elevation: 0.0,
            enableFeedback: true,
            onTap: bottomNavController.updateIndex,
            items: [
              BottomNavigationBarItem(
                icon: Icon(Icons.home_outlined, size: 25.sp),
                activeIcon: Icon(Icons.home, size: 25.0.sp),
                label: 'Home',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.cameraswitch_outlined, size: 25.0.sp),
                label: 'Shorts',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.add_circle_outline_sharp, size: 25.0.sp),
                label: '',
              ),
              BottomNavigationBarItem(
                  icon: Icon(Icons.subscriptions_outlined, size: 25.0.sp),
                  label: 'Subscriptions',
                  activeIcon: Icon(Icons.subscriptions, size: 25.0.sp)),
              const BottomNavigationBarItem(
                icon: CircleAvatar(
                  backgroundColor: Colors.purple,
                  backgroundImage: NetworkImage(
                      'https://wallpapers.com/images/featured/cool-profile-picture-87h46gcobjl5e4xu.jpg'),
                ),
                label: 'You',
              ),
            ],
          )),
    );
  }
}
