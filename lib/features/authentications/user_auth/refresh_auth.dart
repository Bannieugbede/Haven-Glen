//
import 'package:firebase_auth/firebase_auth.dart';

class RefreshAuth {
 static Future<User?> refreshUser() async {
    await FirebaseAuth.instance.currentUser?.reload();
    return FirebaseAuth.instance.currentUser;
  }
}
