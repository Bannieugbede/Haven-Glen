import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:get/get.dart';
import 'package:haven_glen/features/authentications/controllers/user_controller.dart';
import 'package:haven_glen/features/authentications/models/authentication_repository.dart';
// import 'package:haven_glen/features/authentications/models/user.dart';
import 'package:haven_glen/features/authentications/models/user_model.dart';
import 'package:haven_glen/utils/constants/colors.dart';
import 'package:intl/intl.dart';
import 'package:slide_to_act/slide_to_act.dart';

class ClientCurrentInfoScreen extends StatefulWidget {
  const ClientCurrentInfoScreen({super.key});

  @override
  State<ClientCurrentInfoScreen> createState() =>
      _ClientCurrentInfoScreenState();
}

class _ClientCurrentInfoScreenState extends State<ClientCurrentInfoScreen> {
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
  @override
  Widget build(BuildContext context) {
    screenHeight = MediaQuery.of(context).size.height;
    screenWidth = MediaQuery.of(context).size.width;
    final controller = Get.put(UserController());
    return Scaffold(
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Container(
              margin: const EdgeInsets.only(top: 40),
              alignment: Alignment.centerLeft,
              child: Text(
                'WELCOME',
                style: TextStyle(
                  fontSize: screenWidth / 18,
                ),
              ),
            ),
            Container(
              alignment: Alignment.centerLeft,
              child: Obx(
                () => Text("${controller.user.value.userName}",
                    style: TextStyle(
                        fontSize: screenWidth / 15,
                        fontWeight: FontWeight.bold)),
              ),
            ),
            Container(
              margin: const EdgeInsets.only(top: 30),
              alignment: Alignment.centerLeft,
              child: Text("Today's Status",
                  style: TextStyle(
                      fontSize: screenWidth / 18, fontWeight: FontWeight.bold)),
            ),
            Container(
              margin: const EdgeInsets.only(top: 12, bottom: 32),
              height: 150,
              decoration: BoxDecoration(
                color: ZColors.white,
                boxShadow: const [
                  BoxShadow(
                      color: Colors.black26,
                      blurRadius: 10,
                      offset: Offset(2, 2)),
                ],
                borderRadius: BorderRadius.circular(20),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          'Check In',
                          style: TextStyle(
                              fontSize: screenWidth / 20,
                              fontWeight: FontWeight.w500,
                              color: Colors.black54),
                        ),
                        Text(
                          checkIn,
                          style: TextStyle(
                              fontSize: screenWidth / 18,
                              fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          'Check Out',
                          style: TextStyle(
                              fontSize: screenWidth / 20,
                              fontWeight: FontWeight.w500,
                              color: Colors.black54),
                        ),
                        Text(
                          checkOut,
                          style: TextStyle(
                              fontSize: screenWidth / 18,
                              fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Container(
              alignment: Alignment.centerLeft,
              child: RichText(
                text: TextSpan(
                  text: DateTime.now().day.toString(),
                  style: TextStyle(
                      fontSize: screenWidth / 18,
                      fontWeight: FontWeight.bold,
                      color: ZColors.primary),
                  children: [
                    TextSpan(
                      text: DateFormat(' MMMM yyyy').format(DateTime.now()),
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: screenWidth / 18,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            StreamBuilder(
                stream: Stream.periodic(const Duration(seconds: 1)),
                builder: (context, snapshot) {
                  return Container(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      DateFormat('hh:mm:ss a').format(DateTime.now()),
                      style: TextStyle(
                          fontSize: screenWidth / 20,
                          fontWeight: FontWeight.w500,
                          color: Colors.black54),
                    ),
                  );
                }),
            checkOut == "--/--"
                ? Container(
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
                            QuerySnapshot snap = await FirebaseFirestore
                                .instance
                                .collection("CustomerTag")
                                .where('id', isEqualTo: userDetails.emailId)
                                .get();

                            DocumentSnapshot snap2 = await FirebaseFirestore
                                .instance
                                .collection("CustomerTag")
                                .doc(AuthenticationRepository
                                    .instance.authUser?.uid)
                                .collection("Record")
                                .doc(DateFormat('dd MMMM yyyy')
                                    .format(DateTime.now()))
                                .get();

                            try {
                              String checkIn = snap2['checkIn'];
                              //
                              setState(() {
                                checkOut = DateFormat('hh:mm a')
                                    .format(DateTime.now());
                              });
                              //
                              await FirebaseFirestore.instance
                                  .collection("CustomerTag")
                                  .doc(AuthenticationRepository
                                      .instance.authUser?.uid)
                                  .collection("Record")
                                  .doc(DateFormat('dd MMMM yyyy')
                                      .format(DateTime.now()))
                                  .update({
                                'date': Timestamp.now(),
                                'checkIn': checkIn,
                                'checkOut': DateFormat('hh:mm a')
                                    .format(DateTime.now()),
                                'checkInLocation': location,
                              });
                            } catch (e) {
                              setState(() {
                                checkIn = DateFormat('hh:mm a')
                                    .format(DateTime.now());
                              });
                              //
                              await FirebaseFirestore.instance
                                  .collection("CustomerTag")
                                  .doc(AuthenticationRepository
                                      .instance.authUser?.uid)
                                  .collection("Record")
                                  .doc(DateFormat('dd MMMM yyyy')
                                      .format(DateTime.now()))
                                  .set({
                                'date': Timestamp.now(),
                                'checkIn': DateFormat('hh:mm a')
                                    .format(DateTime.now()),
                                'checkOut': checkOut,
                                // 'checkOut': "--/--",
                                'checkOutLocation': location,
                              });
                            }

                            // key.currentState!.reset();

                            //
                          } else {
                            Timer(const Duration(seconds: 3), () async {
                              _getLocation();
                              //
                              QuerySnapshot snap = await FirebaseFirestore
                                  .instance
                                  .collection("CustomerTag")
                                  .where('id', isEqualTo: userDetails.emailId)
                                  // isEqualTo: UserKK.customerTagID)
                                  .get();

                              DocumentSnapshot snap2 = await FirebaseFirestore
                                  .instance
                                  .collection("CustomerTag")
                                  .doc(AuthenticationRepository
                                      .instance.authUser?.uid)
                                  // .doc(snap.docs[0].id)
                                  .collection("Record")
                                  .doc(DateFormat('dd MMMM yyyy')
                                      .format(DateTime.now()))
                                  .get();

                              try {
                                String checkIn = snap2['checkIn'];
                                //
                                setState(() {
                                  checkOut = DateFormat('hh:mm a')
                                      .format(DateTime.now());
                                });
                                //
                                await FirebaseFirestore.instance
                                    .collection("CustomerTag")
                                    .doc(AuthenticationRepository
                                        .instance.authUser?.uid)
                                    // .doc(snap.docs[0].id)
                                    .collection("Record")
                                    .doc(DateFormat('dd MMMM yyyy')
                                        .format(DateTime.now()))
                                    .update({
                                  'date': Timestamp.now(),
                                  'checkIn': checkIn,
                                  'checkOut': DateFormat('hh:mm a')
                                      .format(DateTime.now()),
                                  'checkInLocation': location,
                                });
                              } catch (e) {
                                setState(() {
                                  checkIn = DateFormat('hh:mm a')
                                      .format(DateTime.now());
                                });
                                //
                                await FirebaseFirestore.instance
                                    .collection("CustomerTag")
                                    .doc(AuthenticationRepository
                                        .instance.authUser?.uid)
                                    // .doc(snap.docs[0].id)
                                    .collection("Record")
                                    .doc(DateFormat('dd MMMM yyyy')
                                        .format(DateTime.now()))
                                    .set({
                                  'date': Timestamp.now(),
                                  'checkIn': DateFormat('hh:mm a')
                                      .format(DateTime.now()),
                                  'checkOut': checkOut,
                                  // 'checkOut': "--/--",
                                  'checkOutLocation': location,
                                });
                              }

                              // key.currentState!.reset();
                            });
                          }
                        },
                      );
                    }),
                  )
                : Container(
                    margin: const EdgeInsets.only(top: 32, bottom: 32),
                    child: Text(
                      "You have completed this day",
                      style: TextStyle(
                          fontSize: screenWidth / 20,
                          fontWeight: FontWeight.w500,
                          color: Colors.black54),
                    ),
                  ),
            location != " "
                ? Text(
                    "Location: $location",
                  )
                : const SizedBox(),
          ],
        ),
      ),
    );
  }
}
