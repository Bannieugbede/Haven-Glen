import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:haven_glen/features/authentications/models/user_repository.dart';
import 'package:haven_glen/features/localization/firebase_auth_exceptions.dart';

class AuthenticationRepository extends GetxController {
  static AuthenticationRepository get instance => Get.find();
  // Get.put(AuthenticationRepository());

  // variable
  final deviceStorage = GetStorage();
  final _auth = FirebaseAuth.instance;

  //get auth user data
  User? get authUser => _auth.currentUser;

  // register user email & password
  Future<UserCredential> registerWithEmailAndPassowrd(
      String email, String password) async {
    try {
      return await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
    } on FirebaseAuthException catch (_) {
      throw "Fire";
    }
  }

  Future<UserCredential> loginWithEmailAndPassword(
      String email, String password) async {
    try {
      return await _auth.signInWithEmailAndPassword(
          email: email, password: password);
    } on FirebaseAuthException catch (e) {
      throw ZFirebaseAuthException(e.code).message;
    } on FirebaseException catch (e) {
      throw ZFirebaseAuthException(e.code).message;
    } catch (e) {
      throw 'Wrong detail, something went wrong';
    }
  }

  Future<void> deleteAccount() async {
    try {
      await UserRepository.instance.removeUserRecord(_auth.currentUser!.uid);
      await _auth.currentUser?.delete();
    } catch (e) {
      throw 'Wrong detail, something went wrong';
    }
  }
}
