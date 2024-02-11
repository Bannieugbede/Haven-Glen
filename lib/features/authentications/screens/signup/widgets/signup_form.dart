// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
// import 'package:get_storage/get_storage.dart';
import 'package:haven_glen/features/authentications/controllers/signup_controllers.dart';
// import 'package:haven_glen/features/authentications/screens/home/home_screen.dart';
import 'package:haven_glen/features/localization/validation.dart';
import 'package:haven_glen/utils/constants/sizes.dart';
import 'package:haven_glen/utils/constants/text_strings.dart';
// import 'package:haven_glen/utils/helpers/snack_bar_dialog.dart';
import 'package:iconsax/iconsax.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ZSignUpForm extends StatefulWidget {
  const ZSignUpForm({
    super.key,
  });

  @override
  State<ZSignUpForm> createState() => _ZSignUpFormState();
}

class _ZSignUpFormState extends State<ZSignUpForm> {

  //
  late SharedPreferences sharedPreferences;
  @override
  Widget build(BuildContext context) {
    final controller = Get.put(SignupController());
    return Form(
      key: controller.signupFormKey,
      child: Column(
        children: [
          TextFormField(
            validator: (value) =>
                ZValidator.validateEmptyText('User Name', value),
            expands: false,
            decoration: const InputDecoration(
              labelText: ZTexts.username,
              prefixIcon: Icon(Iconsax.user_edit),
            ),
            controller: controller.username,
            // controller: userNameController,
          ),
          const SizedBox(height: ZSizes.spaceBtwInputFields),
          // email
          TextFormField(
            validator: (value) => ZValidator.validateEmptyText('Email', value),
            decoration: const InputDecoration(
              labelText: ZTexts.tagID,
              prefixIcon: Icon(Iconsax.personalcard),
            ),
            controller: controller.email,
            // controller: tagIdController,
          ),
          const SizedBox(height: ZSizes.spaceBtwInputFields),
          // phone number
          TextFormField(
            validator: (value) =>
                ZValidator.validateEmptyText('Phone Number', value),
            keyboardType: TextInputType.number,
            decoration: const InputDecoration(
              labelText: ZTexts.phoneNumber,
              prefixIcon: Icon(Iconsax.call),
            ),
            controller: controller.phoneNumber,
            // controller: phoneNumberController,
          ),
          const SizedBox(height: ZSizes.spaceBtwInputFields),
          // password
          Obx(
            () => TextFormField(
              validator: (value) =>
                  ZValidator.validateEmptyText('Password', value),
              obscureText: controller.hidePassword.value,
              decoration: InputDecoration(
                labelText: ZTexts.password,
                prefixIcon: const Icon(Iconsax.key),
                suffixIcon: IconButton(
                  onPressed: () => controller.hidePassword.value =
                      !controller.hidePassword.value,
                  icon: Icon(controller.hidePassword.value
                      ? Iconsax.eye_slash
                      : Iconsax.eye),
                ),
              ),
              controller: controller.password,
              // controller: passwordController,
            ),
          ),
          const SizedBox(height: ZSizes.spaceBtwSections),
          // terms and conditions check
          // const ZTermsAndConditionsCheckBox(),
          // const SizedBox(height: ZSizes.spaceBtwSections),
          // sign up button
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () => controller.signup(),
              child: const Text(ZTexts.createAccount),
            ),
          ),
        ],
      ),
    );
  }

}
