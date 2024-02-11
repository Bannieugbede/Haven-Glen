import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:haven_glen/features/authentications/controllers/network_manager.dart';
import 'package:haven_glen/features/authentications/controllers/user_controller.dart';
import 'package:haven_glen/features/authentications/models/user_repository.dart';
import 'package:haven_glen/utils/helpers/snack_bar_dialog.dart';

class UpdateNameController extends GetxController {
  static UpdateNameController get instance => Get.find();

  final userName = TextEditingController();
  final phoneNumber = TextEditingController();
  final userController = UserController.instance;
  final userRepository = Get.put(UserRepository());
  GlobalKey<FormState> updateUserNameFormKey = GlobalKey<FormState>();

  //
  @override
  void onInit() {
    initializeNames();
    super.onInit();
  }

  //fetch user record
  Future<void> initializeNames() async {
    userName.text = userController.user.value.userName!;
    userName.text = userController.user.value.userName!;
  }

  //
  Future<void> updateUserName() async {
    try {
      // check connection
      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) return;

      // form validation
      if (!updateUserNameFormKey.currentState!.validate()) return;

      // update Rx user value
      Map<String, dynamic> name = {'UserName': userName.text.trim()};
      await userRepository.updateSingleField(name);

      // update Rx user value
      userController.user.value.userName = userName.text.trim();
      userController.user.value.phoneNumber = phoneNumber.text.trim();

      SnackBarDialog.successSnackBar(
          title: 'Congratulations',
          message: 'Your account has been updated, Successfully');

      userName.clear();
      phoneNumber.clear();
      //
      // Get.to(() => const ());
      //
    } catch (e) {
      // ZFullScreenLoader.stopLoading();
      SnackBarDialog.warningSnackBar(title: "Oh Snap", message: e.toString());
    }
  }
}
