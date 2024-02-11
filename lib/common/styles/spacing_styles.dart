import 'package:flutter/material.dart';
import 'package:haven_glen/utils/constants/sizes.dart';

class ZSpacingStyle {
  static const EdgeInsetsGeometry paddingWithAppBarHeight = EdgeInsets.only(
    top: ZSizes.appBarHeight,
    left: ZSizes.defaultSpace,
    bottom: ZSizes.defaultSpace,
    right: ZSizes.defaultSpace,
  );
}
