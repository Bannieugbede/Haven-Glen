// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:haven_glen/features/authentications/controllers/update_name_controller.dart';
import 'package:haven_glen/features/authentications/controllers/user_controller.dart';
// import 'package:haven_glen/features/authentications/models/user.dart';
// import 'package:haven_glen/features/authentications/models/user_repository.dart';
// import 'package:haven_glen/features/authentications/screens/login/login_screen.dart';
import 'package:haven_glen/features/localization/validation.dart';
import 'package:haven_glen/utils/constants/colors.dart';
import 'package:haven_glen/utils/constants/sizes.dart';
import 'package:haven_glen/utils/constants/text_strings.dart';
// import 'package:haven_glen/utils/helpers/snack_bar_dialog.dart';
import 'package:iconsax/iconsax.dart';
// import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:get/get.dart';

class UpdateClientForm extends StatefulWidget {
  const UpdateClientForm({
    super.key,
  });

  @override
  State<UpdateClientForm> createState() => _UpdateClientFormState();
}

class _UpdateClientFormState extends State<UpdateClientForm> {
  TextEditingController usernameController = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();
  //
  void deleteAccountWarningPopup() {
    Get.defaultDialog(
      contentPadding: const EdgeInsets.all(ZSizes.md),
      title: 'Delete Account',
      middleText:
          'Are you sure you want to delete your account permanently? This action is not reversible and all of your data will be removed permanently.',
      confirm: ElevatedButton(
        onPressed: () => controllerDel.deleteUserAccount(),
        // Replace 'userIdToDelete' with the actual user's document ID
        //   await deleteUserAccount();

        // },
        style: ElevatedButton.styleFrom(
            backgroundColor: Colors.red,
            side: const BorderSide(color: Colors.red)),
        child: const Padding(
            padding: EdgeInsets.symmetric(horizontal: ZSizes.lg),
            child: Text('Delete')),
      ),
      cancel: OutlinedButton(
        onPressed: () => Navigator.of(Get.overlayContext!).pop(),
        child: const Text('Cancel'),
      ),
    );
  }

  final controllerDel = Get.put(UserController());
  //
  @override
  Widget build(BuildContext context) {
    final controller = Get.put(UpdateNameController());
    final controllerTel = UserController.instance;
    return Form(
      key: controller.updateUserNameFormKey,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: ZSizes.spaceBtwSections),
        child: Column(
          children: [
            TextFormField(
              controller: controller.userName,
              validator: (value) =>
                  ZValidator.validateEmptyText('User Name', value),
              decoration: const InputDecoration(
                prefixIcon: Icon(
                  Iconsax.personalcard,
                ),
                labelText: ZTexts.username,
              ),
            ),
            const SizedBox(height: ZSizes.spaceBtwInputFields),
            TextFormField(
              keyboardType: TextInputType.number,
              validator: (value) =>
                  ZValidator.validateEmptyText('Phone Number', value),
              controller: controller.phoneNumber,
              decoration: const InputDecoration(
                prefixIcon: Icon(
                  Iconsax.call,
                ),
                labelText: ZTexts.phoneNumber,
              ),
            ),
            const SizedBox(height: ZSizes.spaceBtwSections),
            // edit details button
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () => controller.updateUserName(),
                child: const Text(ZTexts.updateClientDetails),
              ),
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Column(
                  children: [
                    IconButton(
                      style: ButtonStyle(
                          elevation: MaterialStateProperty.all(5),
                          shadowColor: MaterialStateProperty.all(Colors.grey),
                          backgroundColor:
                              MaterialStateProperty.all(Colors.green)),
                      onPressed: () async {
                        final Uri url = Uri(
                          scheme: "tel",
                          path: controllerTel.user.value.phoneNumber,
                        );
                        if (await canLaunchUrl(url)) {
                          await launchUrl(url);
                        } else {
                          print("cannot lunch this url");
                        }
                      },
                      icon: const Icon(Iconsax.call),
                      color: Colors.white,
                      iconSize: 35,
                    ),
                    const SizedBox(height: ZSizes.spaceBtwItems / 2),
                    const Text(
                      "Call Client",
                      style: TextStyle(
                        color: ZColors.darkGrey,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
                Column(
                  children: [
                    IconButton(
                      onPressed: () {
                        deleteAccountWarningPopup();
                      },
                      icon: const Icon(Iconsax.trash),
                      color: Colors.white,
                      iconSize: 35,
                      style: ButtonStyle(
                          elevation: MaterialStateProperty.all(5),
                          shadowColor: MaterialStateProperty.all(Colors.grey),
                          backgroundColor:
                              MaterialStateProperty.all(Colors.red)),
                    ),
                    const SizedBox(height: ZSizes.spaceBtwItems / 2),
                    const Text(
                      "Delete Account",
                      style: TextStyle(
                        color: ZColors.darkGrey,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
  //
}
