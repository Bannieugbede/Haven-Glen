import 'package:flutter/material.dart';
// import 'package:haven_glen/features/authentications/models/user.dart';
import 'package:haven_glen/features/authentications/models/user_model.dart';
import 'package:haven_glen/features/authentications/screens/home/home_screen.dart';
import 'package:haven_glen/features/authentications/screens/login/login_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthCheck extends StatefulWidget {
  const AuthCheck({super.key});

  @override
  State<AuthCheck> createState() => _AuthCheckState();
}

class _AuthCheckState extends State<AuthCheck> {
  bool userAvailable = false;
  late SharedPreferences sharedPreferences;
  //
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    //
    _getCurrentUser();
  }

  void _getCurrentUser() async {
    sharedPreferences = await SharedPreferences.getInstance();

    try {
      if (sharedPreferences.getString("customerTagID") != null) {
        setState(() {
          UserModel.mid = sharedPreferences.getString("customerTagID")!;
          // UserModel.customerTagID = sharedPreferences.getString("customerTagID")!;
          userAvailable = true;
        });
      }
    } catch (e) {
      setState(() {
        userAvailable = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return userAvailable ? const HomeScreen() : const LoginScreen();
  }
}
