import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:get/get.dart';
import 'package:haven_glen/features/authentications/controllers/user_controller.dart';
import 'package:haven_glen/features/authentications/models/authentication_repository.dart';
import 'package:haven_glen/features/authentications/models/user_model.dart';
import 'package:haven_glen/utils/constants/colors.dart';
import 'package:intl/intl.dart';
import 'package:slide_to_act/slide_to_act.dart';

class TagSlider extends StatefulWidget {
  const TagSlider({super.key});

  @override
  State<TagSlider> createState() => _TagSliderState();
}

class _TagSliderState extends State<TagSlider> {
  //
  double screenHeight = 0;
  double screenWidth = 0;

  String checkIn = "--/--";
  String checkOut = "--/--";
  String location = "";
  //
  UserModel userDetails = UserModel();
  //
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _getRecord();
  }

  void _getLocation() async {
    List<Placemark> placemark =
        await placemarkFromCoordinates(UserModel.lat, UserModel.long);

    setState(() {
      location =
          "${placemark[0].street}, ${placemark[0].administrativeArea}, ${placemark[0].postalCode}, ${placemark[0].country}";
    });
  }

  //
  void _getRecord() async {
    try {
      QuerySnapshot snap = await FirebaseFirestore.instance
          .collection("CustomerTag")
          .where('id', isEqualTo: userDetails.emailId)
          .get();

      DocumentSnapshot snap2 = await FirebaseFirestore.instance
          .collection("CustomerTag")
          .doc(AuthenticationRepository.instance.authUser?.uid)
          .collection("Record")
          .doc(DateFormat('dd MMMM yyyy').format(DateTime.now()))
          .get();

      setState(() {
        checkIn = snap2['checkIn'];
        checkOut = snap2['checkOut'];
      });
    } catch (e) {
      setState(() {
        checkIn = "--/--";
        checkOut = "--/--";
      });
    }
  }

  //
  void _showBottonSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(30),
        ),
      ),
      builder: (context) => DraggableScrollableSheet(
        expand: false,
        builder: (context, scrollcontroller) => SingleChildScrollView(
          controller: scrollcontroller,
          child: Container(
            margin: const EdgeInsets.only(top: 24, bottom: 12),
            child: Builder(builder: (context) {
              final GlobalKey<SlideActionState> key = GlobalKey();

              //
              return SlideAction(
                text: checkIn == "--/--"
                    ? "Slide to Check In"
                    : "Slide to Check Out",
                textStyle: TextStyle(
                  color: Colors.black54,
                  fontSize: screenWidth / 20,
                ),
                outerColor: ZColors.white,
                innerColor: ZColors.primary,
                key: key,
                onSubmit: () async {
                  if (UserModel.lat != 0) {
                    _getLocation();
                    //
                    //
                    QuerySnapshot snap = await FirebaseFirestore.instance
                        .collection("CustomerTag")
                        .where('id', isEqualTo: userDetails.emailId)
                        .get();

                    DocumentSnapshot snap2 = await FirebaseFirestore.instance
                        .collection("CustomerTag")
                        .doc(AuthenticationRepository.instance.authUser?.uid)
                        .collection("Record")
                        .doc(DateFormat('dd MMMM yyyy').format(DateTime.now()))
                        .get();

                    try {
                      String checkIn = snap2['checkIn'];
                      //
                      setState(() {
                        checkOut = DateFormat('hh:mm a').format(DateTime.now());
                      });
                      //
                      await FirebaseFirestore.instance
                          .collection("CustomerTag")
                          .doc(AuthenticationRepository.instance.authUser?.uid)
                          .collection("Record")
                          .doc(
                              DateFormat('dd MMMM yyyy').format(DateTime.now()))
                          .update({
                        'date': Timestamp.now(),
                        'checkIn': checkIn,
                        'checkOut':
                            DateFormat('hh:mm a').format(DateTime.now()),
                        'checkInLocation': location,
                      });
                    } catch (e) {
                      setState(() {
                        checkIn = DateFormat('hh:mm a').format(DateTime.now());
                      });
                      //
                      await FirebaseFirestore.instance
                          .collection("CustomerTag")
                          .doc(AuthenticationRepository.instance.authUser?.uid)
                          .collection("Record")
                          .doc(
                              DateFormat('dd MMMM yyyy').format(DateTime.now()))
                          .set({
                        'date': Timestamp.now(),
                        'checkIn': DateFormat('hh:mm a').format(DateTime.now()),
                        'checkOut': "--/--",
                        'checkOutLocation': location,
                      });
                    }

                    key.currentState!.reset();

                    //
                  } else {
                    Timer(const Duration(seconds: 3), () async {
                      _getLocation();
                      //
                      QuerySnapshot snap = await FirebaseFirestore.instance
                          .collection("CustomerTag")
                          .where('id', isEqualTo: userDetails.emailId)
                          // isEqualTo: UserKK.customerTagID)
                          .get();

                      DocumentSnapshot snap2 = await FirebaseFirestore.instance
                          .collection("CustomerTag")
                          .doc(AuthenticationRepository.instance.authUser?.uid)
                          // .doc(snap.docs[0].id)
                          .collection("Record")
                          .doc(
                              DateFormat('dd MMMM yyyy').format(DateTime.now()))
                          .get();

                      try {
                        String checkIn = snap2['checkIn'];
                        //
                        setState(() {
                          checkOut =
                              DateFormat('hh:mm a').format(DateTime.now());
                        });
                        //
                        await FirebaseFirestore.instance
                            .collection("CustomerTag")
                            .doc(
                                AuthenticationRepository.instance.authUser?.uid)
                            // .doc(snap.docs[0].id)
                            .collection("Record")
                            .doc(DateFormat('dd MMMM yyyy')
                                .format(DateTime.now()))
                            .update({
                          'date': Timestamp.now(),
                          'checkIn': checkIn,
                          'checkOut':
                              DateFormat('hh:mm a').format(DateTime.now()),
                          'checkInLocation': location,
                        });
                      } catch (e) {
                        setState(() {
                          checkIn =
                              DateFormat('hh:mm a').format(DateTime.now());
                        });
                        //
                        await FirebaseFirestore.instance
                            .collection("CustomerTag")
                            .doc(
                                AuthenticationRepository.instance.authUser?.uid)
                            // .doc(snap.docs[0].id)
                            .collection("Record")
                            .doc(DateFormat('dd MMMM yyyy')
                                .format(DateTime.now()))
                            .set({
                          'date': Timestamp.now(),
                          'checkIn':
                              DateFormat('hh:mm a').format(DateTime.now()),
                          'checkOut': checkOut,
                          // 'checkOut': "--/--",
                          'checkOutLocation': location,
                        });
                      }

                      key.currentState!.reset();
                    });
                  }
                },
              );
            }),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(UserController());
    return Scaffold(
      body: Column(children: [
        Text('weuieuui'),
      ]),
    );
  }
}
