import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:haven_glen/features/authentications/controllers/network_manager.dart';
import 'package:haven_glen/features/authentications/models/authentication_repository.dart';
import 'package:haven_glen/features/authentications/models/user_model.dart';
import 'package:haven_glen/features/authentications/models/user_repository.dart';
import 'package:haven_glen/features/authentications/screens/home/home_screen.dart';
import 'package:haven_glen/utils/helpers/snack_bar_dialog.dart';

class SignupController extends GetxController {
  static SignupController get instance => Get.find();

  // variables
  final hidePassword = true.obs;
  final email = TextEditingController();
  final username = TextEditingController();
  final phoneNumber = TextEditingController();
  final password = TextEditingController();
  final middleName = TextEditingController();
  GlobalKey<FormState> signupFormKey = GlobalKey<FormState>();

  // signup
  Future<void> signup() async {
    try {
      // check connection
      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) return;

      // form validation
      if (!signupFormKey.currentState!.validate()) return;

      // register and save user details
      final userCredential = await AuthenticationRepository.instance
          .registerWithEmailAndPassowrd(
              email.text.trim(), password.text.trim());
      //save user record
      final newUser = UserModel(
        clientId: userCredential.user!.uid,
        userName: username.text.trim(),
        emailId: email.text.trim(),
        password: password.text.trim(),
        phoneNumber: phoneNumber.text.trim(),
        profilePicture: '',
      );
      //
      final userRepository = Get.put(UserRepository());
      await userRepository.saveUserRecord(newUser);
      //
      SnackBarDialog.successSnackBar(
          title: 'Congratulations',
          message: 'Your account has been create, Successfully');
      //
      Get.to(() => const HomeScreen());
      //
    } catch (e) {}
  }
}
