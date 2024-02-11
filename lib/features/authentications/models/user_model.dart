// import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  String? clientId;
  String? emailId;
  String? userName;
  String? phoneNumber;
  String? password;
  String? profilePicture;
  static double lat = 0;
  static double long = 0;
  static String recordId = "";
  static String mid = "";
  static String ppLink = " ";
  // bool? canEdit = true;

  UserModel({
    this.clientId,
    this.emailId,
    this.userName,
    this.password,
    this.phoneNumber,
    this.profilePicture,
  });


  static UserModel empty() => UserModel(
      clientId: '',
      userName: '',
      emailId: '',
      password: '',
      phoneNumber: '',
      profilePicture: '');

  // convert to json and save
  Map<String, dynamic> toJson() {
    return {
      'UserName': userName,
      'Email': emailId,
      'PhoneNumber': phoneNumber,
      'Password': password,
      'ProfilePicture': profilePicture,
    };
  }


  //
  factory UserModel.fromSnapshot(
      DocumentSnapshot<Map<String, dynamic>> document) {
    if (document.data() != null) {
      final data = document.data()!;
      return UserModel(
        clientId: document.id,
        userName: data["UserName"] ?? '',
        phoneNumber: data["PhoneNumber"] ?? '',
        password: data["password"] ?? '',
        emailId: data["Email"] ?? '',
        profilePicture: data["ProfilePicture"] ?? '',
      );
    } else {
      return UserModel.empty();
    }
  }
}
