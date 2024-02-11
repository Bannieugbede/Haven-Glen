import 'package:flutter/material.dart';
// import 'package:get/get.dart';
import 'package:haven_glen/features/authentications/screens/signup/widgets/signup_form.dart';
import 'package:haven_glen/utils/constants/sizes.dart';
import 'package:haven_glen/utils/constants/text_strings.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(ZSizes.defaultSpace),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // title
                Text(ZTexts.signUpTitle,
                    style: Theme.of(context).textTheme.headlineMedium),
                const SizedBox(height: ZSizes.spaceBtwSections),
                // form
                const ZSignUpForm(),
                const SizedBox(height: ZSizes.spaceBtwSections),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
