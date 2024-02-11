import 'package:flutter/material.dart';
import 'package:haven_glen/utils/constants/colors.dart';

class ZChipTheme {
  ZChipTheme._();

  // Light Theme
  static ChipThemeData lightChipThemeData = ChipThemeData(
    disabledColor: Colors.grey.withOpacity(0.4),
    labelStyle: const TextStyle(color: Colors.black),
    selectedColor: ZColors.primary,
    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
    checkmarkColor: Colors.white,
  );

  // Dark Theme
  static ChipThemeData darkChipThemeData = const ChipThemeData(
    disabledColor: Colors.grey,
    labelStyle: TextStyle(color: Colors.black),
    selectedColor: ZColors.primary,
    padding: EdgeInsets.symmetric(horizontal: 12, vertical: 12),
    checkmarkColor: Colors.white,
  );
}
