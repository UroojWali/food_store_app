import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:food_store/theme/theme_colors.dart';
import 'package:google_fonts/google_fonts.dart';

OutlineInputBorder errorBorder() {
  return OutlineInputBorder(
    borderSide: BorderSide(
      color: Colors.redAccent.shade100,
    ),
    borderRadius: BorderRadius.circular(10.r),
  );
}

OutlineInputBorder normalBorder() {
  return OutlineInputBorder(
    borderSide: const BorderSide(
      color: Colors.white,
    ),
    borderRadius: BorderRadius.circular(10.r),
  );
}

class ThemeBuilder {
  static ThemeData buildTheme(BuildContext context, Brightness brightness) {
    ThemeColors themeColors = LightThemeColors();
    if (brightness == Brightness.dark) {
      themeColors = DarkThemeColors();
    }

    return ThemeData(
      useMaterial3: true,
      splashColor: themeColors.primaryColor,
      colorScheme: ColorScheme.fromSeed(
        seedColor: themeColors.primaryColor,
        brightness: brightness,
      ),
      scaffoldBackgroundColor: themeColors.white,
      textTheme: GoogleFonts.openSansTextTheme(
        Theme.of(context).textTheme,
      ).apply(
        bodyColor: themeColors.textColor,
        displayColor: themeColors.textColor,
      ),
      // iconTheme: IconThemeData(
      //   color: themeColors.primaryColor,
      //   size: 30,
      // ),
      // iconButtonTheme: IconButtonThemeData(
      //   style: IconButton.styleFrom(
      //     foregroundColor: themeColors.primaryColor,
      //     backgroundColor: themeColors.primaryVariantColor,
      //     fixedSize: const Size.square(60),
      //     shape: RoundedRectangleBorder(
      //       borderRadius: BorderRadius.circular(10),
      //     ),
      //   ),
      // ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: themeColors.primaryVariantColor,
        border: normalBorder(),
        enabledBorder: normalBorder(),
        focusedBorder: normalBorder(),
        errorBorder: errorBorder(),
        focusedErrorBorder: errorBorder(),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: themeColors.primaryColor,
          foregroundColor: themeColors.primaryVariantColor,
          textStyle: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 13.sp,
          ),
          padding: EdgeInsets.symmetric(
            horizontal: 20.w,
            vertical: 15.h,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.r),
          ),
        ),
      ),
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          backgroundColor: themeColors.blue,
          foregroundColor: themeColors.primaryVariantColor,
          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
          shape: RoundedRectangleBorder(
            // side: BorderSide(color: themeColors.primaryVariantColor),
            borderRadius: BorderRadius.circular(10.r),
          ),
        ),
      ),
    );
  }
}
