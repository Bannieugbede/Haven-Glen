import 'package:flutter/material.dart';
import 'package:haven_glen/utils/constants/colors.dart';

// Light & Dark Outlined Button Themes
class ZOutlinedButtonTheme {
  ZOutlinedButtonTheme._(); //To avoid creating instances

  // Light Theme
  static final lightOutlinedButtonTheme = OutlinedButtonThemeData(
    style: OutlinedButton.styleFrom(
      elevation: 0,
      foregroundColor: Colors.black,
      side: const BorderSide(color: ZColors.primary),
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
      textStyle: const TextStyle(
          fontSize: 16, color: Colors.black, fontWeight: FontWeight.w600),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
    ),
  );

  // Dark Theme
  static final darkOutlinedButtonTheme = OutlinedButtonThemeData(
    style: OutlinedButton.styleFrom(
      elevation: 0,
      foregroundColor: Colors.white,
      side: const BorderSide(color: ZColors.primary),
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
      textStyle: const TextStyle(
          fontSize: 16, color: Colors.white, fontWeight: FontWeight.w600),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
    ),
  );
}
