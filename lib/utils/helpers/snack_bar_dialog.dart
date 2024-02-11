import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:haven_glen/utils/constants/colors.dart';
import 'package:iconsax/iconsax.dart';

class SnackBarDialog {
  static successSnackBar({required title, message = '', duration = 3}) {
    Get.snackbar(title, message,
        isDismissible: true,
        shouldIconPulse: true,
        colorText: ZColors.white,
        backgroundColor: ZColors.primary,
        duration: Duration(seconds: duration),
        margin: const EdgeInsets.all(10),
        snackPosition: SnackPosition.BOTTOM,
        icon: const Icon(
          Iconsax.check,
          color: ZColors.white,
        ));
  }

  static warningSnackBar({required title, message = '', duration = 3}) {
    Get.snackbar(title, message,
        isDismissible: true,
        shouldIconPulse: true,
        colorText: ZColors.white,
        backgroundColor: Colors.orange,
        duration: Duration(seconds: duration),
        margin: const EdgeInsets.all(10),
        snackPosition: SnackPosition.BOTTOM,
        icon: const Icon(
          Iconsax.warning_2,
          color: ZColors.white,
        ));
  }
}