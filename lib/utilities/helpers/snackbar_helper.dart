import 'package:flutter/material.dart';
import 'package:food_store/theme/theme_colors.dart';

class SnackBarHelper {
  static SnackBar errorSnackBar(Color backgroundColor, String message) {
    return SnackBar(
      elevation: 0,
      behavior: SnackBarBehavior.floating,
      backgroundColor: backgroundColor,
      margin: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 2),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      content: Text(
        message,
        style: const TextStyle(color: Colors.white),
      ),
    );
  }

  static SnackBar successSnackBar(BuildContext context, String message) {
    return SnackBar(
      elevation: 0,
      behavior: SnackBarBehavior.floating,
      backgroundColor: ThemeColors.getThemeColors(context).green,
      margin: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 2),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      content: Text(
        message,
        style: const TextStyle(color: Colors.white),
      ),
    );
  }
}
