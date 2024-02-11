// import 'dart:io';

// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:haven_glen/common/widgets/texts/section_heading.dart';
import 'package:haven_glen/features/authentications/controllers/user_controller.dart';
import 'package:haven_glen/features/authentications/models/user.dart';
import 'package:haven_glen/features/authentications/screens/login/login_screen.dart';
import 'package:haven_glen/features/authentications/screens/profile/widgets/profile_menu.dart';
import 'package:haven_glen/features/authentications/screens/profile/widgets/update_client_form.dart';
import 'package:haven_glen/utils/constants/colors.dart';
import 'package:haven_glen/utils/constants/profile_image.dart';
import 'package:haven_glen/utils/constants/sizes.dart';
import 'package:iconsax/iconsax.dart';
// import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  // Future<void> selectSnapProfilePic() async {
  //   final image = await ImagePicker().pickImage(
  //     source: ImageSource.camera,
  //     maxHeight: 512,
  //     maxWidth: 512,
  //     imageQuality: 90,
  //   );

  //   Reference ref = FirebaseStorage.instance
  //       .ref()
  //       .child('CustomerTag')
  //       .child("${UserKK.customerTagID.toLowerCase()}_profilepic.jpg");

  //   await ref.putFile(File(image!.path));

  //   //
  //   ref.getDownloadURL().then((value) async {
  //     setState(() {
  //       UserKK.profilePictureLink = value;
  //     });
  //     //
  //     await FirebaseFirestore.instance
  //         .collection("CustomerTag")
  //         .doc(UserKK.id)
  //         .update({
  //       'profilePic': value,
  //     });
  //   });
  // }

  //
  void logoutClient() {
    Get.defaultDialog(
      contentPadding: const EdgeInsets.all(ZSizes.md),
      title: 'Log Out Account',
      middleText: 'Are you sure you want to log out of this account?.',
      confirm: ElevatedButton(
        onPressed: () {
          logout();
        },
        style: ElevatedButton.styleFrom(
            backgroundColor: Colors.blue,
            side: const BorderSide(color: Colors.blue)),
        child: const Padding(
            padding: EdgeInsets.symmetric(horizontal: ZSizes.lg),
            child: Text('Log Out')),
      ),
      cancel: OutlinedButton(
        onPressed: () => Navigator.of(Get.overlayContext!).pop(),
        child: const Text('Cancel'),
      ),
    );
  }

  //
  @override
  Widget build(BuildContext context) {
    final controller = UserController.instance;
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text('Client Profile'),
        centerTitle: true,
        actions: [
          TextButton.icon(
              onPressed: () {
                logoutClient();
              },
              icon: const Icon(Iconsax.logout, color: ZColors.primary),
              label: const Text(
                'Log Out',
                style: TextStyle(color: ZColors.primary),
              )),
        ],
      ),
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              UserKK.canEdit
                  ? GestureDetector(
                      onTap: () => controller.uploadUserProfilePic(),
                      child: Container(
                        margin: const EdgeInsets.only(top: 40, bottom: 24),
                        alignment: Alignment.center,
                        height: 120,
                        width: 120,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: ZColors.primary,
                        ),
                        child: Center(
                          child: controller.user.value.profilePicture == ""
                              ? const Icon(
                                  Iconsax.personalcard5,
                                  color: ZColors.white,
                                  size: 50,
                                )
                              : ClipRRect(
                                  borderRadius: BorderRadius.circular(20),
                                  child: Obx(
                                    () => Image.network(
                                        fit: BoxFit.fill,
                                        '${controller.user.value.profilePicture}'),
                                  ),
                                ),
                        ),
                      ),
                    )
                  : const SizedBox(),
              Align(
                alignment: Alignment.center,
                child: Text(
                  "Client ID: ${controller.user.value.emailId}",
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
              const SizedBox(height: 24),
              const Divider(),
              const SizedBox(height: ZSizes.spaceBtwItems),

              // heading profile info
              const ZSectionHeading(
                  title: 'Profile Information', showActionButton: false),
              const SizedBox(height: ZSizes.spaceBtwItems),

              ZProfileMenu(
                title: 'Client Name:',
                value: '${controller.user.value.userName}',
              ),
              ZProfileMenu(
                title: 'Phone Number:',
                value: '${controller.user.value.phoneNumber}',
              ),

              const SizedBox(height: ZSizes.spaceBtwItems),
              const Divider(),
              UpdateClientForm(),
            ],
          ),
        ),
      ),
    );
  }

  //
  Future<void> logout() async {
    try {
      SharedPreferences preferences = await SharedPreferences.getInstance();
      await preferences.clear();
      Get.offAll(() => const LoginScreen());
    } catch (e) {
      throw 'Something went wrong, Please try again';
    }
  }
  //
}
