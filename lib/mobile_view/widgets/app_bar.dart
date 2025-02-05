import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class CustomAppBar extends StatelessWidget {
  const CustomAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      floating: true,
      title: const Text(
        'Youtube',
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25.0),
      ),
      centerTitle: false,
      leading: Padding(
        padding: EdgeInsets.symmetric(vertical: 3.0.h, horizontal: 8.w),
        child: FaIcon(
          FontAwesomeIcons.youtube,
          color: Colors.red,
          size: 45.0.spMin,
        ),
      ),
      actions: [
        IconButton(
          onPressed: () {},
          icon: const Icon(Icons.cast),
        ),
        IconButton(
          onPressed: () {},
          icon: const Icon(Icons.notifications),
        ),
        IconButton(
          onPressed: () {},
          icon: const Icon(Icons.search),
        ),
      ],
    );
  }
}
