// ignore_for_file: avoid_classes_with_only_static_members, constant_identifier_names

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get_utils/src/extensions/export.dart';

import 'package:yt_clone/music_player/widgets/export.dart';

enum MessageType { INFO, ERROR, WARNING, SUCCESS }

extension SnackBarExtension on BuildContext {
  void showMessage(String message,
      {MessageType type = MessageType.INFO,
      bool? fullWidth,
      double? borderRadius,
      Duration? duration}) {
    ScaffoldMessenger.of(this).showSnackBar(
      SnackBar(
        elevation: 5.0,
        margin: fullWidth == true
            ? const EdgeInsets.only(bottom: 0)
            : EdgeInsets.only(bottom: 24.h, left: 20.w, right: 20.w),
        behavior: SnackBarBehavior.floating,
        backgroundColor: type == MessageType.INFO
            ? AppColor.textGreen
            : type == MessageType.ERROR
                ? AppColor.red
                : AppColor.primaryColor,
        content: Text(
          maxLines: 3,
          message,
          style: TextStyle(
            fontSize: 15.spMin,
          ),
          textAlign: TextAlign.center,
        ),
        padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 15).r,
        duration: duration ?? 1200.milliseconds,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(borderRadius ?? 10.r)),
        ),
      ),
    );
  }

  void showError(String? error) {
    if (error != null) {
      showMessage(error);
    }
  }

  void showSuccess(String? success) {
    if (success != null) {
      showMessage(success);
    }
  }
}

extension ToastExtension on BuildContext {
  void showToastMessage(
    String message, {
    MessageType type = MessageType.INFO,
  }) {
    Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      backgroundColor: type == MessageType.INFO
          ? AppColor.textGreen
          : type == MessageType.ERROR
              ? AppColor.red
              : AppColor.primaryColor,
      textColor: AppColor.white,
      fontSize: 15.0,
    );
  }

  void showErrorToast(String? error) {
    if (error != null) {
      showToastMessage(error, type: MessageType.ERROR);
    }
  }

  void showSuccessToast(String? success) {
    if (success != null) {
      showToastMessage(success, type: MessageType.SUCCESS);
    }
  }
}

String formatDuration(Duration duration) {
  String twoDigits(int n) => n.toString().padLeft(2, "0");
  String minutes = twoDigits(duration.inMinutes.remainder(60));
  String seconds = twoDigits(duration.inSeconds.remainder(60));
  return "$minutes:$seconds";
}
