import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:haven_glen/features/authentications/models/authentication_repository.dart';
import 'package:haven_glen/features/authentications/models/user_model.dart';
import 'package:haven_glen/features/authentications/models/user_repository.dart';
import 'package:haven_glen/features/authentications/screens/login/login_screen.dart';
import 'package:haven_glen/utils/helpers/snack_bar_dialog.dart';
import 'package:image_picker/image_picker.dart';

class UserController extends GetxController {
  static UserController get instance => Get.find();

  Rx<UserModel> user = UserModel.empty().obs;
  final userRepository = Get.put(UserRepository());

  @override
  void onInit() {
    super.onInit();
    fetchUserRecord();
  }

  // fetch user record
  Future<void> fetchUserRecord() async {
    try {
      final user = await userRepository.fetchUserRecord();
      this.user(user);
    } catch (e) {
      user(UserModel.empty());
    }
  }

  // save user record from any registration provider
  Future<void> saveUserRecord(UserCredential? userCredentials) async {
    try {
      if (userCredentials != null) {}
    } catch (e) {
      SnackBarDialog.warningSnackBar(
          title: 'Data not saved',
          message: 'something went wrong while saving user information');
    }
  }

  // delete user account
  void deleteUserAccount() async {
    try {
      await AuthenticationRepository.instance.deleteAccount();
      SnackBarDialog.successSnackBar(
          title: 'Account Deleted', message: 'Client account has been deleted');
      Get.offAll(() => const LoginScreen());
    } catch (e) {}
  }

  //
  uploadUserProfilePic() async {
    try {
      final image = await ImagePicker().pickImage(
        source: ImageSource.camera,
        maxHeight: 512,
        maxWidth: 512,
        imageQuality: 70,
      );

      if (image != null) {
        final imageUrl = await userRepository.uploadImage(
            'CustomerTag/Images/Profile', image);

        // upload user image to record
        Map<String, dynamic> json = {'ProfilePicture': imageUrl};
        await userRepository.updateSingleField(json);

        user.value.profilePicture = imageUrl;
      }
      SnackBarDialog.successSnackBar(
          title: 'Congratulations',
          message: 'Your profile image has been updates');
    } catch (e) {
      SnackBarDialog.warningSnackBar(title: "Oh Snap", message: e.toString());
    }
  }
}
