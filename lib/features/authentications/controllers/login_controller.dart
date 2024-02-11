import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:haven_glen/features/authentications/controllers/full_screen_loader.dart';
import 'package:haven_glen/features/authentications/controllers/network_manager.dart';
import 'package:haven_glen/features/authentications/models/authentication_repository.dart';
import 'package:haven_glen/features/authentications/screens/home/home_screen.dart';
import 'package:haven_glen/utils/helpers/snack_bar_dialog.dart';

class LoginController extends GetxController {
  final hidepassword = true.obs;
  final localStorage = GetStorage();
  final email = TextEditingController();
  final password = TextEditingController();
  GlobalKey<FormState> loginFormKey = GlobalKey<FormState>();

  // login with email and password
  Future<void> emailAndPasswordSignIn() async {
    try {
      ZFullScreenLoader.openLoadingDialog('Logging client in...');

      // check internet connectivity
      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        ZFullScreenLoader.stopLoading();
        return;
      }

      // form validation
      if (!loginFormKey.currentState!.validate()) {
        ZFullScreenLoader.stopLoading();
        return;
      }

      // login user in using auth
      final userCredential = await AuthenticationRepository.instance
          .loginWithEmailAndPassword(email.text.trim(), password.text.trim());
      //
      ZFullScreenLoader.stopLoading();

      // redirect
      Get.to(() => const HomeScreen());
      // AuthenticationRepository.instance.sc
    } catch (e) {
      SnackBarDialog.warningSnackBar(
          title: "Oh Snap, wrong password/Bad internet", message: e.toString());
      ZFullScreenLoader.stopLoading();
      return;
    }
  }
}
