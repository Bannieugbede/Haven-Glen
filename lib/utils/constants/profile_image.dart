import 'package:flutter/material.dart';
import 'package:haven_glen/utils/constants/colors.dart';
import 'package:haven_glen/utils/constants/sizes.dart';
import 'package:haven_glen/utils/helpers/helper_functions.dart';

class ZNetworkImage extends StatelessWidget {
  const ZNetworkImage(
      {super.key,
      this.fit,
      required this.image,
      this.isNetworkImage = false,
      this.overLayColor,
      this.backgroundColor,
      this.width = 100,
      this.height = 100,
      this.padding = ZSizes.sm});

  final BoxFit? fit;
  final String image;
  final bool isNetworkImage;
  final Color? overLayColor;
  final Color? backgroundColor;
  final double width, height, padding;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      padding: EdgeInsets.all(padding),
      color: backgroundColor ??
          (ZHelperFunctions.isDarkMode(context)
              ? ZColors.black
              : ZColors.white),
      child: Center(
        child: Image(
          image: isNetworkImage
              ? NetworkImage(image)
              : AssetImage(image) as ImageProvider,
          color: overLayColor,
          fit: fit,
        ),
      ),
    );
  }
}
