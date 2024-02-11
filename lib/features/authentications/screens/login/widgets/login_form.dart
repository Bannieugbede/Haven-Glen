import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:haven_glen/features/authentications/controllers/login_controller.dart';
import 'package:haven_glen/features/authentications/screens/signup/signup.dart';
import 'package:haven_glen/features/localization/validation.dart';
import 'package:haven_glen/utils/constants/sizes.dart';
import 'package:haven_glen/utils/constants/text_strings.dart';
import 'package:iconsax/iconsax.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({
    super.key,
  });

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  TextEditingController tagIdController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  // shared preference
  late SharedPreferences sharedPreferences;
  @override
  Widget build(BuildContext context) {
    final controller = Get.put(LoginController());
    return Form(
      key: controller.loginFormKey,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: ZSizes.spaceBtwSections),
        child: Column(
          children: [
            // email
            TextFormField(
              validator: (value) => ZValidator.validateEmail(value),
              keyboardType: TextInputType.name,
              controller: controller.email,
              decoration: const InputDecoration(
                prefixIcon: Icon(
                  Iconsax.personalcard,
                ),
                labelText: ZTexts.tagID,
              ),
            ),
            const SizedBox(height: ZSizes.spaceBtwInputFields),
            // password
            Obx(
              () => TextFormField(
                validator: (value) => ZValidator.validatePassword(value),
                controller: controller.password,
                obscureText: controller.hidepassword.value,
                decoration: InputDecoration(
                  prefixIcon: Icon(
                    Iconsax.key,
                  ),
                   suffixIcon: IconButton(
                  onPressed: () => controller.hidepassword.value =
                      !controller.hidepassword.value,
                  icon: Icon(controller.hidepassword.value
                      ? Iconsax.eye_slash
                      : Iconsax.eye),
                ),
                  labelText: ZTexts.password,
                ),
              ),
            ),
            const SizedBox(height: ZSizes.spaceBtwInputFields / 2),
            // remember me & forget password
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // remember me
                // Row(
                //   children: [
                //     Checkbox(value: true, onChanged: (value) {}),
                //     const Text(ZTexts.rememberMe),
                //   ],
                // ),
                // forget password
                // TextButton(
                //   onPressed: () => Get.to(() => const ForgetPassword()),
                //   child: const Text(ZTexts.forgotPassword),
                // ),
              ],
            ),
            const SizedBox(height: ZSizes.spaceBtwSections),
            // sign in button
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () => controller.emailAndPasswordSignIn(),
                child: const Text(ZTexts.logIn),
              ),
            ),
            const SizedBox(height: ZSizes.spaceBtwItems),
            //create account button
            SizedBox(
              width: double.infinity,
              child: OutlinedButton(
                onPressed: () => Get.to(() => const SignUpScreen()),
                child: const Text(ZTexts.createAccount),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
