import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get/get.dart';
import 'package:haven_glen/features/authentications/models/authentication_repository.dart';
import 'package:haven_glen/features/authentications/models/user_model.dart';
import 'package:haven_glen/features/localization/firebase_auth_exceptions.dart';
import 'package:image_picker/image_picker.dart';

class UserRepository extends GetxController {
  static UserRepository get instance => Get.find();

  final FirebaseFirestore _db = FirebaseFirestore.instance;
  //

  Future<void> saveUserRecord(UserModel user) async {
    try {
      await _db.collection("CustomerTag").doc(user.clientId).set(user.toJson());
    } on FirebaseException catch (e) {
      throw ZFirebaseAuthException(e.code).message;
    } catch (e) {
      throw 'Something went wrong, please try again';
    }
  }

  // fetch user details
  Future<UserModel> fetchUserRecord() async {
    try {
      final documentSnapshot = await _db
          .collection("CustomerTag")
          .doc(AuthenticationRepository.instance.authUser?.uid)
          .get();
      if (documentSnapshot.exists) {
        return UserModel.fromSnapshot(documentSnapshot);
      } else {
        return UserModel.empty();
      }
    } on FirebaseException catch (e) {
      throw ZFirebaseAuthException(e.code).message;
    } catch (e) {
      throw 'Something went wrong, please try again';
    }
  }

  // update user data
  Future<void> updateUserRecord(UserModel updatedUser) async {
    try {
      await _db
          .collection("CustomerTag")
          .doc(updatedUser.clientId)
          .update(updatedUser.toJson());
    } on FirebaseException catch (e) {
      throw ZFirebaseAuthException(e.code).message;
    } catch (e) {
      throw 'Something went wrong, please try again';
    }
  }

  // update any flied in specific user collection
  Future<void> updateSingleField(Map<String, dynamic> json) async {
    try {
      await _db
          .collection("CustomerTag")
          .doc(AuthenticationRepository.instance.authUser?.uid)
          .update(json);
    } on FirebaseException catch (e) {
      throw ZFirebaseAuthException(e.code).message;
    } catch (e) {
      throw 'Something went wrong, please try again';
    }
  }

  // remove user data from firestore
  Future<void> removeUserRecord(String userId) async {
    try {
      await _db.collection("CustomerTag").doc(userId).delete();
    } on FirebaseException catch (e) {
      throw ZFirebaseAuthException(e.code).message;
    } catch (e) {
      throw 'Something went wrong, please try again';
    }
  }

  // upload image
  Future<String> uploadImage(String path, XFile image) async {
    try {
      final ref = FirebaseStorage.instance.ref(path).child(image.name);
      await ref.putFile(File(image.path));
      final url = await ref.getDownloadURL();
      return url;
    } on FirebaseException catch (e) {
      throw ZFirebaseAuthException(e.code).message;
    } catch (e) {
      throw 'Something went wrong, please try again';
    }
  }
}
