// ignore_for_file: use_full_hex_values_for_flutter_colors

import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class FrostedGlassEffect extends StatelessWidget {
  const FrostedGlassEffect(
      {super.key,
      required this.child,
      this.height,
      this.width,
      this.margin,
      this.padding});
  final Widget child;
  final double? height;
  final double? width;
  final double? margin;
  final EdgeInsets? padding;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 1.sw,
      padding: EdgeInsets.symmetric(horizontal: margin ?? 23).r,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20).r,
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(
                0.5,
              ),
              borderRadius: BorderRadius.circular(20).r,
              border: Border.all(),
            ),
            padding: padding,
            child: child,
          ),
        ),
      ),
    );
  }
}
