
import 'package:another_flushbar/flushbar.dart';
import 'package:base_project/resources/app_colors.dart';
import 'package:flutter/material.dart';


class FlushBarMessageUtil {

  static void showFlushBar({
    required BuildContext context,
    required String message,
    FlushBarType flushBarType = FlushBarType.info,
    int durationInSeconds = 3,
  }) {
    Flushbar(
      message: message,
      duration: Duration(seconds: durationInSeconds),
      backgroundColor: _getBackgroundColor(flushBarType),
      margin: const EdgeInsets.all(8.0),
      borderRadius: BorderRadius.circular(8.0),
      flushbarPosition: FlushbarPosition.BOTTOM,
      icon: _getIcon(flushBarType),
      leftBarIndicatorColor: _getBackgroundColor(flushBarType),
    ).show(context);
  }

  static Color _getBackgroundColor(FlushBarType flushBarType) {
    switch (flushBarType) {
      case FlushBarType.success:
        return AppColors.success;
      case FlushBarType.error:
        return AppColors.error;
      case FlushBarType.warning:
        return AppColors.warning;
      case FlushBarType.info:
        return AppColors.info;
      case FlushBarType.general:
        return AppColors.darkGrey;
      default:
        return AppColors.info;
    }
  }

  static Icon _getIcon(FlushBarType flushBarType) {
    switch (flushBarType) {
      case FlushBarType.success:
        return const Icon(Icons.check_circle, color: Colors.white);
      case FlushBarType.error:
        return const Icon(Icons.error, color: Colors.white);
      case FlushBarType.warning:
        return const Icon(Icons.warning, color: Colors.white);
      case FlushBarType.info:
        return const Icon(Icons.info, color: Colors.white);
      case FlushBarType.general:
        return const Icon(Icons.notifications, color: Colors.white);
      default:
        return const Icon(Icons.info, color: Colors.white);
    }
  }
}
enum FlushBarType { success, error, warning, info, general }