import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:haven_glen/utils/constants/colors.dart';
import 'package:haven_glen/utils/helpers/helper_functions.dart';
// import 'package:flutter_svg/flutter_svg.dart';

class ZFullScreenLoader {
  static void openLoadingDialog(String text) {
    showDialog(
      context: Get.overlayContext!,
      barrierDismissible: false,
      builder: (_) => PopScope(
        canPop: false,
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          home: Container(
            color: ZHelperFunctions.isDarkMode(Get.context!)
                ? ZColors.dark
                : ZColors.white,
            width: double.infinity,
            height: double.infinity,
            child: const Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Center(
                  child: Image(image: AssetImage('assets/Eclipse1.gif')),
                  // child: SvgPicture.asset('assets/Eclipse1.gif'),
                  // child: Image(image: SvgPicture.asset('assets/Eclipse.svg')),
                  // child: CircularProgressIndicator(color: ZColors.primary),
                  // child: Text('Loading.......'),
                ),
                // Text(
                //   'Loading...',
                //   style: TextStyle(fontSize: 20),
                // ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  //
  static stopLoading() {
    Navigator.of(Get.overlayContext!).pop();
  }
}
