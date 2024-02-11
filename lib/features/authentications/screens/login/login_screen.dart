import 'package:flutter/material.dart';
import 'package:haven_glen/common/styles/spacing_styles.dart';
import 'package:haven_glen/features/authentications/screens/login/widgets/login_form.dart';
import 'package:haven_glen/utils/constants/colors.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  double screenHeight = 0;
  double screenWidth = 0;
  @override
  Widget build(BuildContext context) {
    screenHeight = MediaQuery.of(context).size.height;
    screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                height: screenHeight / 3,
                width: screenWidth,
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    fit: BoxFit.fill,
                    image: AssetImage('assets/HAVEN GLEN.png'),
                  ),
                  color: ZColors.primary,
                  borderRadius: BorderRadius.only(
                    bottomRight: Radius.circular(50),
                    bottomLeft: Radius.circular(50),
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.only(
                  top: screenHeight / 15,
                  bottom: screenHeight / 20,
                ),
                child: const Text(
                  'Login',
                  style: TextStyle(
                    letterSpacing: 2,
                    fontSize: 18,
                  ),
                ),
              ),
              Container(
                alignment: Alignment.centerLeft,
                margin: EdgeInsets.symmetric(horizontal: screenWidth / 12),
                child: Text(
                  'Client Tag',
                  style: TextStyle(
                    fontSize: screenWidth / 25,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              const Padding(
                padding: ZSpacingStyle.paddingWithAppBarHeight,
                child: Column(
                  children: [
                    LoginForm(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
