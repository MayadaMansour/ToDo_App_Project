import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../color_resource/color_resources.dart';

class MyThemeData {
  static final ThemeData lightMode = ThemeData(
    primaryColor: ColorResources.primaryLightColor,
    scaffoldBackgroundColor: ColorResources.bgLightColor,
    appBarTheme: AppBarTheme(
      backgroundColor: ColorResources.primaryLightColor,
      elevation: 0,
    ),
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor: ColorResources.primaryLightColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(100),
        side: BorderSide(color: ColorResources.white, width: 5),
      ),
    ),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      showSelectedLabels: false,
      showUnselectedLabels: false,
      elevation: 0,
      backgroundColor: Colors.transparent,
      selectedIconTheme:
          IconThemeData(size: 30, color: ColorResources.primaryLightColor),
      unselectedIconTheme: IconThemeData(size: 30, color: ColorResources.gray),
    ),
    textTheme: TextTheme(
      bodyLarge: GoogleFonts.poppins(
        color: ColorResources.white,
        fontWeight: FontWeight.bold,
        fontSize: 22,
      ),
      bodyMedium: GoogleFonts.poppins(
        color: ColorResources.white,
        fontWeight: FontWeight.w600,
        fontSize: 20,
      ),
      bodySmall: GoogleFonts.poppins(
        color: ColorResources.white,
        fontWeight: FontWeight.w400,
        fontSize: 18,
      ),
    ),
  );
}
